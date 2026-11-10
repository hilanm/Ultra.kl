import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Products,
  ProductColors,
  ProductSizes,
  ProductImages,
  Customers,
  ShippingAgencies,
  Packages,
  Orders,
  PersonalPurchases,
  MessageTemplates,
  ProductImages,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 13;

  @override
MigrationStrategy get migration => MigrationStrategy(
  onCreate: (Migrator m) async {
    await m.createAll();
    await _seedData();
  },

  onUpgrade: (Migrator m, int from, int to) async {
    // migraciones futuras
  },
);

  Future<void> _seedData() async {
    // Seed shipping agencies
    await into(shippingAgencies).insert(
      ShippingAgenciesCompanion.insert(name: 'Yanwen', contactInfo: Value('yanwen.com')),
    );
    await into(shippingAgencies).insert(
      ShippingAgenciesCompanion.insert(name: 'ChinaPost', contactInfo: Value('chinapost.com')),
    );
    await into(shippingAgencies).insert(
      ShippingAgenciesCompanion.insert(name: 'DHL', contactInfo: Value('dhl.com')),
    );

    // Seed message templates
    final templates = [
      ('Compra Realizada', '¡Hola {nombre}! 🎉 Tu pedido de {producto} ha sido realizado exitosamente. En breve comenzamos a prepararlo.', 'Pendiente'),
      ('En Preparación', '¡Hola {nombre}! 📦 Tu {producto} está siendo preparado por nuestro proveedor. Te avisamos cuando esté en camino.', 'En Preparación'),
      ('En Tránsito', '¡Hola {nombre}! ✈️ Tu {producto} está en camino. N° seguimiento: {seguimiento}', 'En Tránsito'),
      ('En Aduanas', '¡Hola {nombre}! 🛃 Tu pedido {producto} está en proceso de aduana. Esto puede tomar algunos días.', 'En Aduanas'),
      ('Centro Distribución', '¡Hola {nombre}! 📍 Tu {producto} llegó al centro de distribución. Pronto te llegará.', 'Centro de Distribución'),
      ('Entregado', '¡Hola {nombre}! ✅ Tu {producto} fue entregado. ¡Esperamos que lo disfrutes! 🙌', 'Entregado'),
    ];
    for (final t in templates) {
      await into(messageTemplates).insert(
        MessageTemplatesCompanion.insert(
          name: t.$1,
          templateContent: t.$2,
          statusTrigger: t.$3,
        ),
      );
    }
  }

  // ─── PRODUCTS ───────────────────────────────────────────────────────────
  Future<List<Product>> getAllProducts() => select(products).get();

  Stream<List<Product>> watchAllProducts() => select(products).watch();

  Future<Product> getProductById(int id) =>
      (select(products)..where((t) => t.id.equals(id))).getSingle();

  Future<int> createProduct(ProductsCompanion entry) =>
      into(products).insert(entry);

  Future<bool> updateProduct(ProductsCompanion entry) =>
      update(products).replace(entry);

  Future<int> deleteProduct(int id) =>
      (delete(products)..where((t) => t.id.equals(id))).go();
      Future<int> importProducts(
  List<Map<String, dynamic>> rows,
) async {
  int imported = 0;

  for (final row in rows) {
    final name =
        row['Nombre']?.toString().trim() ??
        row['name']?.toString().trim() ??
        '';

    if (name.isEmpty) continue;

    final exists =
        await (select(products)
              ..where((t) => t.name.equals(name)))
            .getSingleOrNull();

    if (exists != null) continue;

    await into(products).insert(
      ProductsCompanion.insert(
        name: name,
        description: Value(
          row['Descripción']?.toString() ??
              row['description']?.toString(),
        ),
        category: Value(
          row['Categoría']?.toString() ??
              row['category']?.toString(),
        ),
        weight: Value(
          double.tryParse(
            row['Peso']?.toString() ??
                row['weight']?.toString() ??
                '',
          ),
        ),
        supplierPrice:
            double.tryParse(
              row['PrecioProveedor']?.toString() ??
                  row['supplierPrice']?.toString() ??
                  '',
            ) ??
            0,
        salePrice:
            double.tryParse(
              row['PrecioVenta']?.toString() ??
                  row['salePrice']?.toString() ??
                  '',
            ) ??
            0,
      ),
    );

    imported++;
  }

  return imported;
}

  // ─── PRODUCT COLORS ─────────────────────────────────────────────────────
  Future<List<ProductColor>> getColorsByProduct(int productId) =>
      (select(productColors)..where((t) => t.productId.equals(productId))).get();

  Future<int> createProductColor(ProductColorsCompanion entry) =>
      into(productColors).insert(entry);

  Future<int> deleteProductColor(int id) =>
      (delete(productColors)..where((t) => t.id.equals(id))).go();

  // ─── PRODUCT SIZES ──────────────────────────────────────────────────────
  Future<List<ProductSize>> getSizesByProduct(int productId) =>
      (select(productSizes)..where((t) => t.productId.equals(productId))).get();

  Future<int> createProductSize(ProductSizesCompanion entry) =>
      into(productSizes).insert(entry);

  Future<int> deleteProductSize(int id) =>
      (delete(productSizes)..where((t) => t.id.equals(id))).go();

  Future<int> deleteSizesByProductId(int productId) =>
      (delete(productSizes)..where((t) => t.productId.equals(productId))).go();

  // ─── PRODUCT IMAGES ─────────────────────────────────────────────────────
// ─── PRODUCT IMAGES ─────────────────────────────────────────────────────

Future<List<ProductImage>> getImagesByProduct(int productId) {
  return (select(productImages)
        ..where((t) => t.productId.equals(productId))
        ..orderBy([
          (t) => OrderingTerm(
                expression: t.isPrimary,
                mode: OrderingMode.desc,
              ),
        ]))
      .get();
}

Stream<List<ProductImage>> watchImagesByProduct(int productId) {
  return (select(productImages)
        ..where((t) => t.productId.equals(productId))
        ..orderBy([
          (t) => OrderingTerm(
                expression: t.isPrimary,
                mode: OrderingMode.desc,
              ),
        ]))
      .watch();
}

Future<int> createProductImage(
  ProductImagesCompanion entry,
) {
  return into(productImages).insert(entry);
}

Future<int> deleteProductImage(int id) {
  return (delete(productImages)
        ..where((t) => t.id.equals(id)))
      .go();
}

Future<int> deleteImagesByProduct(int productId) {
  return (delete(productImages)
        ..where((t) => t.productId.equals(productId)))
      .go();
}
  // ─── CUSTOMERS ──────────────────────────────────────────────────────────
  Future<List<Customer>> getAllCustomers() => select(customers).get();

  Stream<List<Customer>> watchAllCustomers() => select(customers).watch();

  Future<Customer> getCustomerById(int id) =>
      (select(customers)..where((t) => t.id.equals(id))).getSingle();

  Future<Customer?> getCustomerByInstagram(String instagram) =>
      (select(customers)..where((t) => t.instagram.equals(instagram))).getSingleOrNull();

  Future<int> createCustomer(CustomersCompanion entry) =>
      into(customers).insert(entry);

  Future<bool> updateCustomer(CustomersCompanion entry) =>
      update(customers).replace(entry);

  Future<int> deleteCustomer(int id) =>
      (delete(customers)..where((t) => t.id.equals(id))).go();

  // ─── ORDERS ─────────────────────────────────────────────────────────────
  Future<List<Order>> getAllOrders() => select(orders).get();

  Stream<List<Order>> watchAllOrders() => select(orders).watch();

  Future<List<Order>> getOrdersByCustomer(int customerId) =>
      (select(orders)..where((t) => t.customerId.equals(customerId))).get();

  Future<List<Order>> getOrdersByPackage(int packageId) =>
      (select(orders)..where((t) => t.packageId.equals(packageId))).get();

  Future<List<Order>> getOrdersByStatus(String status) =>
      (select(orders)..where((t) => t.status.equals(status))).get();

  Future<int> createOrder(OrdersCompanion entry) =>
      into(orders).insert(entry);

  Future<bool> updateOrder(OrdersCompanion entry) =>
      update(orders).replace(entry);

  Future<int> deleteOrder(int id) =>
      (delete(orders)..where((t) => t.id.equals(id))).go();

  // ─── PACKAGES ───────────────────────────────────────────────────────────
  Future<List<Package>> getAllPackages() => select(packages).get();

  Stream<List<Package>> watchAllPackages() => select(packages).watch();

  Future<Package> getPackageById(int id) =>
      (select(packages)..where((t) => t.id.equals(id))).getSingle();

  Future<int> createPackage(PackagesCompanion entry) =>
      into(packages).insert(entry);

  Future<bool> updatePackage(PackagesCompanion entry) =>
      update(packages).replace(entry);

  Future<int> deletePackage(int id) =>
      (delete(packages)..where((t) => t.id.equals(id))).go();

  // ─── SHIPPING AGENCIES ──────────────────────────────────────────────────
  Future<List<ShippingAgency>> getAllAgencies() => select(shippingAgencies).get();

  // ─── PERSONAL PURCHASES ─────────────────────────────────────────────────
  Future<List<PersonalPurchase>> getAllPersonalPurchases() =>
      select(personalPurchases).get();

  Stream<List<PersonalPurchase>> watchAllPersonalPurchases() =>
      select(personalPurchases).watch();

  Future<int> createPersonalPurchase(PersonalPurchasesCompanion entry) =>
      into(personalPurchases).insert(entry);

  Future<bool> updatePersonalPurchase(PersonalPurchasesCompanion entry) =>
      update(personalPurchases).replace(entry);

  Future<int> deletePersonalPurchase(int id) =>
      (delete(personalPurchases)..where((t) => t.id.equals(id))).go();

  // ─── MESSAGE TEMPLATES ──────────────────────────────────────────────────
  Future<List<MessageTemplate>> getAllTemplates() => select(messageTemplates).get();

  Future<List<MessageTemplate>> getTemplatesByStatus(String status) =>
      (select(messageTemplates)..where((t) => t.statusTrigger.equals(status))).get();

  // ─── DASHBOARD STATS ────────────────────────────────────────────────────
  Future<Map<String, double>> getDashboardStats() async {
    final allOrders = await getAllOrders();
    final delivered = allOrders.where((o) => o.status == 'Entregado').toList();
    final active = allOrders.where((o) => !['Entregado', 'Cancelado'].contains(o.status)).toList();
    final allPurchases = await getAllPersonalPurchases();
    final allPkgs = await getAllPackages();

    double totalSales = 0;
    double totalProfit = 0;
    double totalCost = 0;
    for (final o in delivered) {
      totalSales += o.totalValue;
      totalProfit += o.profit;
      totalCost += o.totalValue - o.profit;
    }
    double personalExpenses = allPurchases.fold(0.0, (s, p) => s + p.cost);
    double shippingCosts = allPkgs.fold(0.0, (s, p) => s + p.shippingCost);

    return {
      'totalSales': totalSales,
      'totalProfit': totalProfit - personalExpenses,
      'totalCost': totalCost + shippingCosts + personalExpenses,
      'averageMargin': delivered.isEmpty ? 0 : (totalProfit / totalSales * 100),
      'activeOrders': active.length.toDouble(),
      'activePackages': allPkgs.where((p) => p.logisticStatus != 'Entregado').length.toDouble(),
    };
  }

  Future<List<Map<String, dynamic>>> getTopProducts({int limit = 5}) async {
    final allOrders = await (select(orders)
          ..where((t) => t.status.equals('Entregado')))
        .get();
    final allProducts = await getAllProducts();

    Map<int, Map<String, dynamic>> productStats = {};
    for (final o in allOrders) {
      productStats.putIfAbsent(o.productId, () => {
            'quantity': 0,
            'revenue': 0.0,
            'profit': 0.0,
          });
      productStats[o.productId]!['quantity'] =
          (productStats[o.productId]!['quantity'] as int) + o.quantity;
      productStats[o.productId]!['revenue'] =
          (productStats[o.productId]!['revenue'] as double) + o.totalValue;
      productStats[o.productId]!['profit'] =
          (productStats[o.productId]!['profit'] as double) + o.profit;
    }

    List<Map<String, dynamic>> result = [];
    for (final entry in productStats.entries) {
      final product = allProducts.firstWhere(
        (p) => p.id == entry.key,
        orElse: () => allProducts.first,
      );
      result.add({
        'product': product,
        ...entry.value,
        'margin': entry.value['revenue'] > 0
            ? (entry.value['profit'] / entry.value['revenue'] * 100)
            : 0.0,
      });
    }
    result.sort((a, b) =>
        (b['quantity'] as int).compareTo(a['quantity'] as int));
    return result.take(limit).toList();
  }

  Future<List<Map<String, dynamic>>> getMonthlySales() async {
    final allOrders = await getAllOrders();
    Map<String, Map<String, double>> monthly = {};
    for (final o in allOrders) {
      if (o.status == 'Entregado') {
        final key =
            '${o.createdAt.year}-${o.createdAt.month.toString().padLeft(2, '0')}';
        monthly.putIfAbsent(key, () => {'sales': 0, 'profit': 0});
        monthly[key]!['sales'] = (monthly[key]!['sales']! + o.totalValue);
        monthly[key]!['profit'] = (monthly[key]!['profit']! + o.profit);
      }
    }
    final sorted = monthly.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return sorted.map((e) => {'month': e.key, ...e.value}).toList();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'ultra_kl.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
