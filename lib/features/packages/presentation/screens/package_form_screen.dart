import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';
import 'package:ultra_kl/core/utils/widgets.dart';

class PackageFormScreen extends ConsumerStatefulWidget {
  final int? packageId;
  const PackageFormScreen({super.key, this.packageId});

  @override
  ConsumerState<PackageFormScreen> createState() => _PackageFormScreenState();
}

class _PackageFormScreenState extends ConsumerState<PackageFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _trackingCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _shippingCostCtrl = TextEditingController(text: '0');
  final _realValueCtrl = TextEditingController(text: '0');
  final _saleValueCtrl = TextEditingController(text: '0');
  final _discountCtrl = TextEditingController(text: '0');
  final _notesCtrl = TextEditingController();

  String _status = 'purchase_made';
  ShippingAgency? _selectedAgency;
  List<ShippingAgency> _agencies = [];
  bool _loading = false;

  static const _statuses = [
    'purchase_made', 'supplier_preparing', 'in_china_warehouse', 'left_china',
    'in_transit', 'customs', 'distribution_center', 'out_for_delivery', 'delivered',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    final db = ref.read(databaseProvider);
    _agencies = await db.getAllAgencies();
    if (_agencies.isNotEmpty) _selectedAgency = _agencies.first;

    if (widget.packageId != null) {
      final p = await db.getPackageById(widget.packageId!);
      _trackingCtrl.text = p.trackingNumber ?? '';
      _weightCtrl.text = '${p.packageWeight ?? ''}';
      _shippingCostCtrl.text = '${p.shippingCost}';
      _realValueCtrl.text = '${p.merchandiseRealValue}';
      _saleValueCtrl.text = '${p.merchandiseSaleValue}';
      _discountCtrl.text = '${p.discount}';
      _notesCtrl.text = p.notes ?? '';
      _status = p.logisticStatus;
      if (p.agencyId != null) {
        _selectedAgency = _agencies.firstWhere(
            (a) => a.id == p.agencyId,
            orElse: () => _agencies.first);
      }
    }
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    _trackingCtrl.dispose();
    _weightCtrl.dispose();
    _shippingCostCtrl.dispose();
    _realValueCtrl.dispose();
    _saleValueCtrl.dispose();
    _discountCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.packageId != null ? 'Editar Paquete' : 'Nuevo Paquete'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _trackingCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Número de seguimiento',
                          prefixIcon: Icon(Icons.tag, size: 18),
                        ),
                      ),
                      const SizedBox(height: 14),
                      DropdownButtonFormField<ShippingAgency>(
                        initialValue: _selectedAgency,
                        decoration: const InputDecoration(labelText: 'Agencia de envío'),
                        items: _agencies
                            .map((a) => DropdownMenuItem(value: a, child: Text(a.name)))
                            .toList(),
                        onChanged: (v) => setState(() => _selectedAgency = v),
                      ),
                      const SizedBox(height: 14),
                      DropdownButtonFormField<String>(
                        initialValue: _status,
                        decoration: const InputDecoration(labelText: 'Estado logístico'),
                        items: _statuses
                            .map((s) => DropdownMenuItem(
                                  value: s,
                                  child: Text(AppTheme.statusLabel(s)),
                                ))
                            .toList(),
                        onChanged: (v) => setState(() => _status = v!),
                      ),
                      const SizedBox(height: 20),
                      const Text('Valores',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _weightCtrl,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: const InputDecoration(
                                  labelText: 'Peso (kg)', suffixText: 'kg'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: PriceField(
                                controller: _shippingCostCtrl, label: 'Costo de envío'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: PriceField(
                                controller: _realValueCtrl, label: 'Valor real mercancía'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: PriceField(
                                controller: _saleValueCtrl, label: 'Valor venta mercancía'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      PriceField(controller: _discountCtrl, label: 'Descuento (opcional)'),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _notesCtrl,
                        decoration: const InputDecoration(labelText: 'Notas'),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _save,
                          child: Text(widget.packageId != null
                              ? 'Guardar Cambios'
                              : 'Crear Paquete'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = ref.read(databaseProvider);

    if (widget.packageId != null) {
      await db.updatePackage(PackagesCompanion(
        id: Value(widget.packageId!),
        trackingNumber: Value(_trackingCtrl.text.isEmpty ? null : _trackingCtrl.text.trim()),
        agencyId: Value(_selectedAgency?.id),
        logisticStatus: Value(_status),
        packageWeight: Value(double.tryParse(_weightCtrl.text)),
        shippingCost: Value(double.tryParse(_shippingCostCtrl.text) ?? 0),
        merchandiseRealValue: Value(double.tryParse(_realValueCtrl.text) ?? 0),
        merchandiseSaleValue: Value(double.tryParse(_saleValueCtrl.text) ?? 0),
        discount: Value(double.tryParse(_discountCtrl.text) ?? 0),
        notes: Value(_notesCtrl.text.isEmpty ? null : _notesCtrl.text),
        updatedAt: Value(DateTime.now()),
      ));
    } else {
      await db.createPackage(PackagesCompanion.insert(
        trackingNumber: Value(_trackingCtrl.text.isEmpty ? null : _trackingCtrl.text.trim()),
        agencyId: Value(_selectedAgency?.id),
        logisticStatus: Value(_status),
        packageWeight: Value(double.tryParse(_weightCtrl.text)),
        shippingCost: Value(double.tryParse(_shippingCostCtrl.text) ?? 0),
        merchandiseRealValue: Value(double.tryParse(_realValueCtrl.text) ?? 0),
        merchandiseSaleValue: Value(double.tryParse(_saleValueCtrl.text) ?? 0),
        discount: Value(double.tryParse(_discountCtrl.text) ?? 0),
        notes: Value(_notesCtrl.text.isEmpty ? null : _notesCtrl.text),
      ));
    }
    if (mounted) context.pop();
  }
}
