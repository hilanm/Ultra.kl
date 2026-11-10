import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';
import 'package:ultra_kl/core/utils/widgets.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  final int? productId;
  const ProductFormScreen({super.key, this.productId});

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _supplierPriceCtrl = TextEditingController();
  final _salePriceCtrl = TextEditingController();

  final _sizes = {
    'XS': false,
    'S': false,
    'M': false,
    'L': false,
    'XL': false,
    'XXL': false,
  };

  final List<_ColorEntry> _colors = [];

  // NUEVO
  final List<File> _images = [];

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.productId != null) _loadProduct();
  }

Future<void> _pickImages() async {
  final picker = ImagePicker();

  final files = await picker.pickMultiImage(
    imageQuality: 80,
  );

  if (files.isEmpty) return;

  setState(() {
    _images.addAll(
      files.map((e) => File(e.path)),
    );
  });
}
  Future<void> _loadProduct() async {
    setState(() => _loading = true);
    final db = ref.read(databaseProvider);
    final p = await db.getProductById(widget.productId!);
    _nameCtrl.text = p.name;
    _descCtrl.text = p.description ?? '';
    _categoryCtrl.text = p.category ?? '';
    _weightCtrl.text = '${p.weight ?? ''}';
    _supplierPriceCtrl.text = '${p.supplierPrice}';
    _salePriceCtrl.text = '${p.salePrice}';

    final sizes = await db.getSizesByProduct(p.id);
    for (final s in sizes) {
      if (_sizes.containsKey(s.size)) _sizes[s.size] = true;
    }
    final colors = await db.getColorsByProduct(p.id);
    for (final c in colors) {
      _colors.add(_ColorEntry(name: c.colorName, hex: c.colorHex, id: c.id));
    }
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _categoryCtrl.dispose();
    _weightCtrl.dispose();
    _supplierPriceCtrl.dispose();
    _salePriceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider);
    final isEdit = widget.productId != null;
    final supplierPrice = double.tryParse(_supplierPriceCtrl.text) ?? 0;
    final salePrice = double.tryParse(_salePriceCtrl.text) ?? 0;
    final profit = salePrice - supplierPrice;
    final margin = salePrice > 0 ? (profit / salePrice * 100) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar Producto' : 'Nuevo Producto'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main form
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionTitle('Información Básica', isDark),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _nameCtrl,
                            decoration: const InputDecoration(labelText: 'Nombre del producto *'),
                            validator: (v) => v?.isEmpty == true ? 'Requerido' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _descCtrl,
                            decoration: const InputDecoration(labelText: 'Descripción'),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _categoryCtrl,
                                  decoration: const InputDecoration(labelText: 'Categoría'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _weightCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(labelText: 'Peso (kg)', suffixText: 'kg'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _SectionTitle('Precios', isDark),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: PriceField(
                                  controller: _supplierPriceCtrl,
                                  label: 'Precio Proveedor *',
                                  hint: '0',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PriceField(
                                  controller: _salePriceCtrl,
                                  label: 'Precio Venta *',
                                  hint: '0',
                                ),
                              ),
                            ],
                          ),
                          if (salePrice > 0 || supplierPrice > 0) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: profit >= 0
                                    ? AppTheme.success.withValues(alpha: 0.1)
                                    : AppTheme.error.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    profit >= 0 ? Icons.trending_up : Icons.trending_down,
                                    size: 16,
                                    color: profit >= 0 ? AppTheme.success : AppTheme.error,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Ganancia estimada: \$${profit.toStringAsFixed(0)} (${margin.toStringAsFixed(1)}% margen)',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: profit >= 0 ? AppTheme.success : AppTheme.error,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          _SectionTitle('Tallas Disponibles', isDark),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: _sizes.keys.map((size) {
                              final selected = _sizes[size]!;
                              return FilterChip(
                                label: Text(size),
                                selected: selected,
                                onSelected: (v) => setState(() => _sizes[size] = v),
                                selectedColor: AppTheme.accent.withValues(alpha: 0.15),
                                checkmarkColor: AppTheme.accent,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),

_SectionTitle('Imágenes', isDark),

const SizedBox(height: 12),

SizedBox(
  width: double.infinity,
  child: OutlinedButton.icon(
    onPressed: _pickImages,
    icon: const Icon(Icons.photo_library_outlined),
    label: const Text('Agregar imágenes'),
  ),
),

const SizedBox(height: 12),

if (_images.isNotEmpty)
  SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _images.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              width: 120,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(_images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            if (index == 0)
              Positioned(
                left: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  color: Colors.black54,
                  child: const Text(
                    'Principal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),

            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    _images.removeAt(index);
                  });
                },
              ),
            ),
          ],
        );
      },
    ),
  ),

const SizedBox(height: 24),

_SectionTitle('Colores', isDark),
                          const SizedBox(height: 12),
                          ..._colors.asMap().entries.map((e) {
                            final i = e.key;
                            final color = e.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: _parseColor(color.hex) ?? AppTheme.accent,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      color.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDark ? Colors.white : AppTheme.primary,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, size: 18),
                                    onPressed: () => setState(() => _colors.removeAt(i)),
                                  ),
                                ],
                              ),
                            );
                          }),
                          TextButton.icon(
                            onPressed: _addColor,
                            icon: const Icon(Icons.add, size: 16),
                            label: const Text('Agregar Color'),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _save,
                              child: Text(isEdit ? 'Guardar Cambios' : 'Crear Producto'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Color? _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return null;
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return null;
    }
  }

  Future<void> _addColor() async {
    final nameCtrl = TextEditingController();
    final hexCtrl = TextEditingController(text: '#000000');
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Agregar Color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nombre del color')),
            const SizedBox(height: 12),
            TextField(controller: hexCtrl, decoration: const InputDecoration(labelText: 'Color HEX', hintText: '#000000')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Agregar')),
        ],
      ),
    );
    if (result == true && nameCtrl.text.isNotEmpty) {
      setState(() => _colors.add(_ColorEntry(name: nameCtrl.text, hex: hexCtrl.text)));
    }
  }

  Future<void> _save() async {
  if (!_formKey.currentState!.validate()) return;

  final db = ref.read(databaseProvider);

  if (widget.productId != null) {
    // EDITAR PRODUCTO

    await db.updateProduct(
      ProductsCompanion(
        id: Value(widget.productId!),
        name: Value(_nameCtrl.text.trim()),
        description: Value(
          _descCtrl.text.isEmpty ? null : _descCtrl.text,
        ),
        category: Value(
          _categoryCtrl.text.isEmpty ? null : _categoryCtrl.text,
        ),
        weight: Value(
          double.tryParse(_weightCtrl.text),
        ),
        supplierPrice: Value(
          double.parse(_supplierPriceCtrl.text),
        ),
        salePrice: Value(
          double.parse(_salePriceCtrl.text),
        ),
      ),
    );

    // TALLAS
    await db.deleteSizesByProductId(widget.productId!);

    for (final entry in _sizes.entries) {
      if (entry.value) {
        await db.createProductSize(
          ProductSizesCompanion.insert(
            productId: widget.productId!,
            size: entry.key,
          ),
        );
      }
    }

    // IMÁGENES
    await db.deleteImagesByProduct(widget.productId!);

    for (int i = 0; i < _images.length; i++) {
      await db.createProductImage(
        ProductImagesCompanion.insert(
          productId: widget.productId!,
          imagePath: _images[i].path,
          isPrimary: Value(i == 0),
        ),
      );
    }

  } else {
    // CREAR PRODUCTO

    final productId = await db.createProduct(
      ProductsCompanion.insert(
        name: _nameCtrl.text.trim(),
        description: Value(
          _descCtrl.text.isEmpty ? null : _descCtrl.text,
        ),
        category: Value(
          _categoryCtrl.text.isEmpty ? null : _categoryCtrl.text,
        ),
        weight: Value(
          double.tryParse(_weightCtrl.text),
        ),
        supplierPrice: double.parse(_supplierPriceCtrl.text),
        salePrice: double.parse(_salePriceCtrl.text),
      ),
    );

    // TALLAS
    for (final entry in _sizes.entries) {
      if (entry.value) {
        await db.createProductSize(
          ProductSizesCompanion.insert(
            productId: productId,
            size: entry.key,
          ),
        );
      }
    }

    // COLORES
    for (final c in _colors) {
      await db.createProductColor(
        ProductColorsCompanion.insert(
          productId: productId,
          colorName: c.name,
          colorHex: Value(c.hex),
        ),
      );
    }

    // IMÁGENES
    for (int i = 0; i < _images.length; i++) {
      await db.createProductImage(
        ProductImagesCompanion.insert(
          productId: productId,
          imagePath: _images[i].path,
          isPrimary: Value(i == 0),
        ),
      );
    }
  }

  if (mounted) {
    context.pop();
  }
}
}
class _ColorEntry {
  String name;
  String? hex;
  int? id;

  _ColorEntry({
    required this.name,
    this.hex,
    this.id,
  });
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final bool isDark;
  const _SectionTitle(this.title, this.isDark);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : AppTheme.primary,
      ),
    );
  }
}



