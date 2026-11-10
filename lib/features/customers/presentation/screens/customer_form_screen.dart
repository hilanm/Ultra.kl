import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';

class CustomerFormScreen extends ConsumerStatefulWidget {
  final int? customerId;
  const CustomerFormScreen({super.key, this.customerId});

  @override
  ConsumerState<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends ConsumerState<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _igCtrl = TextEditingController();
  final _obsCtrl = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.customerId != null) _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final c = await ref.read(databaseProvider).getCustomerById(widget.customerId!);
    _nameCtrl.text = c.name;
    _igCtrl.text = c.instagram ?? '';
    _obsCtrl.text = c.observations ?? '';
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _igCtrl.dispose();
    _obsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerId != null ? 'Editar Cliente' : 'Nuevo Cliente'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nombre completo *',
                          prefixIcon: Icon(Icons.person_outline, size: 18),
                        ),
                        validator: (v) => v?.isEmpty == true ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _igCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Instagram',
                          prefixIcon: Icon(Icons.alternate_email, size: 18),
                          hintText: '@usuario',
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _obsCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Observaciones',
                          prefixIcon: Icon(Icons.notes_outlined, size: 18),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _save,
                          child: Text(widget.customerId != null ? 'Guardar Cambios' : 'Crear Cliente'),
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
    if (widget.customerId != null) {
      await db.updateCustomer(CustomersCompanion(
        id: Value(widget.customerId!),
        name: Value(_nameCtrl.text.trim()),
        instagram: Value(_igCtrl.text.isEmpty ? null : _igCtrl.text.trim()),
        observations: Value(_obsCtrl.text.isEmpty ? null : _obsCtrl.text.trim()),
      ));
    } else {
      await db.createCustomer(CustomersCompanion.insert(
        name: _nameCtrl.text.trim(),
        instagram: Value(_igCtrl.text.isEmpty ? null : _igCtrl.text.trim()),
        observations: Value(_obsCtrl.text.isEmpty ? null : _obsCtrl.text.trim()),
      ));
    }
    if (mounted) context.pop();
  }
}
