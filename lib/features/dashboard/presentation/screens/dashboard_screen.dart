import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';

final _dashboardStatsProvider = FutureProvider<Map<String, double>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getDashboardStats();
});

final _topProductsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getTopProducts(limit: 5);
});

final _monthlySalesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getMonthlySales();
});

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final PageController _carouselController = PageController();
  int _currentPage = 0;
  Timer? _carouselTimer;

  @override
  void initState() {
    super.initState();
    _startCarousel();
  }

  void _startCarousel() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      final topProducts = ref.read(_topProductsProvider).valueOrNull;
      if (topProducts != null && topProducts.isNotEmpty) {
        final next = (_currentPage + 1) % topProducts.length;
        _carouselController.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() => _currentPage = next);
      }
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(_dashboardStatsProvider);
    final topProductsAsync = ref.watch(_topProductsProvider);
    final monthlySalesAsync = ref.watch(_monthlySalesProvider);
    final isDark = ref.watch(themeModeProvider);
    final fmt = NumberFormat.currency(locale: 'es_CL', symbol: '\$', decimalDigits: 0, customPattern: '\u00a4#,##0');

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('Dashboard'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  DateFormat('EEEE, d MMMM yyyy', 'es').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white54 : AppTheme.primary.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Carousel
                topProductsAsync.when(
                  data: (products) => products.isEmpty
                      ? _EmptyCarousel(isDark: isDark)
                      : _ProductCarousel(
                          products: products,
                          controller: _carouselController,
                          currentPage: _currentPage,
                          onPageChanged: (i) => setState(() => _currentPage = i),
                          fmt: fmt,
                        ),
                  loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
                  error: (e, _) => _EmptyCarousel(isDark: isDark),
                ),
                const SizedBox(height: 24),
                // KPI Grid
                statsAsync.when(
                  data: (stats) => _KpiGrid(stats: stats, fmt: fmt, isDark: isDark),
                  loading: () => const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
                  error: (e, _) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 24),
                // Charts row
                LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth > 900) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: monthlySalesAsync.when(
                            data: (data) => _SalesChart(data: data, isDark: isDark),
                            loading: () => const SizedBox(height: 260, child: Center(child: CircularProgressIndicator())),
                            error: (e, _) => const SizedBox.shrink(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: topProductsAsync.when(
                            data: (products) => _TopProductsCard(products: products, fmt: fmt, isDark: isDark),
                            loading: () => const SizedBox(height: 260, child: Center(child: CircularProgressIndicator())),
                            error: (e, _) => const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      monthlySalesAsync.when(
                        data: (data) => _SalesChart(data: data, isDark: isDark),
                        loading: () => const SizedBox(height: 260, child: Center(child: CircularProgressIndicator())),
                        error: (e, _) => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 16),
                      topProductsAsync.when(
                        data: (products) => _TopProductsCard(products: products, fmt: fmt, isDark: isDark),
                        loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
                        error: (e, _) => const SizedBox.shrink(),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 24),
                // Business Intelligence
                statsAsync.when(
                  data: (stats) => topProductsAsync.when(
                    data: (products) => _BiCard(stats: stats, topProducts: products, isDark: isDark),
                    loading: () => const SizedBox.shrink(),
                    error: (e, _) => const SizedBox.shrink(),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (e, _) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCarousel extends StatelessWidget {
  final bool isDark;
  const _EmptyCarousel({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.accent, AppTheme.accent.withValues(alpha: 0.6)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, color: Colors.white54, size: 40),
            SizedBox(height: 12),
            Text('Sin productos vendidos aún', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class _ProductCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final PageController controller;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final NumberFormat fmt;

  const _ProductCarousel({
    required this.products,
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
    required this.fmt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: controller,
            onPageChanged: onPageChanged,
            itemCount: products.length,
            itemBuilder: (context, i) {
              final item = products[i];
              final product = item['product'] as Product;
              final margin = (item['margin'] as double).toStringAsFixed(1);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.accent,
                      AppTheme.accent.withValues(alpha: 0.7),
                      const Color(0xFF4F46E5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '#${i + 1} Más Vendido',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            product.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              _StatBadge(label: 'Vendidos', value: '${item['quantity']}'),
                              const SizedBox(width: 12),
                              _StatBadge(label: 'Ingresos', value: fmt.format(item['revenue'])),
                              const SizedBox(width: 12),
                              _StatBadge(label: 'Margen', value: '$margin%'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: products.asMap().entries.map((e) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: e.key == currentPage ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: e.key == currentPage ? AppTheme.accent : AppTheme.accent.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final String value;
  const _StatBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 11)),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _KpiGrid extends StatelessWidget {
  final Map<String, double> stats;
  final NumberFormat fmt;
  final bool isDark;
  const _KpiGrid({required this.stats, required this.fmt, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final kpis = [
      _KpiData('Ventas Totales', fmt.format(stats['totalSales'] ?? 0), Icons.trending_up, AppTheme.success),
      _KpiData('Ganancias Netas', fmt.format(stats['totalProfit'] ?? 0), Icons.attach_money, AppTheme.accent),
      _KpiData('Costes Totales', fmt.format(stats['totalCost'] ?? 0), Icons.money_off, AppTheme.error),
      _KpiData('Margen Promedio', '${(stats['averageMargin'] ?? 0).toStringAsFixed(1)}%', Icons.percent, AppTheme.warning),
      _KpiData('Pedidos Activos', '${(stats['activeOrders'] ?? 0).toInt()}', Icons.receipt_long_outlined, AppTheme.info),
      _KpiData('Paquetes Activos', '${(stats['activePackages'] ?? 0).toInt()}', Icons.local_shipping_outlined, const Color(0xFF8B5CF6)),
    ];

    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisCount = constraints.maxWidth > 900
          ? 6
          : constraints.maxWidth > 600
              ? 3
              : 2;
      return GridView.count(
        crossAxisCount: crossAxisCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
        children: kpis.map((kpi) => _KpiCard(kpi: kpi, isDark: isDark)).toList(),
      );
    });
  }
}

class _KpiData {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _KpiData(this.label, this.value, this.icon, this.color);
}

class _KpiCard extends StatelessWidget {
  final _KpiData kpi;
  final bool isDark;
  const _KpiCard({required this.kpi, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? AppTheme.borderDark : AppTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: kpi.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(kpi.icon, size: 16, color: kpi.color),
              ),
            ],
          ),
          const Spacer(),
          Text(
            kpi.value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppTheme.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            kpi.label,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white38 : AppTheme.primary.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final bool isDark;
  const _SalesChart({required this.data, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? AppTheme.borderDark : AppTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ventas Mensuales',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppTheme.primary,
              )),
          const SizedBox(height: 4),
          Text('Últimos meses',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white38 : AppTheme.primary.withValues(alpha: 0.5),
              )),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: data.isEmpty
                ? Center(
                    child: Text(
                      'Sin datos de ventas aún',
                      style: TextStyle(
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ),
                  )
                : LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: isDark ? Colors.white10 : Colors.black12,
                          strokeWidth: 1,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 24,
                            getTitlesWidget: (value, meta) {
                              final idx = value.toInt();
                              if (idx < 0 || idx >= data.length) return const SizedBox.shrink();
                              final parts = (data[idx]['month'] as String).split('-');
                              return Text(
                                parts.length > 1 ? _monthName(int.parse(parts[1])) : '',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark ? Colors.white38 : Colors.black38,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: data.asMap().entries.map((e) =>
                              FlSpot(e.key.toDouble(), (e.value['sales'] as double))).toList(),
                          isCurved: true,
                          color: AppTheme.accent,
                          barWidth: 2.5,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppTheme.accent.withValues(alpha: 0.1),
                          ),
                        ),
                        LineChartBarData(
                          spots: data.asMap().entries.map((e) =>
                              FlSpot(e.key.toDouble(), (e.value['profit'] as double))).toList(),
                          isCurved: true,
                          color: AppTheme.success,
                          barWidth: 2.5,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppTheme.success.withValues(alpha: 0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _ChartLegend(color: AppTheme.accent, label: 'Ventas'),
              const SizedBox(width: 16),
              _ChartLegend(color: AppTheme.success, label: 'Ganancias'),
            ],
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const names = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
    return names[month - 1];
  }
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;
  const _ChartLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 3, color: color, margin: const EdgeInsets.only(right: 6)),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}

class _TopProductsCard extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final NumberFormat fmt;
  final bool isDark;
  const _TopProductsCard({required this.products, required this.fmt, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? AppTheme.borderDark : AppTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Productos',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppTheme.primary,
              )),
          const SizedBox(height: 16),
          if (products.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text('Sin datos aún',
                    style: TextStyle(
                        color: isDark ? Colors.white38 : Colors.black38)),
              ),
            )
          else
            ...products.asMap().entries.map((e) {
              final i = e.key;
              final item = e.value;
              final product = item['product'] as Product;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: i == 0
                            ? AppTheme.warning.withValues(alpha: 0.15)
                            : AppTheme.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: i == 0 ? AppTheme.warning : AppTheme.accent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : AppTheme.primary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${item['quantity']} uds · ${fmt.format(item['revenue'])}',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white38 : Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.success.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${(item['margin'] as double).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.success,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _BiCard extends StatelessWidget {
  final Map<String, double> stats;
  final List<Map<String, dynamic>> topProducts;
  final bool isDark;
  const _BiCard({required this.stats, required this.topProducts, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final insights = _generateInsights(stats, topProducts);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? AppTheme.borderDark : AppTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.auto_awesome, size: 16, color: AppTheme.accent),
              ),
              const SizedBox(width: 10),
              Text(
                'Business Intelligence',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : AppTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: insights.map((insight) => _InsightChip(insight: insight, isDark: isDark)).toList(),
          ),
        ],
      ),
    );
  }

  List<_Insight> _generateInsights(Map<String, double> stats, List<Map<String, dynamic>> products) {
    final insights = <_Insight>[];
    final margin = stats['averageMargin'] ?? 0;
    final profit = stats['totalProfit'] ?? 0;

    if (margin > 30) {
      insights.add(_Insight('Margen saludable: ${margin.toStringAsFixed(1)}%', AppTheme.success, Icons.trending_up));
    } else if (margin > 0) {
      insights.add(_Insight('Margen bajo: revisa precios', AppTheme.warning, Icons.warning_outlined));
    }
    if (products.isNotEmpty) {
      final top = products.first['product'] as Product;
      insights.add(_Insight('Producto estrella: ${top.name}', AppTheme.accent, Icons.star_outline));
    }
    if (profit < 0) {
      insights.add(_Insight('Ganancias negativas: revisa gastos', AppTheme.error, Icons.error_outline));
    }
    final activeOrders = (stats['activeOrders'] ?? 0).toInt();
    if (activeOrders > 10) {
      insights.add(_Insight('$activeOrders pedidos pendientes', AppTheme.warning, Icons.receipt_long_outlined));
    }
    if (insights.isEmpty) {
      insights.add(_Insight('Agrega ventas para ver análisis', const Color(0xFF6B7280), Icons.info_outline));
    }
    return insights;
  }
}

class _Insight {
  final String text;
  final Color color;
  final IconData icon;
  const _Insight(this.text, this.color, this.icon);
}

class _InsightChip extends StatelessWidget {
  final _Insight insight;
  final bool isDark;
  const _InsightChip({required this.insight, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: insight.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: insight.color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(insight.icon, size: 14, color: insight.color),
          const SizedBox(width: 6),
          Text(
            insight.text,
            style: TextStyle(fontSize: 12, color: insight.color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
