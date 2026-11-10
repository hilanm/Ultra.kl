import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';
import 'package:ultra_kl/core/utils/widgets.dart';

class MessagesScreen extends ConsumerStatefulWidget {
  const MessagesScreen({super.key});

  @override
  ConsumerState<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends ConsumerState<MessagesScreen> {
  Order? _selectedOrder;
  String _generatedMessage = '';
  List<Order> _orders = [];
  List<Customer> _customers = [];
  List<Product> _products = [];
  List<Package> _packages = [];
  List<MessageTemplate> _templates = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = ref.read(databaseProvider);
    _orders = await db.getAllOrders();
    _customers = await db.getAllCustomers();
    _products = await db.getAllProducts();
    _packages = await db.getAllPackages();
    _templates = await db.getAllTemplates();
    setState(() => _loading = false);
  }

  void _generateMessage(Order order) {
    final customer = _customers.firstWhere(
        (c) => c.id == order.customerId,
        orElse: () => Customer(
            id: 0, name: 'Cliente', instagram: null, observations: null, createdAt: DateTime.now()));
    final product = _products.firstWhere(
        (p) => p.id == order.productId,
        orElse: () => Product(
            id: 0,
            name: 'Producto',
            description: null,
            category: null,
            weight: null,
            createdAt: DateTime.now(),
            supplierPrice: 0,
            salePrice: 0,
            isActive: true));
    final package = order.packageId != null
        ? _packages.firstWhere((p) => p.id == order.packageId, orElse: () => _packages.first)
        : null;

    final template = _templates.firstWhere(
        (t) => t.statusTrigger == order.status,
        orElse: () => MessageTemplate(
            id: 0,
            name: 'Genérico',
            templateContent:
                '¡Hola {nombre}! Te informamos sobre tu pedido de {producto}.',
            statusTrigger: order.status));

    String msg = template.templateContent
        .replaceAll('{nombre}', customer.name)
        .replaceAll('{producto}', '${product.name} (${order.color} - ${order.size})')
        .replaceAll('{seguimiento}', package?.trackingNumber ?? 'Sin seguimiento');

    setState(() {
      _selectedOrder = order;
      _generatedMessage = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider);

    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Orders list
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageHeader(
                    title: 'Mensajes Automáticos',
                    subtitle: 'Genera mensajes listos para copiar y enviar',
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Selecciona un pedido',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _orders.isEmpty
                        ? const EmptyState(
                            icon: Icons.receipt_long_outlined,
                            title: 'Sin pedidos',
                            subtitle: 'Crea pedidos para generar mensajes',
                          )
                        : ListView.separated(
                            itemCount: _orders.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 6),
                            itemBuilder: (context, i) {
                              final o = _orders[i];
                              final isSelected = _selectedOrder?.id == o.id;
                              final customer = _customers.firstWhere(
                                  (c) => c.id == o.customerId,
                                  orElse: () => Customer(
                                      id: 0,
                                      name: 'Desconocido',
                                      instagram: null,
                                      observations: null,
                                      createdAt: DateTime.now()));
                              final product = _products.firstWhere(
                                  (p) => p.id == o.productId,
                                  orElse: () => Product(
                                      id: 0,
                                      name: 'Desconocido',
                                      description: null,
                                      category: null,
                                      weight: null,
                                      createdAt: DateTime.now(),
                                      supplierPrice: 0,
                                      salePrice: 0,
                                      isActive: true));

                              return InkWell(
                                onTap: () => _generateMessage(o),
                                borderRadius: BorderRadius.circular(10),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppTheme.accent.withValues(alpha: 0.1)
                                        : (isDark ? AppTheme.cardDark : AppTheme.cardLight),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppTheme.accent.withValues(alpha: 0.4)
                                          : (isDark ? AppTheme.borderDark : AppTheme.borderLight),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              customer.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: isSelected
                                                    ? AppTheme.accent
                                                    : (isDark ? Colors.white : AppTheme.primary),
                                              ),
                                            ),
                                            Text(
                                              product.name,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: isDark ? Colors.white38 : Colors.black38,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      StatusBadge(status: o.status),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // Message preview
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mensaje generado',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_selectedOrder == null)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.cardDark : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: isDark ? AppTheme.borderDark : AppTheme.borderLight),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.message_outlined, size: 40, color: Colors.grey),
                              SizedBox(height: 12),
                              Text('Selecciona un pedido para generar el mensaje',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    )
                  else ...[
                    // Template tabs
                    Wrap(
                      spacing: 8,
                      children: _templates.map((t) {
                        final isActive = _selectedOrder?.status == t.statusTrigger;
                        return ActionChip(
                          label: Text(t.name, style: const TextStyle(fontSize: 11)),
                          backgroundColor: isActive
                              ? AppTheme.accent.withValues(alpha: 0.15)
                              : null,
                          onPressed: () {
                            if (_selectedOrder != null) {
                              final fakeOrder = Order(
                                id: _selectedOrder!.id,
                                customerId: _selectedOrder!.customerId,
                                productId: _selectedOrder!.productId,
                                packageId: _selectedOrder!.packageId,
                                size: _selectedOrder!.size,
                                color: _selectedOrder!.color,
                                quantity: _selectedOrder!.quantity,
                                unitValue: _selectedOrder!.unitValue,
                                totalValue: _selectedOrder!.totalValue,
                                profit: _selectedOrder!.profit,
                                status: t.statusTrigger,
                                createdAt: _selectedOrder!.createdAt,
                                updatedAt: _selectedOrder!.updatedAt,
                                deliveryDate: _selectedOrder!.deliveryDate,
                                notes: _selectedOrder!.notes,
                              );
                              _generateMessage(fakeOrder);
                            }
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.cardDark : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: isDark ? AppTheme.borderDark : AppTheme.borderLight),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF25D366).withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.message,
                                      size: 18, color: Color(0xFF25D366)),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Vista previa del mensaje',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.white : AppTheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.05)
                                      : const Color(0xFFF0F0F0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _generatedMessage,
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.5,
                                    color: isDark ? Colors.white : AppTheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: _generatedMessage));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.check, color: Colors.white, size: 16),
                                          SizedBox(width: 8),
                                          Text('Mensaje copiado al portapapeles'),
                                        ],
                                      ),
                                      backgroundColor: AppTheme.success,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.copy, size: 16),
                                label: const Text('COPIAR MENSAJE'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
