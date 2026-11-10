import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';

class MainShell extends ConsumerWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeModeProvider);
    final location = GoRouterState.of(context).uri.toString();
    final isMobile = MediaQuery.of(context).size.width < 768;

    final navItems = [
      _NavItem(Icons.dashboard_outlined, Icons.dashboard, 'Dashboard', '/dashboard'),
      _NavItem(Icons.inventory_2_outlined, Icons.inventory_2, 'Productos', '/products'),
      _NavItem(Icons.people_outline, Icons.people, 'Clientes', '/customers'),
      _NavItem(Icons.receipt_long_outlined, Icons.receipt_long, 'Pedidos', '/orders'),
      _NavItem(Icons.local_shipping_outlined, Icons.local_shipping, 'Paquetes', '/packages'),
      _NavItem(Icons.upload_file_outlined, Icons.upload_file, 'Importar', '/imports'),
      _NavItem(Icons.shopping_bag_outlined, Icons.shopping_bag, 'Personal', '/personal'),
      _NavItem(Icons.message_outlined, Icons.message, 'Mensajes', '/messages'),
      _NavItem(Icons.bar_chart_outlined, Icons.bar_chart, 'Reportes', '/reports'),
    ];

    int selectedIndex = navItems.indexWhere((n) => location.startsWith(n.path));
    if (selectedIndex < 0) selectedIndex = 0;

    return Scaffold(
      body: isMobile
          ? _mobile(context, navItems, selectedIndex)
          : _desktop(context, ref, navItems, selectedIndex, isDark),
    );
  }

  // 📱 MOBILE
  Widget _mobile(
    BuildContext context,
    List<_NavItem> items,
    int index,
  ) {
    return Scaffold(
      body: SizedBox.expand(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => context.go(items[i].path),
        destinations: items.take(5).map((e) {
          return NavigationDestination(
            icon: Icon(e.icon),
            selectedIcon: Icon(e.activeIcon),
            label: e.label,
          );
        }).toList(),
      ),
    );
  }

  // 💻 DESKTOP
  Widget _desktop(
    BuildContext context,
    WidgetRef ref,
    List<_NavItem> items,
    int index,
    bool isDark,
  ) {
    return Row(
      children: [
        // SIDEBAR
        Container(
          width: 220,
          decoration: BoxDecoration(
            color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
            border: Border(
              right: BorderSide(
                color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text(
                'ULTRA.KL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: items.asMap().entries.map((entry) {
                    final i = entry.key;
                    final n = entry.value;
                    final selected = i == index;

                    return _SidebarItem(
                      icon: selected ? n.activeIcon : n.icon,
                      label: n.label,
                      selected: selected,
                      onTap: () => context.go(n.path),
                      color: AppTheme.accent,
                    );
                  }).toList(),
                ),
              ),

              // 🔥 THEME TOGGLE (VISIBLE SIEMPRE)
              Padding(
                padding: const EdgeInsets.all(12),
                child: InkWell(
                  onTap: () {
                    ref.read(themeModeProvider.notifier).update((s) => !s);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark
                            ? AppTheme.borderDark
                            : AppTheme.borderLight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isDark ? Icons.light_mode : Icons.dark_mode,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(isDark ? 'Modo Claro' : 'Modo Oscuro'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // CONTENT
        Expanded(child: SizedBox.expand(child: child)),
      ],
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: selected ? color.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: selected ? color : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected ? color : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String path;

  _NavItem(this.icon, this.activeIcon, this.label, this.path);
}