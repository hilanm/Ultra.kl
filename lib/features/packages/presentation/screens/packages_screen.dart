import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';
import 'package:ultra_kl/core/utils/widgets.dart';

final _packagesProvider = StreamProvider<List<Package>>((ref) {
  return ref.watch(databaseProvider).watchAllPackages();
});

class PackagesScreen extends ConsumerStatefulWidget {
  const PackagesScreen({super.key});

  @override
  ConsumerState<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends ConsumerState<PackagesScreen> {
  String _search = '';
  String? _statusFilter;

  static const _statuses = [
    'purchase_made', 'supplier_preparing', 'in_china_warehouse', 'left_china',
    'in_transit', 'customs', 'distribution_center', 'out_for_delivery', 'delivered',
  ];

  @override
  Widget build(BuildContext context) {
    final packagesAsync = ref.watch(_packagesProvider);
    final isDark = ref.watch(themeModeProvider);
    final fmt = NumberFormat.currency(locale: 'es_CL', symbol: '\$', decimalDigits: 0, customPattern: '\u00a4#,##0');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            PageHeader(
              title: 'Paquetes',
              subtitle: 'Seguimiento de envíos internacionales',
              actions: [
                ElevatedButton.icon(
                  onPressed: () => context.push('/packages/new'),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Nuevo Paquete'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SearchBar2(
                    hint: 'Buscar por número de seguimiento...',
                    onChanged: (v) => setState(() => _search = v),
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String?>(
                  value: _statusFilter,
                  hint: const Text('Todos los estados'),
                  underline: const SizedBox.shrink(),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Todos')),
                    ..._statuses.map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(AppTheme.statusLabel(s)),
                        )),
                  ],
                  onChanged: (v) => setState(() => _statusFilter = v),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: packagesAsync.when(
                data: (packages) {
                  final filtered = packages.where((p) {
                    final matchSearch = _search.isEmpty ||
                        '${p.id}'.contains(_search) ||
                        (p.trackingNumber?.toLowerCase().contains(_search.toLowerCase()) ?? false);
                    final matchStatus = _statusFilter == null || p.logisticStatus == _statusFilter;
                    return matchSearch && matchStatus;
                  }).toList();

                  if (filtered.isEmpty) {
                    return EmptyState(
                      icon: Icons.local_shipping_outlined,
                      title: 'Sin paquetes',
                      subtitle: 'Registra tus envíos para hacer seguimiento',
                      actionLabel: 'Nuevo Paquete',
                      onAction: () => context.push('/packages/new'),
                    );
                  }

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) => _PackageCard(
                      package: filtered[i],
                      fmt: fmt,
                      isDark: isDark,
                      onEdit: () => context.push('/packages/${filtered[i].id}/edit'),
                      onDelete: () => _delete(filtered[i]),
                    ),
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

  Future<void> _delete(Package p) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Eliminar Paquete',
      message: '¿Deseas eliminar el paquete #${p.id}?',
    );
    if (confirmed == true && mounted) {
      await ref.read(databaseProvider).deletePackage(p.id);
    }
  }
}

class _PackageCard extends StatelessWidget {
  final Package package;
  final NumberFormat fmt;
  final bool isDark;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _PackageCard({
    required this.package,
    required this.fmt,
    required this.isDark,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = AppTheme.statusColor(package.logisticStatus);

    return UltraCard(
      onTap: onEdit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.local_shipping_outlined,
                    size: 22, color: statusColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Paquete #${package.id}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : AppTheme.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        StatusBadge(status: package.logisticStatus),
                      ],
                    ),
                    if (package.trackingNumber != null)
                      Row(
                        children: [
                          Icon(Icons.tag, size: 12, color: isDark ? Colors.white38 : Colors.black38),
                          const SizedBox(width: 4),
                          Text(
                            package.trackingNumber!,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: isDark ? Colors.white38 : Colors.black45,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert,
                    size: 18,
                    color: isDark ? Colors.white38 : Colors.black38),
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'edit', child: Text('Editar')),
                  const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                ],
                onSelected: (v) {
                  if (v == 'edit') onEdit();
                  if (v == 'delete') onDelete();
                },
              ),
            ],
          ),
          if (package.shippingCost > 0 || package.merchandiseSaleValue > 0) ...[
            const Divider(height: 20),
            Row(
              children: [
                _Stat('Costo Envío', fmt.format(package.shippingCost), isDark),
                const SizedBox(width: 24),
                _Stat('Valor Mercancía', fmt.format(package.merchandiseSaleValue), isDark),
                if (package.packageWeight != null) ...[
                  const SizedBox(width: 24),
                  _Stat('Peso', '${package.packageWeight!.toStringAsFixed(2)} kg', isDark),
                ],
              ],
            ),
          ],
          // Progress bar
          const SizedBox(height: 12),
          _StatusProgress(status: package.logisticStatus),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;
  const _Stat(this.label, this.value, this.isDark);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 10,
                color: isDark ? Colors.white38 : Colors.black38)),
        Text(value,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppTheme.primary)),
      ],
    );
  }
}

class _StatusProgress extends StatelessWidget {
  final String status;
  const _StatusProgress({required this.status});

  static const _steps = [
    'purchase_made', 'supplier_preparing', 'in_china_warehouse',
    'left_china', 'in_transit', 'customs', 'distribution_center',
    'out_for_delivery', 'delivered',
  ];

  @override
  Widget build(BuildContext context) {
    final current = _steps.indexOf(status);
    final progress = current < 0 ? 0.0 : (current + 1) / _steps.length;
    final color = AppTheme.statusColor(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: color.withValues(alpha: 0.15),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppTheme.statusLabel(status),
          style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
