import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';
import 'package:ultra_kl/core/utils/widgets.dart';

class StatusBadge extends StatelessWidget {
  final String? status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  String _normalize(String? s) {
    return (s ?? 'Pendiente').toLowerCase();
  }

  Color _color(String status) {
    switch (status) {
      case 'pendiente':
        return Colors.grey;

      case 'comprado':
        return Colors.blue;

      case 'preparando envío':
        return Colors.purple;

      case 'en tránsito':
        return Colors.orange;

      case 'aduanas':
        return Colors.amber;

      case 'centro de distribución':
        return Colors.teal;

      case 'entregado':
        return AppTheme.success;

      case 'cancelado':
        return AppTheme.error;

      default:
        return Colors.grey;
    }
  }

  String _label(String status) {
    switch (status) {
      case 'pendiente':
        return 'Pendiente';

      case 'comprado':
        return 'Comprado';

      case 'preparando envío':
        return 'Preparando envío';

      case 'en tránsito':
        return 'En tránsito';

      case 'aduanas':
        return 'Aduanas';

      case 'centro de distribución':
        return 'Centro de distribución';

      case 'entregado':
        return 'Entregado';

      case 'cancelado':
        return 'Cancelado';

      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final normalized = _normalize(status);
    final color = _color(normalized);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        _label(normalized),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

final _ordersProvider = StreamProvider<List<Order>>((ref) {
  return ref.watch(databaseProvider).watchAllOrders();
});

final _allCustomersProvider = FutureProvider<List<Customer>>((ref) =>
    ref.watch(databaseProvider).getAllCustomers());

final _allProductsProvider = FutureProvider<List<Product>>((ref) =>
    ref.watch(databaseProvider).getAllProducts());

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  String _search = '';
  String? _statusFilter;

  static const List<String> _statuses = [
    'Pendiente', 
    'Comprado',
    'Preparando envío',
    'En tránsito',
    'Aduanas',
    'Centro de distribución',
    'Entregado',
    'Cancelado',
  ];

  
static const Map<String, String> statusLabels = {
  'Pendiente': 'pending',
  'Comprado': 'purchased',
  'Preparando envío': 'preparing_shipment',
  'En tránsito': 'in_transit',
  'Aduanas': 'customs',
  'Centro de distribución': 'distribution_center',
  'Entregado': 'delivered',
  'Cancelado': 'cancelled',
};

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(_ordersProvider);
    final customersAsync = ref.watch(_allCustomersProvider);
    final productsAsync = ref.watch(_allProductsProvider);
    final isDark = ref.watch(themeModeProvider);
    final fmt = NumberFormat.currency(locale: 'es_CL', symbol: '\$',  decimalDigits: 0,customPattern: '\u00a4#,##0');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            PageHeader(
              title: 'Pedidos',
              subtitle: 'Gestiona todos los pedidos',
              actions: [
                ElevatedButton.icon(
                  onPressed: () => context.push('/orders/new'),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Nuevo Pedido'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SearchBar2(
                    hint: 'Buscar pedidos...',
                    onChanged: (v) => setState(() => _search = v),
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 220),
                child: DropdownButton<String?>(
                  value: _statuses.contains(_statusFilter) ? _statusFilter : null,
                  hint: const Text('Todos los estados'),
                  underline: const SizedBox.shrink(),
                  isExpanded: true,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Todos'),
                    ),
                    ..._statuses.map((s) => DropdownMenuItem<String>(
                      value: s,
                      child: Text(statusLabels[s]?? s),
                    )),
                  ],
                  onChanged: (v) {
                    setState(() { 
                      _statusFilter = v; 
                      });
                  }
                ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ordersAsync.when(
                data: (orders) {
                  final customers = customersAsync.valueOrNull ?? [];
                  final products = productsAsync.valueOrNull ?? [];

                  final filtered = orders.where((o) {
                    final customer = customers.firstWhere(
                        (c) => c.id == o.customerId,
                        orElse: () => customers.isNotEmpty ? customers.first : _emptyCustomer());
                    final product = products.firstWhere(
                        (p) => p.id == o.productId,
                        orElse: () => products.isNotEmpty ? products.first : _emptyProduct());
                    final matchSearch = _search.isEmpty ||
                        '${o.id}'.contains(_search) ||
                        customer.name.toLowerCase().contains(_search.toLowerCase()) ||
                        product.name.toLowerCase().contains(_search.toLowerCase());
                    final matchStatus = _statusFilter == null || o.status == _statusFilter;
                    return matchSearch && matchStatus;
                  }).toList();

                  if (filtered.isEmpty) {
                    return EmptyState(
                      icon: Icons.receipt_long_outlined,
                      title: 'Sin pedidos',
                      subtitle: 'Crea tu primer pedido para comenzar',
                      actionLabel: 'Nuevo Pedido',
                      onAction: () => context.push('/orders/new'),
                    );
                  }

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final o = filtered[i];
                      final customer = customers.firstWhere(
                          (c) => c.id == o.customerId,
                          orElse: () => _emptyCustomer());
                      final product = products.firstWhere(
                          (p) => p.id == o.productId,
                          orElse: () => _emptyProduct());
                      return _OrderTile(
                        order: o,
                        customer: customer,
                        product: product,
                        fmt: fmt,
                        isDark: isDark,
                        onEdit: () => context.push('/orders/${o.id}/edit'),
                        onDelete: () => _delete(o),
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
  
  Customer _emptyCustomer() => Customer(
      id: 0, name: 'Desconocido', instagram: null, observations: null, createdAt: DateTime.now());

  Product _emptyProduct() => Product(
      id: 0,
      name: 'Desconocido',
      description: null,
      category: null,
      weight: null,
      createdAt: DateTime.now(),
      supplierPrice: 0,
      salePrice: 0,
      isActive: true);

  Future<void> _delete(Order o) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Eliminar Pedido',
      message: '¿Deseas eliminar el pedido #${o.id}?',
    );
    if (confirmed == true && mounted) {
      await ref.read(databaseProvider).deleteOrder(o.id);
    }
  }
}


class _OrderTile extends StatelessWidget {
  final Order order;
  final Customer customer;
  final Product product;
  final NumberFormat fmt;
  final bool isDark;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _OrderTile({
    required this.order,
    required this.customer,
    required this.product,
    required this.fmt,
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '#${order.id}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.accent,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        customer.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : AppTheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    StatusBadge(status: order.status),
                  ],
                ),
                Text(
                  '${product.name} · ${order.color} · ${order.size} · x${order.quantity}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white38 : Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                fmt.format(order.totalValue),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : AppTheme.primary,
                ),
              ),
              Text(
                'Ganancia: ${fmt.format(order.profit)}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.success,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
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