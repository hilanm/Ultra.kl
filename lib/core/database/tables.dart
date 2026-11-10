import 'package:drift/drift.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 200)();

  TextColumn get description => text().nullable()();

  TextColumn get category => text().nullable()();

  RealColumn get weight => real().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  RealColumn get supplierPrice => real()();

  RealColumn get salePrice => real()();

  BoolColumn get isActive =>
      boolean().withDefault(const Constant(true))();
      
  IntColumn get packageId =>
      integer().nullable().references(Packages, #id)();
}

class ProductColors extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId =>
      integer().references(Products, #id)();

  TextColumn get colorName => text()();

  TextColumn get colorHex => text().nullable()();
}

class ProductImages extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId =>
      integer().references(Products, #id)();

  TextColumn get imagePath => text()();

  BoolColumn get isPrimary =>
      boolean().withDefault(const Constant(false))();

  IntColumn get sortOrder =>
      integer().withDefault(const Constant(0))();
}

class ProductSizes extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId =>
      integer().references(Products, #id)();

  TextColumn get size => text()();

  IntColumn get stock =>
      integer().withDefault(const Constant(0))();
}

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name =>
      text().withLength(min: 1, max: 200)();

  TextColumn get instagram => text().nullable()();

  TextColumn get observations => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

class ShippingAgencies extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get contactInfo => text().nullable()();
}

class Packages extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get trackingNumber => text().nullable()();

  IntColumn get agencyId =>
      integer().nullable().references(ShippingAgencies, #id)();

  TextColumn get logisticStatus =>
      text().withDefault(const Constant('purchase_made'))();

  RealColumn get packageWeight => real().nullable()();

  RealColumn get shippingCost =>
      real().withDefault(const Constant(0))();

  RealColumn get merchandiseRealValue =>
      real().withDefault(const Constant(0))();

  RealColumn get merchandiseSaleValue =>
      real().withDefault(const Constant(0))();

  RealColumn get discount =>
      real().withDefault(const Constant(0))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  TextColumn get notes => text().nullable()();
}

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get customerId =>
      integer().references(Customers, #id)();

  IntColumn get productId =>
      integer().references(Products, #id)();

  IntColumn get packageId =>
      integer().nullable().references(Packages, #id)();

  TextColumn get size => text()();

  TextColumn get color => text()();

  IntColumn get quantity =>
      integer().withDefault(const Constant(1))();

  RealColumn get unitValue => real()();

  RealColumn get totalValue => real()();

  RealColumn get profit => real()();

  TextColumn get status =>
      text().withDefault(const Constant('pending'))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get deliveryDate => dateTime().nullable()();

  TextColumn get notes => text().nullable()();
}

class PersonalPurchases extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get productDescription => text()();

  RealColumn get cost => real()();

  DateTimeColumn get purchaseDate =>
      dateTime().withDefault(currentDateAndTime)();

  IntColumn get packageId =>
      integer().nullable().references(Packages, #id)();

  TextColumn get notes => text().nullable()();
}

class MessageTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get templateContent => text()();

  TextColumn get statusTrigger => text()();
}