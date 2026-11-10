import 'package:go_router/go_router.dart';
import 'package:ultra_kl/features/customers/presentation/screens/customer_form_screen.dart';

import 'package:ultra_kl/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:ultra_kl/features/dashboard/presentation/screens/main_shell.dart';
import 'package:ultra_kl/features/orders/presentation/screens/order_form_screen.dart';
import 'package:ultra_kl/features/packages/presentation/screens/package_form_screen.dart';

import 'package:ultra_kl/features/products/presentation/screens/products_screen.dart';
import 'package:ultra_kl/features/products/presentation/screens/product_form_screen.dart';

import 'package:ultra_kl/features/customers/presentation/screens/customers_screen.dart';

import 'package:ultra_kl/features/orders/presentation/screens/orders_screen.dart';

import 'package:ultra_kl/features/packages/presentation/screens/packages_screen.dart';

import 'package:ultra_kl/features/imports/presentation/screens/import_screen.dart';
import 'package:ultra_kl/features/personal/presentation/screens/personal_screen.dart';
import 'package:ultra_kl/features/messages/presentation/screens/messages_screen.dart';
import 'package:ultra_kl/features/reports/presentation/screens/reports_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [

        // DASHBOARD
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),

        // PRODUCTS
        GoRoute(
          path: '/products',
          name: 'products',
          builder: (context, state) => const ProductsScreen(),
          routes: [
            GoRoute(
              path: 'new',
              name: 'product-new',
              builder: (context, state) => const ProductFormScreen(),
            ),
            GoRoute(
              path: ':id/edit',
              name: 'product-edit',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return ProductFormScreen(productId: id);
              },
            ),
          ],
        ),

        // CUSTOMERS
        GoRoute(
          path: '/customers',
          name: 'customers',
          builder: (context, state) => const CustomersScreen(),
          routes: [
            GoRoute(
              path: 'new',
              name: 'customer-new',
              builder: (context, state) => const CustomerFormScreen(),
            ),
            GoRoute(
              path: ':id/edit',
              name: 'customer-edit',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return CustomerFormScreen(customerId: id);
              },
            ),
          ],
        ),

        // ORDERS
                GoRoute(
            path: '/orders',
            name: 'orders',
            builder: (context, state) => const OrdersScreen(),
            routes: [
              GoRoute(
                path: 'new',
                name: 'order-new',
                builder: (context, state) => const OrderFormScreen(),
              ),

            GoRoute(
              path: ':id/edit',
              name: 'order-edit',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return OrderFormScreen(orderId: id);
              },
            ),
          ],
        ),

        // PACKAGES
                  GoRoute(
            path: '/packages',
            name: 'packages',
            builder: (context, state) => const PackagesScreen(),
            routes: [
              GoRoute(
                path: 'new',
                name: 'package-new',
                builder: (context, state) => const PackageFormScreen(),
              ),

              GoRoute(
                path: ':id/edit',
                name: 'package-edit',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return PackageFormScreen(packageId: id);
                },
              ),
            ],
          ),

        // IMPORTS
        GoRoute(
          path: '/imports',
          name: 'imports',
          builder: (context, state) => const ImportScreen(),
        ),

        // PERSONAL
        GoRoute(
          path: '/personal',
          name: 'personal',
          builder: (context, state) => const PersonalScreen(),
        ),

        // MESSAGES
        GoRoute(
          path: '/messages',
          name: 'messages',
          builder: (context, state) => const MessagesScreen(),
        ),

        // REPORTS
        GoRoute(
          path: '/reports',
          name: 'reports',
          builder: (context, state) => const ReportsScreen(),
        ),
      ],
    ),
  ],
);