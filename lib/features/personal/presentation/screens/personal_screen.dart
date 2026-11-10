import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:intl/intl.dart';
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';
import 'package:ultra_kl/core/utils/widgets.dart';


final _personalProvider = StreamProvider<List<PersonalPurchase>>((ref) {
  return ref.watch(databaseProvider).watchAllPersonalPurchases();
});

class PersonalScreen extends ConsumerWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchasesAsync = ref.watch(_personalProvider);
    final isDark = ref.watch(themeModeProvider);
    final fmt = NumberFormat.currency(locale: 'es_CL', symbol: '\$', decimalDigits: 0, customPattern: '\u00a4#,##0');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            PageHeader(
              title: 'Compras Personales',
              subtitle: 'Gastos personales (no se contabilizan como ventas)',
              actions: [
                ElevatedButton.icon(
                  onPressed: () => _showForm(context, ref, null),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Nueva Compra'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            purchasesAsync.when(
              data: (purchases) {
                final totalExpense = purchases.fold(0.0, (s, p) => s + p.cost);
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.error.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.error.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_bag_outlined,
                          size: 20, color: AppTheme.error),
                      const SizedBox(width: 10),
                      Text(
                        'Gasto personal total: ${fmt.format(totalExpense)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.error,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '(${purchases.length} compras)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.error,
                        ),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: purchasesAsync.when(
                data: (purchases) {
                  if (purchases.isEmpty) {
                    return EmptyState(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Sin compras personales',
                      subtitle:
                          'Registra gastos personales para que se descuenten de las ganancias',
                      actionLabel: 'Agregar Compra',
                      onAction: () => _showForm(context, ref, null),
                    );
                  }
                  return ListView.separated(
                    itemCount: purchases.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final p = purchases[i];
                      return UltraCard(
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: AppTheme.error.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.shopping_bag_outlined,
                                  size: 20, color: AppTheme.error),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.productDescription,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: isDark ? Colors.white : AppTheme.primary)),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(p.purchaseDate),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isDark ? Colors.white38 : Colors.black38),
                                  ),
                                  if (p.notes != null)
                                    Text(p.notes!,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: isDark ? Colors.white24 : Colors.black26)),
                                ],
                              ),
                            ),
                            Text(
                              fmt.format(p.cost),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppTheme.error,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, size: 16),
                              onPressed: () => _showForm(context, ref, p),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, size: 16),
                              onPressed: () async {
                                final confirmed = await showConfirmDialog(
                                  context,
                                  title: 'Eliminar Compra',
                                  message: '¿Eliminar "${p.productDescription}"?',
                                );
                                if (confirmed == true) {
                                  await ref
                                      .read(databaseProvider)
                                      .deletePersonalPurchase(p.id);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showForm(
      BuildContext context, WidgetRef ref, PersonalPurchase? existing) async {
    final descCtrl =
        TextEditingController(text: existing?.productDescription ?? '');
    final costCtrl =
        TextEditingController(text: existing != null ? '${existing.cost}' : '');
    final notesCtrl = TextEditingController(text: existing?.notes ?? '');

    final packages = await ref.read(databaseProvider).getAllPackages();
    Package? selectedPkg = existing?.packageId != null
        ? packages.firstWhere((p) => p.id == existing!.packageId,
            orElse: () => packages.first)
        : null;

    if (!context.mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: StatefulBuilder(builder: (ctx2, setS) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  existing != null ? 'Editar Compra' : 'Nueva Compra Personal',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Descripción del producto *'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: costCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      labelText: 'Costo *', prefixText: '\$ '),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<Package?>(
                  initialValue: selectedPkg,
                  decoration: const InputDecoration(labelText: 'Paquete asociado'),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Sin paquete')),
                    ...packages.map((p) => DropdownMenuItem(
                          value: p,
                          child: Text('Paquete #${p.id}'),
                        )),
                  ],
                  onChanged: (v) => setS(() => selectedPkg = v),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesCtrl,
                  decoration: const InputDecoration(labelText: 'Notas'),
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (descCtrl.text.isEmpty || costCtrl.text.isEmpty) return;
                      final cost = double.tryParse(costCtrl.text);
                      if (cost == null) return;
                      final db = ref.read(databaseProvider);
                      if (existing != null) {
                        await db.updatePersonalPurchase(
                            PersonalPurchasesCompanion(
                          id: Value(existing.id),
                          productDescription: Value(descCtrl.text),
                          cost: Value(cost),
                          packageId: Value(selectedPkg?.id),
                          notes: Value(notesCtrl.text.isEmpty
                              ? null
                              : notesCtrl.text),
                        ));
                      } else {
                        await db.createPersonalPurchase(
                            PersonalPurchasesCompanion.insert(
                          productDescription: descCtrl.text,
                          cost: cost,
                          packageId: Value(selectedPkg?.id),
                          notes: Value(notesCtrl.text.isEmpty
                              ? null
                              : notesCtrl.text),
                        ));
                      }
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child:
                        Text(existing != null ? 'Guardar' : 'Agregar Compra'),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            );
          }),
        );
      },
    );
  }
}
