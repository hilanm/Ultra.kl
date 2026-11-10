import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';
import 'package:ultra_kl/core/utils/widgets.dart';

final _customersProvider = StreamProvider<List<Customer>>((ref) {
  return ref.watch(databaseProvider).watchAllCustomers();
});

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(_customersProvider);
    final isDark = ref.watch(themeModeProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            PageHeader(
              title: 'Clientes',
              subtitle: 'Gestiona tu base de clientes',
              actions: [
                ElevatedButton.icon(
                  onPressed: () => context.push('/customers/new'),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Nuevo Cliente'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SearchBar2(
              hint: 'Buscar por nombre o Instagram...',
              onChanged: (v) => setState(() => _search = v),
              isDark: isDark,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: customersAsync.when(
                data: (customers) {
                  final filtered = customers.where((c) {
                    if (_search.isEmpty) return true;
                    final q = _search.toLowerCase();
                    return c.name.toLowerCase().contains(q) ||
                        (c.instagram?.toLowerCase().contains(q) ?? false);
                  }).toList();

                  if (filtered.isEmpty) {
                    return EmptyState(
                      icon: Icons.people_outline,
                      title: 'Sin clientes',
                      subtitle: 'Agrega tu primer cliente para comenzar',
                      actionLabel: 'Agregar Cliente',
                      onAction: () => context.push('/customers/new'),
                    );
                  }

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) => _CustomerTile(
                      customer: filtered[i],
                      isDark: isDark,
                      onEdit: () => context.push('/customers/${filtered[i].id}/edit'),
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

  Future<void> _delete(Customer c) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Eliminar Cliente',
      message: '¿Deseas eliminar a "${c.name}"?',
    );
    if (confirmed == true && mounted) {
      await ref.read(databaseProvider).deleteCustomer(c.id);
    }
  }
}

class _CustomerTile extends StatelessWidget {
  final Customer customer;
  final bool isDark;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CustomerTile({
    required this.customer,
    required this.isDark,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return UltraCard(
      onTap: onEdit,
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppTheme.accent.withValues(alpha: 0.12),
            child: Text(
              customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?',
              style: const TextStyle(
                color: AppTheme.accent,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppTheme.primary,
                  ),
                ),
                if (customer.instagram != null && customer.instagram!.isNotEmpty)
                  Row(
                    children: [
                      Icon(Icons.alternate_email,
                          size: 13,
                          color: isDark ? Colors.white38 : Colors.black38),
                      const SizedBox(width: 4),
                      Text(
                        customer.instagram!,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white38 : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                if (customer.observations != null &&
                    customer.observations!.isNotEmpty)
                  Text(
                    customer.observations!,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white24 : Colors.black26,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
    );
  }
}
