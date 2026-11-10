import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';
import 'package:ultra_kl/core/utils/widgets.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const PageHeader(
              title: 'Reportes',
              subtitle: 'Analítica e inteligencia de negocio',
            ),
            const SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Ventas'),
                Tab(text: 'Ganancias'),
                Tab(text: 'Productos'),
                Tab(text: 'Paquetes'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _SalesReport(isDark: isDark),
                  _ProfitReport(isDark: isDark),
                  _ProductReport(isDark: isDark),
                  _PackageReport(isDark: isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalesReport extends ConsumerWidget {
  final bool isDark;
  const _SalesReport({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _buildData(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data!;
        final fmt = NumberFormat.currency(locale: 'es_CL', symbol: '\$',  decimalDigits: 0,customPattern: '\u00a4#,##0');

        return SingleChildScrollView(
          child: Column(
            children: [
              _ReportKpiRow(
                kpis: [
                  _KpiItem('Ventas Totales', fmt.format(data['totalSales']), AppTheme.success),
                  _KpiItem('Pedidos Totales', '${data['totalOrders']}', AppTheme.accent),
                  _KpiItem('Ticket Promedio', fmt.format(data['avgTicket']), AppTheme.info),
                  _KpiItem('Pedidos Entregados', '${data['deliveredOrders']}', AppTheme.success),
                ],
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              UltraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ventas Mensuales',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : AppTheme.primary)),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: data['monthly'].isEmpty
                          ? const Center(child: Text('Sin datos'))
                          : BarChart(
                              BarChartData(
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  getDrawingHorizontalLine: (v) => FlLine(
                                    color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.08),
                                    strokeWidth: 1,
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  leftTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false)),
                                  rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false)),
                                  topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 24,
                                      getTitlesWidget: (v, m) {
                                        final idx = v.toInt();
                                        final months = data['monthly'] as List;
                                        if (idx < 0 || idx >= months.length) {
                                          return const SizedBox.shrink();
                                        }
                                        final parts =
                                            (months[idx]['month'] as String).split('-');
                                        return Text(
                                          parts.length > 1
                                              ? _mn(int.parse(parts[1]))
                                              : '',
                                          style: const TextStyle(fontSize: 10),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                                barGroups: (data['monthly'] as List)
                                    .asMap()
                                    .entries
                                    .map((e) => BarChartGroupData(
                                          x: e.key,
                                          barRods: [
                                            BarChartRodData(
                                              toY: (e.value['sales'] as double),
                                              color: AppTheme.accent,
                                              width: 16,
                                              borderRadius: const BorderRadius.vertical(
                                                  top: Radius.circular(4)),
                                            ),
                                          ],
                                        ))
                                    .toList(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _mn(int m) {
    const n = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
    return n[m - 1];
  }

  Future<Map<String, dynamic>> _buildData(WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    final orders = await db.getAllOrders();
    final delivered = orders.where((o) => o.status == 'Entregado').toList();
    final monthly = await db.getMonthlySales();
    final total = delivered.fold(0.0, (s, o) => s + o.totalValue);
    return {
      'totalSales': total,
      'totalOrders': orders.length,
      'deliveredOrders': delivered.length,
      'avgTicket': delivered.isEmpty ? 0.0 : total / delivered.length,
      'monthly': monthly,
    };
  }
}

class _ProfitReport extends ConsumerWidget {
  final bool isDark;
  const _ProfitReport({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _buildData(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final data = snapshot.data!;
        final fmt = NumberFormat.currency(locale: 'es_CL', symbol: '\$',  decimalDigits: 0,customPattern: '\u00a4#,##0');

        return SingleChildScrollView(
          child: Column(
            children: [
              _ReportKpiRow(
                kpis: [
                  _KpiItem('Ganancia Bruta', fmt.format(data['grossProfit']), AppTheme.success),
                  _KpiItem('Gastos Envío', fmt.format(data['shippingCost']), AppTheme.error),
                  _KpiItem('Gastos Personal', fmt.format(data['personalCost']), AppTheme.error),
                  _KpiItem('Ganancia Neta', fmt.format(data['netProfit']),
                      (data['netProfit'] as double) >= 0 ? AppTheme.success : AppTheme.error),
                ],
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              UltraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Distribución de costos',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : AppTheme.primary)),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: data['grossProfit'] as double,
                              title: 'Ganancia',
                              color: AppTheme.success,
                              radius: 80,
                              titleStyle: const TextStyle(
                                  fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                            PieChartSectionData(
                              value: data['shippingCost'] as double,
                              title: 'Envío',
                              color: AppTheme.warning,
                              radius: 80,
                              titleStyle: const TextStyle(
                                  fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                            PieChartSectionData(
                              value: data['personalCost'] as double,
                              title: 'Personal',
                              color: AppTheme.error,
                              radius: 80,
                              titleStyle: const TextStyle(
                                  fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<Map<String, dynamic>> _buildData(WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    final stats = await db.getDashboardStats();
    final packages = await db.getAllPackages();
    final personal = await db.getAllPersonalPurchases();
    final grossProfit = stats['totalProfit']! + (personal.fold(0.0, (s, p) => s + p.cost));
    final shippingCost = packages.fold(0.0, (s, p) => s + p.shippingCost);
    final personalCost = personal.fold(0.0, (s, p) => s + p.cost);
    return {
      'grossProfit': grossProfit,
      'shippingCost': shippingCost,
      'personalCost': personalCost,
      'netProfit': grossProfit - shippingCost - personalCost,
    };
  }
}

class _ProductReport extends ConsumerWidget {
  final bool isDark;
  const _ProductReport({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(databaseProvider).getTopProducts(limit: 10),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final products = snapshot.data!;
        final fmt = NumberFormat.currency(locale: 'es_CL', symbol: '\$',  decimalDigits: 0,customPattern: '\u00a4#,##0');

        if (products.isEmpty) {
          return const EmptyState(
            icon: Icons.inventory_2_outlined,
            title: 'Sin datos de productos',
            subtitle: 'Registra ventas para ver estadísticas de productos',
          );
        }

        return ListView.separated(
          itemCount: products.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final item = products[i];
            final product = item['product'] as Product;
            return UltraCard(
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: i == 0
                          ? AppTheme.warning.withValues(alpha: 0.15)
                          : AppTheme.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('${i + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: i == 0 ? AppTheme.warning : AppTheme.accent,
                          )),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : AppTheme.primary)),
                        Text('${item['quantity']} unidades vendidas',
                            style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white38 : Colors.black38)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(fmt.format(item['revenue']),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : AppTheme.primary)),
                      Text('${(item['margin'] as double).toStringAsFixed(1)}% margen',
                          style: const TextStyle(
                              fontSize: 11, color: AppTheme.success)),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _PackageReport extends ConsumerWidget {
  final bool isDark;
  const _PackageReport({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _buildData(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final data = snapshot.data!;
        final fmt = NumberFormat.currency(locale: 'es_CL', symbol: '\$', decimalDigits: 0, customPattern: '\u00a4#,##0');

        return SingleChildScrollView(
          child: Column(
            children: [
              _ReportKpiRow(
                kpis: [
                  _KpiItem('Total Paquetes', '${data['total']}', AppTheme.accent),
                  _KpiItem('Costo Total Envíos', fmt.format(data['totalShipping']), AppTheme.error),
                  _KpiItem('Valor Mercancía', fmt.format(data['totalMerchandise']), AppTheme.success),
                  _KpiItem('Paquetes Entregados', '${data['entregado']}', AppTheme.success),
                ],
                isDark: isDark,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<Map<String, dynamic>> _buildData(WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    final packages = await db.getAllPackages();
    return {
      'total': packages.length,
      'totalShipping': packages.fold(0.0, (s, p) => s + p.shippingCost),
      'totalMerchandise': packages.fold(0.0, (s, p) => s + p.merchandiseSaleValue),
      'delivered': packages.where((p) => p.logisticStatus == 'delivered').length,
    };
  }
}

class _ReportKpiRow extends StatelessWidget {
  final List<_KpiItem> kpis;
  final bool isDark;
  const _ReportKpiRow({required this.kpis, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final count = constraints.maxWidth > 700 ? kpis.length : 2;
      return GridView.count(
        crossAxisCount: count,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.0,
        children: kpis.map((k) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: isDark ? AppTheme.borderDark : AppTheme.borderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(k.label,
                    style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white38 : Colors.black38)),
                const SizedBox(height: 4),
                Text(k.value,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: k.color)),
              ],
            ),
          );
        }).toList(),
      );
    });
  }
}

class _KpiItem {
  final String label;
  final String value;
  final Color color;
  const _KpiItem(this.label, this.value, this.color);
}
