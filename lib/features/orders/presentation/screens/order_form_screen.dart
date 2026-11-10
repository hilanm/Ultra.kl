import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:intl/intl.dart';
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';

class OrderFormScreen extends ConsumerStatefulWidget {
  final int? orderId;
  const OrderFormScreen({super.key, this.orderId});

  @override
  ConsumerState<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends ConsumerState<OrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesCtrl = TextEditingController();
  final _unitValueCtrl = TextEditingController();
  final _quantityCtrl = TextEditingController(text: '1');

  Customer? _selectedCustomer;
  Product? _selectedProduct;
  String? _selectedSize;
  String? _selectedColor;
  String _status = 'pending';
  bool _loading = false;

  List<Customer> _customers = [];
  List<Product> _products = [];
  List<ProductColor> _productColors = [];
  List<ProductSize> _productSizes = [];

  static const _statuses = [
    'Pendiente', 'Comprado', 'Preparando envío', 'En tránsito',
    'Aduanas', 'Centro de distribución', 'Entregado', 'Cancelado',
  ];

  static const _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    final db = ref.read(databaseProvider);
    _customers = await db.getAllCustomers();
    _products = await db.getAllProducts();

    if (widget.orderId != null) {
      final orders = await db.getAllOrders();
      final o = orders.firstWhere((x) => x.id == widget.orderId);
      _selectedCustomer = _customers.firstWhere((c) => c.id == o.customerId,
          orElse: () => _customers.first);
      _selectedProduct = _products.firstWhere((p) => p.id == o.productId,
          orElse: () => _products.first);
      _selectedSize = o.size;
      _selectedColor = o.color;
      _status = o.status;
      _unitValueCtrl.text = '${o.unitValue}';
      _quantityCtrl.text = '${o.quantity}';
      _notesCtrl.text = o.notes ?? '';
      if (_selectedProduct != null) await _loadProductVariants(_selectedProduct!.id);
    }
    setState(() => _loading = false);
  }

  Future<void> _loadProductVariants(int productId) async {
    final db = ref.read(databaseProvider);
    _productColors = await db.getColorsByProduct(productId);
    _productSizes = await db.getSizesByProduct(productId);
    setState(() {});
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    _unitValueCtrl.dispose();
    _quantityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat.currency(locale: 'es_CL', symbol: '\$', decimalDigits: 0, customPattern: '\u00a4#,##0');
    final unitValue = double.tryParse(_unitValueCtrl.text) ?? 0;
    final quantity = int.tryParse(_quantityCtrl.text) ?? 1;
    final total = unitValue * quantity;
    final profit = _selectedProduct != null
        ? (unitValue - _selectedProduct!.supplierPrice) * quantity
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.orderId != null ? 'Editar Pedido' : 'Nuevo Pedido'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Cliente *'),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<Customer>(
                          initialValue: _selectedCustomer,
                          isExpanded: true,
                          decoration: const InputDecoration(
                              hintText: 'Seleccionar cliente'),
                          items: _customers
                              .map((c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(
                                      c.name +
                                          (c.instagram != null
                                              ? ' (@${c.instagram})'
                                              : ''),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedCustomer = v),
                          validator: (v) =>
                              v == null ? 'Selecciona un cliente' : null,
                        ),
                        const SizedBox(height: 16),

                        _label('Producto *'),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<Product>(
                          initialValue: _selectedProduct,
                          isExpanded: true,
                          decoration: const InputDecoration(
                              hintText: 'Seleccionar producto'),
                          items: _products
                              .map((p) => DropdownMenuItem(
                                    value: p,
                                    child: Text(
                                      '${p.name}  —  ${fmt.format(p.salePrice)}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (v) async {
                            setState(() {
                              _selectedProduct = v;
                              _selectedColor = null;
                              _selectedSize = null;
                              _unitValueCtrl.text =
                                  v != null ? '${v.salePrice}' : '';
                            });
                            if (v != null) await _loadProductVariants(v.id);
                          },
                          validator: (v) =>
                              v == null ? 'Selecciona un producto' : null,
                        ),

                        if (_selectedProduct != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.accent.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.info_outline,
                                    size: 16, color: AppTheme.accent),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'Proveedor: ${fmt.format(_selectedProduct!.supplierPrice)}  ·  Venta: ${fmt.format(_selectedProduct!.salePrice)}',
                                    style: const TextStyle(
                                        fontSize: 12, color: AppTheme.accent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),

                        _label('Color *'),
                        const SizedBox(height: 6),
                        _productColors.isNotEmpty
                            ? Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _productColors.map((c) {
                                  final selected =
                                      _selectedColor == c.colorName;
                                  return ChoiceChip(
                                    label: Text(c.colorName),
                                    selected: selected,
                                    onSelected: (_) => setState(
                                        () => _selectedColor = c.colorName),
                                  );
                                }).toList(),
                              )
                            : TextFormField(
                                initialValue: _selectedColor,
                                decoration: const InputDecoration(
                                    hintText: 'Ej: Negro'),
                                onChanged: (v) =>
                                    setState(() => _selectedColor = v),
                                validator: (v) =>
                                    (v == null || v.isEmpty)
                                        ? 'Requerido'
                                        : null,
                              ),

                        const SizedBox(height: 16),
                        _label('Talla *'),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (_productSizes.isNotEmpty
                                  ? _productSizes.map((s) => s.size).toList()
                                  : _sizes)
                              .map((size) {
                            final selected = _selectedSize == size;
                            return ChoiceChip(
                              label: Text(size),
                              selected: selected,
                              onSelected: (_) =>
                                  setState(() => _selectedSize = size),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _quantityCtrl,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText: 'Cantidad'),
                                onChanged: (_) => setState(() {}),
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Requerido';
                                  }
                                  if (int.tryParse(v) == null ||
                                      int.parse(v) < 1) {
                                    return 'Mínimo 1';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _unitValueCtrl,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                decoration: const InputDecoration(
                                    labelText: 'Valor unitario',
                                    prefixText: '\$ '),
                                onChanged: (_) => setState(() {}),
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Requerido';
                                  }
                                  if (double.tryParse(v) == null) {
                                    return 'Número inválido';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),

                        if (total > 0) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppTheme.success.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppTheme.success.withValues(alpha: 0.2)),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text('Total pedido',
                                        style: TextStyle(fontSize: 11)),
                                    Text(fmt.format(total),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text('Ganancia estimada',
                                        style: TextStyle(fontSize: 11)),
                                    Text(
                                      fmt.format(profit),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: profit >= 0
                                            ? AppTheme.success
                                            : AppTheme.error,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 16),
                        _label('Estado'),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          initialValue: _status,
                          isExpanded: true,
                          decoration: const InputDecoration(),
                          items: _statuses
                              .map((s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(AppTheme.statusLabel(s)),
                                  ))
                              .toList(),
                          onChanged: (v) => setState(() => _status = v!),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _notesCtrl,
                          decoration: const InputDecoration(
                              labelText: 'Notas (opcional)'),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _save,
                            child: Text(widget.orderId != null
                                ? 'Guardar Cambios'
                                : 'Crear Pedido'),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _label(String text) => Text(text,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500));

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedColor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecciona un color')));
      return;
    }
    if (_selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecciona una talla')));
      return;
    }

    final db = ref.read(databaseProvider);
    final unitValue = double.parse(_unitValueCtrl.text);
    final quantity = int.parse(_quantityCtrl.text);
    final total = unitValue * quantity;
    final profit =
        (_selectedProduct!.salePrice - _selectedProduct!.supplierPrice) *
            quantity;

    if (widget.orderId != null) {
      await db.updateOrder(OrdersCompanion(
        id: Value(widget.orderId!),
        customerId: Value(_selectedCustomer!.id),
        productId: Value(_selectedProduct!.id),
        size: Value(_selectedSize!),
        color: Value(_selectedColor!),
        quantity: Value(quantity),
        unitValue: Value(unitValue),
        totalValue: Value(total),
        profit: Value(profit),
        status: Value(_status),
        notes: Value(_notesCtrl.text.isEmpty ? null : _notesCtrl.text),
        updatedAt: Value(DateTime.now()),
      ));
    } else {
      await db.createOrder(OrdersCompanion.insert(
        customerId: _selectedCustomer!.id,
        productId: _selectedProduct!.id,
        size: _selectedSize!,
        color: _selectedColor!,
        quantity: Value(quantity),
        unitValue: unitValue,
        totalValue: total,
        profit: profit,
        status: Value(_status),
        notes: Value(_notesCtrl.text.isEmpty ? null : _notesCtrl.text),
      ));
    }
    if (mounted) context.pop();
  }
}