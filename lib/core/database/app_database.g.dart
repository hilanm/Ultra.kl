// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ShippingAgenciesTable extends ShippingAgencies
    with TableInfo<$ShippingAgenciesTable, ShippingAgency> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShippingAgenciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contactInfoMeta =
      const VerificationMeta('contactInfo');
  @override
  late final GeneratedColumn<String> contactInfo = GeneratedColumn<String>(
      'contact_info', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, contactInfo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shipping_agencies';
  @override
  VerificationContext validateIntegrity(Insertable<ShippingAgency> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('contact_info')) {
      context.handle(
          _contactInfoMeta,
          contactInfo.isAcceptableOrUnknown(
              data['contact_info']!, _contactInfoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShippingAgency map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShippingAgency(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      contactInfo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_info']),
    );
  }

  @override
  $ShippingAgenciesTable createAlias(String alias) {
    return $ShippingAgenciesTable(attachedDatabase, alias);
  }
}

class ShippingAgency extends DataClass implements Insertable<ShippingAgency> {
  final int id;
  final String name;
  final String? contactInfo;
  const ShippingAgency(
      {required this.id, required this.name, this.contactInfo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || contactInfo != null) {
      map['contact_info'] = Variable<String>(contactInfo);
    }
    return map;
  }

  ShippingAgenciesCompanion toCompanion(bool nullToAbsent) {
    return ShippingAgenciesCompanion(
      id: Value(id),
      name: Value(name),
      contactInfo: contactInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(contactInfo),
    );
  }

  factory ShippingAgency.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShippingAgency(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      contactInfo: serializer.fromJson<String?>(json['contactInfo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'contactInfo': serializer.toJson<String?>(contactInfo),
    };
  }

  ShippingAgency copyWith(
          {int? id,
          String? name,
          Value<String?> contactInfo = const Value.absent()}) =>
      ShippingAgency(
        id: id ?? this.id,
        name: name ?? this.name,
        contactInfo: contactInfo.present ? contactInfo.value : this.contactInfo,
      );
  ShippingAgency copyWithCompanion(ShippingAgenciesCompanion data) {
    return ShippingAgency(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      contactInfo:
          data.contactInfo.present ? data.contactInfo.value : this.contactInfo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShippingAgency(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactInfo: $contactInfo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, contactInfo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShippingAgency &&
          other.id == this.id &&
          other.name == this.name &&
          other.contactInfo == this.contactInfo);
}

class ShippingAgenciesCompanion extends UpdateCompanion<ShippingAgency> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> contactInfo;
  const ShippingAgenciesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.contactInfo = const Value.absent(),
  });
  ShippingAgenciesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.contactInfo = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ShippingAgency> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? contactInfo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (contactInfo != null) 'contact_info': contactInfo,
    });
  }

  ShippingAgenciesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String?>? contactInfo}) {
    return ShippingAgenciesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      contactInfo: contactInfo ?? this.contactInfo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (contactInfo.present) {
      map['contact_info'] = Variable<String>(contactInfo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShippingAgenciesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactInfo: $contactInfo')
          ..write(')'))
        .toString();
  }
}

class $PackagesTable extends Packages with TableInfo<$PackagesTable, Package> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _trackingNumberMeta =
      const VerificationMeta('trackingNumber');
  @override
  late final GeneratedColumn<String> trackingNumber = GeneratedColumn<String>(
      'tracking_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<int> agencyId = GeneratedColumn<int>(
      'agency_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES shipping_agencies (id)'));
  static const VerificationMeta _logisticStatusMeta =
      const VerificationMeta('logisticStatus');
  @override
  late final GeneratedColumn<String> logisticStatus = GeneratedColumn<String>(
      'logistic_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('purchase_made'));
  static const VerificationMeta _packageWeightMeta =
      const VerificationMeta('packageWeight');
  @override
  late final GeneratedColumn<double> packageWeight = GeneratedColumn<double>(
      'package_weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _shippingCostMeta =
      const VerificationMeta('shippingCost');
  @override
  late final GeneratedColumn<double> shippingCost = GeneratedColumn<double>(
      'shipping_cost', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _merchandiseRealValueMeta =
      const VerificationMeta('merchandiseRealValue');
  @override
  late final GeneratedColumn<double> merchandiseRealValue =
      GeneratedColumn<double>('merchandise_real_value', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _merchandiseSaleValueMeta =
      const VerificationMeta('merchandiseSaleValue');
  @override
  late final GeneratedColumn<double> merchandiseSaleValue =
      GeneratedColumn<double>('merchandise_sale_value', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _discountMeta =
      const VerificationMeta('discount');
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
      'discount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        trackingNumber,
        agencyId,
        logisticStatus,
        packageWeight,
        shippingCost,
        merchandiseRealValue,
        merchandiseSaleValue,
        discount,
        createdAt,
        updatedAt,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'packages';
  @override
  VerificationContext validateIntegrity(Insertable<Package> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tracking_number')) {
      context.handle(
          _trackingNumberMeta,
          trackingNumber.isAcceptableOrUnknown(
              data['tracking_number']!, _trackingNumberMeta));
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    }
    if (data.containsKey('logistic_status')) {
      context.handle(
          _logisticStatusMeta,
          logisticStatus.isAcceptableOrUnknown(
              data['logistic_status']!, _logisticStatusMeta));
    }
    if (data.containsKey('package_weight')) {
      context.handle(
          _packageWeightMeta,
          packageWeight.isAcceptableOrUnknown(
              data['package_weight']!, _packageWeightMeta));
    }
    if (data.containsKey('shipping_cost')) {
      context.handle(
          _shippingCostMeta,
          shippingCost.isAcceptableOrUnknown(
              data['shipping_cost']!, _shippingCostMeta));
    }
    if (data.containsKey('merchandise_real_value')) {
      context.handle(
          _merchandiseRealValueMeta,
          merchandiseRealValue.isAcceptableOrUnknown(
              data['merchandise_real_value']!, _merchandiseRealValueMeta));
    }
    if (data.containsKey('merchandise_sale_value')) {
      context.handle(
          _merchandiseSaleValueMeta,
          merchandiseSaleValue.isAcceptableOrUnknown(
              data['merchandise_sale_value']!, _merchandiseSaleValueMeta));
    }
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount']!, _discountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Package map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Package(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      trackingNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tracking_number']),
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}agency_id']),
      logisticStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}logistic_status'])!,
      packageWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}package_weight']),
      shippingCost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}shipping_cost'])!,
      merchandiseRealValue: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}merchandise_real_value'])!,
      merchandiseSaleValue: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}merchandise_sale_value'])!,
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $PackagesTable createAlias(String alias) {
    return $PackagesTable(attachedDatabase, alias);
  }
}

class Package extends DataClass implements Insertable<Package> {
  final int id;
  final String? trackingNumber;
  final int? agencyId;
  final String logisticStatus;
  final double? packageWeight;
  final double shippingCost;
  final double merchandiseRealValue;
  final double merchandiseSaleValue;
  final double discount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? notes;
  const Package(
      {required this.id,
      this.trackingNumber,
      this.agencyId,
      required this.logisticStatus,
      this.packageWeight,
      required this.shippingCost,
      required this.merchandiseRealValue,
      required this.merchandiseSaleValue,
      required this.discount,
      required this.createdAt,
      required this.updatedAt,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || trackingNumber != null) {
      map['tracking_number'] = Variable<String>(trackingNumber);
    }
    if (!nullToAbsent || agencyId != null) {
      map['agency_id'] = Variable<int>(agencyId);
    }
    map['logistic_status'] = Variable<String>(logisticStatus);
    if (!nullToAbsent || packageWeight != null) {
      map['package_weight'] = Variable<double>(packageWeight);
    }
    map['shipping_cost'] = Variable<double>(shippingCost);
    map['merchandise_real_value'] = Variable<double>(merchandiseRealValue);
    map['merchandise_sale_value'] = Variable<double>(merchandiseSaleValue);
    map['discount'] = Variable<double>(discount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PackagesCompanion toCompanion(bool nullToAbsent) {
    return PackagesCompanion(
      id: Value(id),
      trackingNumber: trackingNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(trackingNumber),
      agencyId: agencyId == null && nullToAbsent
          ? const Value.absent()
          : Value(agencyId),
      logisticStatus: Value(logisticStatus),
      packageWeight: packageWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(packageWeight),
      shippingCost: Value(shippingCost),
      merchandiseRealValue: Value(merchandiseRealValue),
      merchandiseSaleValue: Value(merchandiseSaleValue),
      discount: Value(discount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory Package.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Package(
      id: serializer.fromJson<int>(json['id']),
      trackingNumber: serializer.fromJson<String?>(json['trackingNumber']),
      agencyId: serializer.fromJson<int?>(json['agencyId']),
      logisticStatus: serializer.fromJson<String>(json['logisticStatus']),
      packageWeight: serializer.fromJson<double?>(json['packageWeight']),
      shippingCost: serializer.fromJson<double>(json['shippingCost']),
      merchandiseRealValue:
          serializer.fromJson<double>(json['merchandiseRealValue']),
      merchandiseSaleValue:
          serializer.fromJson<double>(json['merchandiseSaleValue']),
      discount: serializer.fromJson<double>(json['discount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trackingNumber': serializer.toJson<String?>(trackingNumber),
      'agencyId': serializer.toJson<int?>(agencyId),
      'logisticStatus': serializer.toJson<String>(logisticStatus),
      'packageWeight': serializer.toJson<double?>(packageWeight),
      'shippingCost': serializer.toJson<double>(shippingCost),
      'merchandiseRealValue': serializer.toJson<double>(merchandiseRealValue),
      'merchandiseSaleValue': serializer.toJson<double>(merchandiseSaleValue),
      'discount': serializer.toJson<double>(discount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Package copyWith(
          {int? id,
          Value<String?> trackingNumber = const Value.absent(),
          Value<int?> agencyId = const Value.absent(),
          String? logisticStatus,
          Value<double?> packageWeight = const Value.absent(),
          double? shippingCost,
          double? merchandiseRealValue,
          double? merchandiseSaleValue,
          double? discount,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<String?> notes = const Value.absent()}) =>
      Package(
        id: id ?? this.id,
        trackingNumber:
            trackingNumber.present ? trackingNumber.value : this.trackingNumber,
        agencyId: agencyId.present ? agencyId.value : this.agencyId,
        logisticStatus: logisticStatus ?? this.logisticStatus,
        packageWeight:
            packageWeight.present ? packageWeight.value : this.packageWeight,
        shippingCost: shippingCost ?? this.shippingCost,
        merchandiseRealValue: merchandiseRealValue ?? this.merchandiseRealValue,
        merchandiseSaleValue: merchandiseSaleValue ?? this.merchandiseSaleValue,
        discount: discount ?? this.discount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        notes: notes.present ? notes.value : this.notes,
      );
  Package copyWithCompanion(PackagesCompanion data) {
    return Package(
      id: data.id.present ? data.id.value : this.id,
      trackingNumber: data.trackingNumber.present
          ? data.trackingNumber.value
          : this.trackingNumber,
      agencyId: data.agencyId.present ? data.agencyId.value : this.agencyId,
      logisticStatus: data.logisticStatus.present
          ? data.logisticStatus.value
          : this.logisticStatus,
      packageWeight: data.packageWeight.present
          ? data.packageWeight.value
          : this.packageWeight,
      shippingCost: data.shippingCost.present
          ? data.shippingCost.value
          : this.shippingCost,
      merchandiseRealValue: data.merchandiseRealValue.present
          ? data.merchandiseRealValue.value
          : this.merchandiseRealValue,
      merchandiseSaleValue: data.merchandiseSaleValue.present
          ? data.merchandiseSaleValue.value
          : this.merchandiseSaleValue,
      discount: data.discount.present ? data.discount.value : this.discount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Package(')
          ..write('id: $id, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('agencyId: $agencyId, ')
          ..write('logisticStatus: $logisticStatus, ')
          ..write('packageWeight: $packageWeight, ')
          ..write('shippingCost: $shippingCost, ')
          ..write('merchandiseRealValue: $merchandiseRealValue, ')
          ..write('merchandiseSaleValue: $merchandiseSaleValue, ')
          ..write('discount: $discount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      trackingNumber,
      agencyId,
      logisticStatus,
      packageWeight,
      shippingCost,
      merchandiseRealValue,
      merchandiseSaleValue,
      discount,
      createdAt,
      updatedAt,
      notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Package &&
          other.id == this.id &&
          other.trackingNumber == this.trackingNumber &&
          other.agencyId == this.agencyId &&
          other.logisticStatus == this.logisticStatus &&
          other.packageWeight == this.packageWeight &&
          other.shippingCost == this.shippingCost &&
          other.merchandiseRealValue == this.merchandiseRealValue &&
          other.merchandiseSaleValue == this.merchandiseSaleValue &&
          other.discount == this.discount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.notes == this.notes);
}

class PackagesCompanion extends UpdateCompanion<Package> {
  final Value<int> id;
  final Value<String?> trackingNumber;
  final Value<int?> agencyId;
  final Value<String> logisticStatus;
  final Value<double?> packageWeight;
  final Value<double> shippingCost;
  final Value<double> merchandiseRealValue;
  final Value<double> merchandiseSaleValue;
  final Value<double> discount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> notes;
  const PackagesCompanion({
    this.id = const Value.absent(),
    this.trackingNumber = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.logisticStatus = const Value.absent(),
    this.packageWeight = const Value.absent(),
    this.shippingCost = const Value.absent(),
    this.merchandiseRealValue = const Value.absent(),
    this.merchandiseSaleValue = const Value.absent(),
    this.discount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PackagesCompanion.insert({
    this.id = const Value.absent(),
    this.trackingNumber = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.logisticStatus = const Value.absent(),
    this.packageWeight = const Value.absent(),
    this.shippingCost = const Value.absent(),
    this.merchandiseRealValue = const Value.absent(),
    this.merchandiseSaleValue = const Value.absent(),
    this.discount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.notes = const Value.absent(),
  });
  static Insertable<Package> custom({
    Expression<int>? id,
    Expression<String>? trackingNumber,
    Expression<int>? agencyId,
    Expression<String>? logisticStatus,
    Expression<double>? packageWeight,
    Expression<double>? shippingCost,
    Expression<double>? merchandiseRealValue,
    Expression<double>? merchandiseSaleValue,
    Expression<double>? discount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trackingNumber != null) 'tracking_number': trackingNumber,
      if (agencyId != null) 'agency_id': agencyId,
      if (logisticStatus != null) 'logistic_status': logisticStatus,
      if (packageWeight != null) 'package_weight': packageWeight,
      if (shippingCost != null) 'shipping_cost': shippingCost,
      if (merchandiseRealValue != null)
        'merchandise_real_value': merchandiseRealValue,
      if (merchandiseSaleValue != null)
        'merchandise_sale_value': merchandiseSaleValue,
      if (discount != null) 'discount': discount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (notes != null) 'notes': notes,
    });
  }

  PackagesCompanion copyWith(
      {Value<int>? id,
      Value<String?>? trackingNumber,
      Value<int?>? agencyId,
      Value<String>? logisticStatus,
      Value<double?>? packageWeight,
      Value<double>? shippingCost,
      Value<double>? merchandiseRealValue,
      Value<double>? merchandiseSaleValue,
      Value<double>? discount,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? notes}) {
    return PackagesCompanion(
      id: id ?? this.id,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      agencyId: agencyId ?? this.agencyId,
      logisticStatus: logisticStatus ?? this.logisticStatus,
      packageWeight: packageWeight ?? this.packageWeight,
      shippingCost: shippingCost ?? this.shippingCost,
      merchandiseRealValue: merchandiseRealValue ?? this.merchandiseRealValue,
      merchandiseSaleValue: merchandiseSaleValue ?? this.merchandiseSaleValue,
      discount: discount ?? this.discount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trackingNumber.present) {
      map['tracking_number'] = Variable<String>(trackingNumber.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<int>(agencyId.value);
    }
    if (logisticStatus.present) {
      map['logistic_status'] = Variable<String>(logisticStatus.value);
    }
    if (packageWeight.present) {
      map['package_weight'] = Variable<double>(packageWeight.value);
    }
    if (shippingCost.present) {
      map['shipping_cost'] = Variable<double>(shippingCost.value);
    }
    if (merchandiseRealValue.present) {
      map['merchandise_real_value'] =
          Variable<double>(merchandiseRealValue.value);
    }
    if (merchandiseSaleValue.present) {
      map['merchandise_sale_value'] =
          Variable<double>(merchandiseSaleValue.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackagesCompanion(')
          ..write('id: $id, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('agencyId: $agencyId, ')
          ..write('logisticStatus: $logisticStatus, ')
          ..write('packageWeight: $packageWeight, ')
          ..write('shippingCost: $shippingCost, ')
          ..write('merchandiseRealValue: $merchandiseRealValue, ')
          ..write('merchandiseSaleValue: $merchandiseSaleValue, ')
          ..write('discount: $discount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _supplierPriceMeta =
      const VerificationMeta('supplierPrice');
  @override
  late final GeneratedColumn<double> supplierPrice = GeneratedColumn<double>(
      'supplier_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _salePriceMeta =
      const VerificationMeta('salePrice');
  @override
  late final GeneratedColumn<double> salePrice = GeneratedColumn<double>(
      'sale_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _packageIdMeta =
      const VerificationMeta('packageId');
  @override
  late final GeneratedColumn<int> packageId = GeneratedColumn<int>(
      'package_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES packages (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        category,
        weight,
        createdAt,
        supplierPrice,
        salePrice,
        isActive,
        packageId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('supplier_price')) {
      context.handle(
          _supplierPriceMeta,
          supplierPrice.isAcceptableOrUnknown(
              data['supplier_price']!, _supplierPriceMeta));
    } else if (isInserting) {
      context.missing(_supplierPriceMeta);
    }
    if (data.containsKey('sale_price')) {
      context.handle(_salePriceMeta,
          salePrice.isAcceptableOrUnknown(data['sale_price']!, _salePriceMeta));
    } else if (isInserting) {
      context.missing(_salePriceMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('package_id')) {
      context.handle(_packageIdMeta,
          packageId.isAcceptableOrUnknown(data['package_id']!, _packageIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      supplierPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}supplier_price'])!,
      salePrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sale_price'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      packageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}package_id']),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String? description;
  final String? category;
  final double? weight;
  final DateTime createdAt;
  final double supplierPrice;
  final double salePrice;
  final bool isActive;
  final int? packageId;
  const Product(
      {required this.id,
      required this.name,
      this.description,
      this.category,
      this.weight,
      required this.createdAt,
      required this.supplierPrice,
      required this.salePrice,
      required this.isActive,
      this.packageId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['supplier_price'] = Variable<double>(supplierPrice);
    map['sale_price'] = Variable<double>(salePrice);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || packageId != null) {
      map['package_id'] = Variable<int>(packageId);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      createdAt: Value(createdAt),
      supplierPrice: Value(supplierPrice),
      salePrice: Value(salePrice),
      isActive: Value(isActive),
      packageId: packageId == null && nullToAbsent
          ? const Value.absent()
          : Value(packageId),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String?>(json['category']),
      weight: serializer.fromJson<double?>(json['weight']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      supplierPrice: serializer.fromJson<double>(json['supplierPrice']),
      salePrice: serializer.fromJson<double>(json['salePrice']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      packageId: serializer.fromJson<int?>(json['packageId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String?>(category),
      'weight': serializer.toJson<double?>(weight),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'supplierPrice': serializer.toJson<double>(supplierPrice),
      'salePrice': serializer.toJson<double>(salePrice),
      'isActive': serializer.toJson<bool>(isActive),
      'packageId': serializer.toJson<int?>(packageId),
    };
  }

  Product copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> category = const Value.absent(),
          Value<double?> weight = const Value.absent(),
          DateTime? createdAt,
          double? supplierPrice,
          double? salePrice,
          bool? isActive,
          Value<int?> packageId = const Value.absent()}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        category: category.present ? category.value : this.category,
        weight: weight.present ? weight.value : this.weight,
        createdAt: createdAt ?? this.createdAt,
        supplierPrice: supplierPrice ?? this.supplierPrice,
        salePrice: salePrice ?? this.salePrice,
        isActive: isActive ?? this.isActive,
        packageId: packageId.present ? packageId.value : this.packageId,
      );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
      weight: data.weight.present ? data.weight.value : this.weight,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      supplierPrice: data.supplierPrice.present
          ? data.supplierPrice.value
          : this.supplierPrice,
      salePrice: data.salePrice.present ? data.salePrice.value : this.salePrice,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      packageId: data.packageId.present ? data.packageId.value : this.packageId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('weight: $weight, ')
          ..write('createdAt: $createdAt, ')
          ..write('supplierPrice: $supplierPrice, ')
          ..write('salePrice: $salePrice, ')
          ..write('isActive: $isActive, ')
          ..write('packageId: $packageId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, category, weight,
      createdAt, supplierPrice, salePrice, isActive, packageId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.weight == this.weight &&
          other.createdAt == this.createdAt &&
          other.supplierPrice == this.supplierPrice &&
          other.salePrice == this.salePrice &&
          other.isActive == this.isActive &&
          other.packageId == this.packageId);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> category;
  final Value<double?> weight;
  final Value<DateTime> createdAt;
  final Value<double> supplierPrice;
  final Value<double> salePrice;
  final Value<bool> isActive;
  final Value<int?> packageId;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.weight = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.supplierPrice = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.isActive = const Value.absent(),
    this.packageId = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.weight = const Value.absent(),
    this.createdAt = const Value.absent(),
    required double supplierPrice,
    required double salePrice,
    this.isActive = const Value.absent(),
    this.packageId = const Value.absent(),
  })  : name = Value(name),
        supplierPrice = Value(supplierPrice),
        salePrice = Value(salePrice);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? category,
    Expression<double>? weight,
    Expression<DateTime>? createdAt,
    Expression<double>? supplierPrice,
    Expression<double>? salePrice,
    Expression<bool>? isActive,
    Expression<int>? packageId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (weight != null) 'weight': weight,
      if (createdAt != null) 'created_at': createdAt,
      if (supplierPrice != null) 'supplier_price': supplierPrice,
      if (salePrice != null) 'sale_price': salePrice,
      if (isActive != null) 'is_active': isActive,
      if (packageId != null) 'package_id': packageId,
    });
  }

  ProductsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? category,
      Value<double?>? weight,
      Value<DateTime>? createdAt,
      Value<double>? supplierPrice,
      Value<double>? salePrice,
      Value<bool>? isActive,
      Value<int?>? packageId}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      weight: weight ?? this.weight,
      createdAt: createdAt ?? this.createdAt,
      supplierPrice: supplierPrice ?? this.supplierPrice,
      salePrice: salePrice ?? this.salePrice,
      isActive: isActive ?? this.isActive,
      packageId: packageId ?? this.packageId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (supplierPrice.present) {
      map['supplier_price'] = Variable<double>(supplierPrice.value);
    }
    if (salePrice.present) {
      map['sale_price'] = Variable<double>(salePrice.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (packageId.present) {
      map['package_id'] = Variable<int>(packageId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('weight: $weight, ')
          ..write('createdAt: $createdAt, ')
          ..write('supplierPrice: $supplierPrice, ')
          ..write('salePrice: $salePrice, ')
          ..write('isActive: $isActive, ')
          ..write('packageId: $packageId')
          ..write(')'))
        .toString();
  }
}

class $ProductColorsTable extends ProductColors
    with TableInfo<$ProductColorsTable, ProductColor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductColorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _colorNameMeta =
      const VerificationMeta('colorName');
  @override
  late final GeneratedColumn<String> colorName = GeneratedColumn<String>(
      'color_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, productId, colorName, colorHex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_colors';
  @override
  VerificationContext validateIntegrity(Insertable<ProductColor> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('color_name')) {
      context.handle(_colorNameMeta,
          colorName.isAcceptableOrUnknown(data['color_name']!, _colorNameMeta));
    } else if (isInserting) {
      context.missing(_colorNameMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductColor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductColor(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      colorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_name'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex']),
    );
  }

  @override
  $ProductColorsTable createAlias(String alias) {
    return $ProductColorsTable(attachedDatabase, alias);
  }
}

class ProductColor extends DataClass implements Insertable<ProductColor> {
  final int id;
  final int productId;
  final String colorName;
  final String? colorHex;
  const ProductColor(
      {required this.id,
      required this.productId,
      required this.colorName,
      this.colorHex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['color_name'] = Variable<String>(colorName);
    if (!nullToAbsent || colorHex != null) {
      map['color_hex'] = Variable<String>(colorHex);
    }
    return map;
  }

  ProductColorsCompanion toCompanion(bool nullToAbsent) {
    return ProductColorsCompanion(
      id: Value(id),
      productId: Value(productId),
      colorName: Value(colorName),
      colorHex: colorHex == null && nullToAbsent
          ? const Value.absent()
          : Value(colorHex),
    );
  }

  factory ProductColor.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductColor(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      colorName: serializer.fromJson<String>(json['colorName']),
      colorHex: serializer.fromJson<String?>(json['colorHex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'colorName': serializer.toJson<String>(colorName),
      'colorHex': serializer.toJson<String?>(colorHex),
    };
  }

  ProductColor copyWith(
          {int? id,
          int? productId,
          String? colorName,
          Value<String?> colorHex = const Value.absent()}) =>
      ProductColor(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        colorName: colorName ?? this.colorName,
        colorHex: colorHex.present ? colorHex.value : this.colorHex,
      );
  ProductColor copyWithCompanion(ProductColorsCompanion data) {
    return ProductColor(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      colorName: data.colorName.present ? data.colorName.value : this.colorName,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductColor(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('colorName: $colorName, ')
          ..write('colorHex: $colorHex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, colorName, colorHex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductColor &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.colorName == this.colorName &&
          other.colorHex == this.colorHex);
}

class ProductColorsCompanion extends UpdateCompanion<ProductColor> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> colorName;
  final Value<String?> colorHex;
  const ProductColorsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.colorName = const Value.absent(),
    this.colorHex = const Value.absent(),
  });
  ProductColorsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String colorName,
    this.colorHex = const Value.absent(),
  })  : productId = Value(productId),
        colorName = Value(colorName);
  static Insertable<ProductColor> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? colorName,
    Expression<String>? colorHex,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (colorName != null) 'color_name': colorName,
      if (colorHex != null) 'color_hex': colorHex,
    });
  }

  ProductColorsCompanion copyWith(
      {Value<int>? id,
      Value<int>? productId,
      Value<String>? colorName,
      Value<String?>? colorHex}) {
    return ProductColorsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      colorName: colorName ?? this.colorName,
      colorHex: colorHex ?? this.colorHex,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (colorName.present) {
      map['color_name'] = Variable<String>(colorName.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductColorsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('colorName: $colorName, ')
          ..write('colorHex: $colorHex')
          ..write(')'))
        .toString();
  }
}

class $ProductSizesTable extends ProductSizes
    with TableInfo<$ProductSizesTable, ProductSize> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductSizesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
      'size', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, productId, size, stock];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_sizes';
  @override
  VerificationContext validateIntegrity(Insertable<ProductSize> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductSize map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductSize(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}size'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
    );
  }

  @override
  $ProductSizesTable createAlias(String alias) {
    return $ProductSizesTable(attachedDatabase, alias);
  }
}

class ProductSize extends DataClass implements Insertable<ProductSize> {
  final int id;
  final int productId;
  final String size;
  final int stock;
  const ProductSize(
      {required this.id,
      required this.productId,
      required this.size,
      required this.stock});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['size'] = Variable<String>(size);
    map['stock'] = Variable<int>(stock);
    return map;
  }

  ProductSizesCompanion toCompanion(bool nullToAbsent) {
    return ProductSizesCompanion(
      id: Value(id),
      productId: Value(productId),
      size: Value(size),
      stock: Value(stock),
    );
  }

  factory ProductSize.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductSize(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      size: serializer.fromJson<String>(json['size']),
      stock: serializer.fromJson<int>(json['stock']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'size': serializer.toJson<String>(size),
      'stock': serializer.toJson<int>(stock),
    };
  }

  ProductSize copyWith({int? id, int? productId, String? size, int? stock}) =>
      ProductSize(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        size: size ?? this.size,
        stock: stock ?? this.stock,
      );
  ProductSize copyWithCompanion(ProductSizesCompanion data) {
    return ProductSize(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      size: data.size.present ? data.size.value : this.size,
      stock: data.stock.present ? data.stock.value : this.stock,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductSize(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('size: $size, ')
          ..write('stock: $stock')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, size, stock);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductSize &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.size == this.size &&
          other.stock == this.stock);
}

class ProductSizesCompanion extends UpdateCompanion<ProductSize> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> size;
  final Value<int> stock;
  const ProductSizesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.size = const Value.absent(),
    this.stock = const Value.absent(),
  });
  ProductSizesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String size,
    this.stock = const Value.absent(),
  })  : productId = Value(productId),
        size = Value(size);
  static Insertable<ProductSize> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? size,
    Expression<int>? stock,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (size != null) 'size': size,
      if (stock != null) 'stock': stock,
    });
  }

  ProductSizesCompanion copyWith(
      {Value<int>? id,
      Value<int>? productId,
      Value<String>? size,
      Value<int>? stock}) {
    return ProductSizesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      size: size ?? this.size,
      stock: stock ?? this.stock,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductSizesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('size: $size, ')
          ..write('stock: $stock')
          ..write(')'))
        .toString();
  }
}

class $ProductImagesTable extends ProductImages
    with TableInfo<$ProductImagesTable, ProductImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isPrimaryMeta =
      const VerificationMeta('isPrimary');
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
      'is_primary', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_primary" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, productId, imagePath, isPrimary, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_images';
  @override
  VerificationContext validateIntegrity(Insertable<ProductImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('is_primary')) {
      context.handle(_isPrimaryMeta,
          isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductImage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      isPrimary: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_primary'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $ProductImagesTable createAlias(String alias) {
    return $ProductImagesTable(attachedDatabase, alias);
  }
}

class ProductImage extends DataClass implements Insertable<ProductImage> {
  final int id;
  final int productId;
  final String imagePath;
  final bool isPrimary;
  final int sortOrder;
  const ProductImage(
      {required this.id,
      required this.productId,
      required this.imagePath,
      required this.isPrimary,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['image_path'] = Variable<String>(imagePath);
    map['is_primary'] = Variable<bool>(isPrimary);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ProductImagesCompanion toCompanion(bool nullToAbsent) {
    return ProductImagesCompanion(
      id: Value(id),
      productId: Value(productId),
      imagePath: Value(imagePath),
      isPrimary: Value(isPrimary),
      sortOrder: Value(sortOrder),
    );
  }

  factory ProductImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductImage(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'imagePath': serializer.toJson<String>(imagePath),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ProductImage copyWith(
          {int? id,
          int? productId,
          String? imagePath,
          bool? isPrimary,
          int? sortOrder}) =>
      ProductImage(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        imagePath: imagePath ?? this.imagePath,
        isPrimary: isPrimary ?? this.isPrimary,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  ProductImage copyWithCompanion(ProductImagesCompanion data) {
    return ProductImage(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductImage(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('imagePath: $imagePath, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productId, imagePath, isPrimary, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductImage &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.imagePath == this.imagePath &&
          other.isPrimary == this.isPrimary &&
          other.sortOrder == this.sortOrder);
}

class ProductImagesCompanion extends UpdateCompanion<ProductImage> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> imagePath;
  final Value<bool> isPrimary;
  final Value<int> sortOrder;
  const ProductImagesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  ProductImagesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String imagePath,
    this.isPrimary = const Value.absent(),
    this.sortOrder = const Value.absent(),
  })  : productId = Value(productId),
        imagePath = Value(imagePath);
  static Insertable<ProductImage> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? imagePath,
    Expression<bool>? isPrimary,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (imagePath != null) 'image_path': imagePath,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  ProductImagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? productId,
      Value<String>? imagePath,
      Value<bool>? isPrimary,
      Value<int>? sortOrder}) {
    return ProductImagesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      imagePath: imagePath ?? this.imagePath,
      isPrimary: isPrimary ?? this.isPrimary,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductImagesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('imagePath: $imagePath, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _instagramMeta =
      const VerificationMeta('instagram');
  @override
  late final GeneratedColumn<String> instagram = GeneratedColumn<String>(
      'instagram', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _observationsMeta =
      const VerificationMeta('observations');
  @override
  late final GeneratedColumn<String> observations = GeneratedColumn<String>(
      'observations', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, instagram, observations, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('instagram')) {
      context.handle(_instagramMeta,
          instagram.isAcceptableOrUnknown(data['instagram']!, _instagramMeta));
    }
    if (data.containsKey('observations')) {
      context.handle(
          _observationsMeta,
          observations.isAcceptableOrUnknown(
              data['observations']!, _observationsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      instagram: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instagram']),
      observations: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observations']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String? instagram;
  final String? observations;
  final DateTime createdAt;
  const Customer(
      {required this.id,
      required this.name,
      this.instagram,
      this.observations,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || instagram != null) {
      map['instagram'] = Variable<String>(instagram);
    }
    if (!nullToAbsent || observations != null) {
      map['observations'] = Variable<String>(observations);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      instagram: instagram == null && nullToAbsent
          ? const Value.absent()
          : Value(instagram),
      observations: observations == null && nullToAbsent
          ? const Value.absent()
          : Value(observations),
      createdAt: Value(createdAt),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      instagram: serializer.fromJson<String?>(json['instagram']),
      observations: serializer.fromJson<String?>(json['observations']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'instagram': serializer.toJson<String?>(instagram),
      'observations': serializer.toJson<String?>(observations),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Customer copyWith(
          {int? id,
          String? name,
          Value<String?> instagram = const Value.absent(),
          Value<String?> observations = const Value.absent(),
          DateTime? createdAt}) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        instagram: instagram.present ? instagram.value : this.instagram,
        observations:
            observations.present ? observations.value : this.observations,
        createdAt: createdAt ?? this.createdAt,
      );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      instagram: data.instagram.present ? data.instagram.value : this.instagram,
      observations: data.observations.present
          ? data.observations.value
          : this.observations,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('instagram: $instagram, ')
          ..write('observations: $observations, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, instagram, observations, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.instagram == this.instagram &&
          other.observations == this.observations &&
          other.createdAt == this.createdAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> instagram;
  final Value<String?> observations;
  final Value<DateTime> createdAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.instagram = const Value.absent(),
    this.observations = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.instagram = const Value.absent(),
    this.observations = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? instagram,
    Expression<String>? observations,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (instagram != null) 'instagram': instagram,
      if (observations != null) 'observations': observations,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? instagram,
      Value<String?>? observations,
      Value<DateTime>? createdAt}) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      instagram: instagram ?? this.instagram,
      observations: observations ?? this.observations,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (instagram.present) {
      map['instagram'] = Variable<String>(instagram.value);
    }
    if (observations.present) {
      map['observations'] = Variable<String>(observations.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('instagram: $instagram, ')
          ..write('observations: $observations, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _packageIdMeta =
      const VerificationMeta('packageId');
  @override
  late final GeneratedColumn<int> packageId = GeneratedColumn<int>(
      'package_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES packages (id)'));
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
      'size', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _unitValueMeta =
      const VerificationMeta('unitValue');
  @override
  late final GeneratedColumn<double> unitValue = GeneratedColumn<double>(
      'unit_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalValueMeta =
      const VerificationMeta('totalValue');
  @override
  late final GeneratedColumn<double> totalValue = GeneratedColumn<double>(
      'total_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _profitMeta = const VerificationMeta('profit');
  @override
  late final GeneratedColumn<double> profit = GeneratedColumn<double>(
      'profit', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _deliveryDateMeta =
      const VerificationMeta('deliveryDate');
  @override
  late final GeneratedColumn<DateTime> deliveryDate = GeneratedColumn<DateTime>(
      'delivery_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        customerId,
        productId,
        packageId,
        size,
        color,
        quantity,
        unitValue,
        totalValue,
        profit,
        status,
        createdAt,
        updatedAt,
        deliveryDate,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('package_id')) {
      context.handle(_packageIdMeta,
          packageId.isAcceptableOrUnknown(data['package_id']!, _packageIdMeta));
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('unit_value')) {
      context.handle(_unitValueMeta,
          unitValue.isAcceptableOrUnknown(data['unit_value']!, _unitValueMeta));
    } else if (isInserting) {
      context.missing(_unitValueMeta);
    }
    if (data.containsKey('total_value')) {
      context.handle(
          _totalValueMeta,
          totalValue.isAcceptableOrUnknown(
              data['total_value']!, _totalValueMeta));
    } else if (isInserting) {
      context.missing(_totalValueMeta);
    }
    if (data.containsKey('profit')) {
      context.handle(_profitMeta,
          profit.isAcceptableOrUnknown(data['profit']!, _profitMeta));
    } else if (isInserting) {
      context.missing(_profitMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('delivery_date')) {
      context.handle(
          _deliveryDateMeta,
          deliveryDate.isAcceptableOrUnknown(
              data['delivery_date']!, _deliveryDateMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      packageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}package_id']),
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}size'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      unitValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_value'])!,
      totalValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_value'])!,
      profit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}profit'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deliveryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}delivery_date']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final int customerId;
  final int productId;
  final int? packageId;
  final String size;
  final String color;
  final int quantity;
  final double unitValue;
  final double totalValue;
  final double profit;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deliveryDate;
  final String? notes;
  const Order(
      {required this.id,
      required this.customerId,
      required this.productId,
      this.packageId,
      required this.size,
      required this.color,
      required this.quantity,
      required this.unitValue,
      required this.totalValue,
      required this.profit,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      this.deliveryDate,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || packageId != null) {
      map['package_id'] = Variable<int>(packageId);
    }
    map['size'] = Variable<String>(size);
    map['color'] = Variable<String>(color);
    map['quantity'] = Variable<int>(quantity);
    map['unit_value'] = Variable<double>(unitValue);
    map['total_value'] = Variable<double>(totalValue);
    map['profit'] = Variable<double>(profit);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deliveryDate != null) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      customerId: Value(customerId),
      productId: Value(productId),
      packageId: packageId == null && nullToAbsent
          ? const Value.absent()
          : Value(packageId),
      size: Value(size),
      color: Value(color),
      quantity: Value(quantity),
      unitValue: Value(unitValue),
      totalValue: Value(totalValue),
      profit: Value(profit),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deliveryDate: deliveryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryDate),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory Order.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      productId: serializer.fromJson<int>(json['productId']),
      packageId: serializer.fromJson<int?>(json['packageId']),
      size: serializer.fromJson<String>(json['size']),
      color: serializer.fromJson<String>(json['color']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitValue: serializer.fromJson<double>(json['unitValue']),
      totalValue: serializer.fromJson<double>(json['totalValue']),
      profit: serializer.fromJson<double>(json['profit']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deliveryDate: serializer.fromJson<DateTime?>(json['deliveryDate']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'productId': serializer.toJson<int>(productId),
      'packageId': serializer.toJson<int?>(packageId),
      'size': serializer.toJson<String>(size),
      'color': serializer.toJson<String>(color),
      'quantity': serializer.toJson<int>(quantity),
      'unitValue': serializer.toJson<double>(unitValue),
      'totalValue': serializer.toJson<double>(totalValue),
      'profit': serializer.toJson<double>(profit),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deliveryDate': serializer.toJson<DateTime?>(deliveryDate),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Order copyWith(
          {int? id,
          int? customerId,
          int? productId,
          Value<int?> packageId = const Value.absent(),
          String? size,
          String? color,
          int? quantity,
          double? unitValue,
          double? totalValue,
          double? profit,
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deliveryDate = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      Order(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        productId: productId ?? this.productId,
        packageId: packageId.present ? packageId.value : this.packageId,
        size: size ?? this.size,
        color: color ?? this.color,
        quantity: quantity ?? this.quantity,
        unitValue: unitValue ?? this.unitValue,
        totalValue: totalValue ?? this.totalValue,
        profit: profit ?? this.profit,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deliveryDate:
            deliveryDate.present ? deliveryDate.value : this.deliveryDate,
        notes: notes.present ? notes.value : this.notes,
      );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      productId: data.productId.present ? data.productId.value : this.productId,
      packageId: data.packageId.present ? data.packageId.value : this.packageId,
      size: data.size.present ? data.size.value : this.size,
      color: data.color.present ? data.color.value : this.color,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitValue: data.unitValue.present ? data.unitValue.value : this.unitValue,
      totalValue:
          data.totalValue.present ? data.totalValue.value : this.totalValue,
      profit: data.profit.present ? data.profit.value : this.profit,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deliveryDate: data.deliveryDate.present
          ? data.deliveryDate.value
          : this.deliveryDate,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('productId: $productId, ')
          ..write('packageId: $packageId, ')
          ..write('size: $size, ')
          ..write('color: $color, ')
          ..write('quantity: $quantity, ')
          ..write('unitValue: $unitValue, ')
          ..write('totalValue: $totalValue, ')
          ..write('profit: $profit, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      customerId,
      productId,
      packageId,
      size,
      color,
      quantity,
      unitValue,
      totalValue,
      profit,
      status,
      createdAt,
      updatedAt,
      deliveryDate,
      notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.productId == this.productId &&
          other.packageId == this.packageId &&
          other.size == this.size &&
          other.color == this.color &&
          other.quantity == this.quantity &&
          other.unitValue == this.unitValue &&
          other.totalValue == this.totalValue &&
          other.profit == this.profit &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deliveryDate == this.deliveryDate &&
          other.notes == this.notes);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<int> productId;
  final Value<int?> packageId;
  final Value<String> size;
  final Value<String> color;
  final Value<int> quantity;
  final Value<double> unitValue;
  final Value<double> totalValue;
  final Value<double> profit;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deliveryDate;
  final Value<String?> notes;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.productId = const Value.absent(),
    this.packageId = const Value.absent(),
    this.size = const Value.absent(),
    this.color = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitValue = const Value.absent(),
    this.totalValue = const Value.absent(),
    this.profit = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deliveryDate = const Value.absent(),
    this.notes = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required int productId,
    this.packageId = const Value.absent(),
    required String size,
    required String color,
    this.quantity = const Value.absent(),
    required double unitValue,
    required double totalValue,
    required double profit,
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deliveryDate = const Value.absent(),
    this.notes = const Value.absent(),
  })  : customerId = Value(customerId),
        productId = Value(productId),
        size = Value(size),
        color = Value(color),
        unitValue = Value(unitValue),
        totalValue = Value(totalValue),
        profit = Value(profit);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<int>? productId,
    Expression<int>? packageId,
    Expression<String>? size,
    Expression<String>? color,
    Expression<int>? quantity,
    Expression<double>? unitValue,
    Expression<double>? totalValue,
    Expression<double>? profit,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deliveryDate,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (productId != null) 'product_id': productId,
      if (packageId != null) 'package_id': packageId,
      if (size != null) 'size': size,
      if (color != null) 'color': color,
      if (quantity != null) 'quantity': quantity,
      if (unitValue != null) 'unit_value': unitValue,
      if (totalValue != null) 'total_value': totalValue,
      if (profit != null) 'profit': profit,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deliveryDate != null) 'delivery_date': deliveryDate,
      if (notes != null) 'notes': notes,
    });
  }

  OrdersCompanion copyWith(
      {Value<int>? id,
      Value<int>? customerId,
      Value<int>? productId,
      Value<int?>? packageId,
      Value<String>? size,
      Value<String>? color,
      Value<int>? quantity,
      Value<double>? unitValue,
      Value<double>? totalValue,
      Value<double>? profit,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deliveryDate,
      Value<String?>? notes}) {
    return OrdersCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      packageId: packageId ?? this.packageId,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      unitValue: unitValue ?? this.unitValue,
      totalValue: totalValue ?? this.totalValue,
      profit: profit ?? this.profit,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (packageId.present) {
      map['package_id'] = Variable<int>(packageId.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitValue.present) {
      map['unit_value'] = Variable<double>(unitValue.value);
    }
    if (totalValue.present) {
      map['total_value'] = Variable<double>(totalValue.value);
    }
    if (profit.present) {
      map['profit'] = Variable<double>(profit.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deliveryDate.present) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('productId: $productId, ')
          ..write('packageId: $packageId, ')
          ..write('size: $size, ')
          ..write('color: $color, ')
          ..write('quantity: $quantity, ')
          ..write('unitValue: $unitValue, ')
          ..write('totalValue: $totalValue, ')
          ..write('profit: $profit, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PersonalPurchasesTable extends PersonalPurchases
    with TableInfo<$PersonalPurchasesTable, PersonalPurchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalPurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productDescriptionMeta =
      const VerificationMeta('productDescription');
  @override
  late final GeneratedColumn<String> productDescription =
      GeneratedColumn<String>('product_description', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
      'cost', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _purchaseDateMeta =
      const VerificationMeta('purchaseDate');
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
      'purchase_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _packageIdMeta =
      const VerificationMeta('packageId');
  @override
  late final GeneratedColumn<int> packageId = GeneratedColumn<int>(
      'package_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES packages (id)'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productDescription, cost, purchaseDate, packageId, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personal_purchases';
  @override
  VerificationContext validateIntegrity(Insertable<PersonalPurchase> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_description')) {
      context.handle(
          _productDescriptionMeta,
          productDescription.isAcceptableOrUnknown(
              data['product_description']!, _productDescriptionMeta));
    } else if (isInserting) {
      context.missing(_productDescriptionMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost']!, _costMeta));
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
          _purchaseDateMeta,
          purchaseDate.isAcceptableOrUnknown(
              data['purchase_date']!, _purchaseDateMeta));
    }
    if (data.containsKey('package_id')) {
      context.handle(_packageIdMeta,
          packageId.isAcceptableOrUnknown(data['package_id']!, _packageIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonalPurchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalPurchase(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}product_description'])!,
      cost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cost'])!,
      purchaseDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}purchase_date'])!,
      packageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}package_id']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $PersonalPurchasesTable createAlias(String alias) {
    return $PersonalPurchasesTable(attachedDatabase, alias);
  }
}

class PersonalPurchase extends DataClass
    implements Insertable<PersonalPurchase> {
  final int id;
  final String productDescription;
  final double cost;
  final DateTime purchaseDate;
  final int? packageId;
  final String? notes;
  const PersonalPurchase(
      {required this.id,
      required this.productDescription,
      required this.cost,
      required this.purchaseDate,
      this.packageId,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_description'] = Variable<String>(productDescription);
    map['cost'] = Variable<double>(cost);
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    if (!nullToAbsent || packageId != null) {
      map['package_id'] = Variable<int>(packageId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PersonalPurchasesCompanion toCompanion(bool nullToAbsent) {
    return PersonalPurchasesCompanion(
      id: Value(id),
      productDescription: Value(productDescription),
      cost: Value(cost),
      purchaseDate: Value(purchaseDate),
      packageId: packageId == null && nullToAbsent
          ? const Value.absent()
          : Value(packageId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory PersonalPurchase.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalPurchase(
      id: serializer.fromJson<int>(json['id']),
      productDescription:
          serializer.fromJson<String>(json['productDescription']),
      cost: serializer.fromJson<double>(json['cost']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
      packageId: serializer.fromJson<int?>(json['packageId']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productDescription': serializer.toJson<String>(productDescription),
      'cost': serializer.toJson<double>(cost),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
      'packageId': serializer.toJson<int?>(packageId),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PersonalPurchase copyWith(
          {int? id,
          String? productDescription,
          double? cost,
          DateTime? purchaseDate,
          Value<int?> packageId = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      PersonalPurchase(
        id: id ?? this.id,
        productDescription: productDescription ?? this.productDescription,
        cost: cost ?? this.cost,
        purchaseDate: purchaseDate ?? this.purchaseDate,
        packageId: packageId.present ? packageId.value : this.packageId,
        notes: notes.present ? notes.value : this.notes,
      );
  PersonalPurchase copyWithCompanion(PersonalPurchasesCompanion data) {
    return PersonalPurchase(
      id: data.id.present ? data.id.value : this.id,
      productDescription: data.productDescription.present
          ? data.productDescription.value
          : this.productDescription,
      cost: data.cost.present ? data.cost.value : this.cost,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      packageId: data.packageId.present ? data.packageId.value : this.packageId,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonalPurchase(')
          ..write('id: $id, ')
          ..write('productDescription: $productDescription, ')
          ..write('cost: $cost, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('packageId: $packageId, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productDescription, cost, purchaseDate, packageId, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalPurchase &&
          other.id == this.id &&
          other.productDescription == this.productDescription &&
          other.cost == this.cost &&
          other.purchaseDate == this.purchaseDate &&
          other.packageId == this.packageId &&
          other.notes == this.notes);
}

class PersonalPurchasesCompanion extends UpdateCompanion<PersonalPurchase> {
  final Value<int> id;
  final Value<String> productDescription;
  final Value<double> cost;
  final Value<DateTime> purchaseDate;
  final Value<int?> packageId;
  final Value<String?> notes;
  const PersonalPurchasesCompanion({
    this.id = const Value.absent(),
    this.productDescription = const Value.absent(),
    this.cost = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.packageId = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PersonalPurchasesCompanion.insert({
    this.id = const Value.absent(),
    required String productDescription,
    required double cost,
    this.purchaseDate = const Value.absent(),
    this.packageId = const Value.absent(),
    this.notes = const Value.absent(),
  })  : productDescription = Value(productDescription),
        cost = Value(cost);
  static Insertable<PersonalPurchase> custom({
    Expression<int>? id,
    Expression<String>? productDescription,
    Expression<double>? cost,
    Expression<DateTime>? purchaseDate,
    Expression<int>? packageId,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productDescription != null) 'product_description': productDescription,
      if (cost != null) 'cost': cost,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (packageId != null) 'package_id': packageId,
      if (notes != null) 'notes': notes,
    });
  }

  PersonalPurchasesCompanion copyWith(
      {Value<int>? id,
      Value<String>? productDescription,
      Value<double>? cost,
      Value<DateTime>? purchaseDate,
      Value<int?>? packageId,
      Value<String?>? notes}) {
    return PersonalPurchasesCompanion(
      id: id ?? this.id,
      productDescription: productDescription ?? this.productDescription,
      cost: cost ?? this.cost,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      packageId: packageId ?? this.packageId,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productDescription.present) {
      map['product_description'] = Variable<String>(productDescription.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (packageId.present) {
      map['package_id'] = Variable<int>(packageId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonalPurchasesCompanion(')
          ..write('id: $id, ')
          ..write('productDescription: $productDescription, ')
          ..write('cost: $cost, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('packageId: $packageId, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $MessageTemplatesTable extends MessageTemplates
    with TableInfo<$MessageTemplatesTable, MessageTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _templateContentMeta =
      const VerificationMeta('templateContent');
  @override
  late final GeneratedColumn<String> templateContent = GeneratedColumn<String>(
      'template_content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusTriggerMeta =
      const VerificationMeta('statusTrigger');
  @override
  late final GeneratedColumn<String> statusTrigger = GeneratedColumn<String>(
      'status_trigger', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, templateContent, statusTrigger];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_templates';
  @override
  VerificationContext validateIntegrity(Insertable<MessageTemplate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('template_content')) {
      context.handle(
          _templateContentMeta,
          templateContent.isAcceptableOrUnknown(
              data['template_content']!, _templateContentMeta));
    } else if (isInserting) {
      context.missing(_templateContentMeta);
    }
    if (data.containsKey('status_trigger')) {
      context.handle(
          _statusTriggerMeta,
          statusTrigger.isAcceptableOrUnknown(
              data['status_trigger']!, _statusTriggerMeta));
    } else if (isInserting) {
      context.missing(_statusTriggerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageTemplate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      templateContent: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}template_content'])!,
      statusTrigger: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_trigger'])!,
    );
  }

  @override
  $MessageTemplatesTable createAlias(String alias) {
    return $MessageTemplatesTable(attachedDatabase, alias);
  }
}

class MessageTemplate extends DataClass implements Insertable<MessageTemplate> {
  final int id;
  final String name;
  final String templateContent;
  final String statusTrigger;
  const MessageTemplate(
      {required this.id,
      required this.name,
      required this.templateContent,
      required this.statusTrigger});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['template_content'] = Variable<String>(templateContent);
    map['status_trigger'] = Variable<String>(statusTrigger);
    return map;
  }

  MessageTemplatesCompanion toCompanion(bool nullToAbsent) {
    return MessageTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      templateContent: Value(templateContent),
      statusTrigger: Value(statusTrigger),
    );
  }

  factory MessageTemplate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageTemplate(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      templateContent: serializer.fromJson<String>(json['templateContent']),
      statusTrigger: serializer.fromJson<String>(json['statusTrigger']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'templateContent': serializer.toJson<String>(templateContent),
      'statusTrigger': serializer.toJson<String>(statusTrigger),
    };
  }

  MessageTemplate copyWith(
          {int? id,
          String? name,
          String? templateContent,
          String? statusTrigger}) =>
      MessageTemplate(
        id: id ?? this.id,
        name: name ?? this.name,
        templateContent: templateContent ?? this.templateContent,
        statusTrigger: statusTrigger ?? this.statusTrigger,
      );
  MessageTemplate copyWithCompanion(MessageTemplatesCompanion data) {
    return MessageTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      templateContent: data.templateContent.present
          ? data.templateContent.value
          : this.templateContent,
      statusTrigger: data.statusTrigger.present
          ? data.statusTrigger.value
          : this.statusTrigger,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('templateContent: $templateContent, ')
          ..write('statusTrigger: $statusTrigger')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, templateContent, statusTrigger);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.templateContent == this.templateContent &&
          other.statusTrigger == this.statusTrigger);
}

class MessageTemplatesCompanion extends UpdateCompanion<MessageTemplate> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> templateContent;
  final Value<String> statusTrigger;
  const MessageTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.templateContent = const Value.absent(),
    this.statusTrigger = const Value.absent(),
  });
  MessageTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String templateContent,
    required String statusTrigger,
  })  : name = Value(name),
        templateContent = Value(templateContent),
        statusTrigger = Value(statusTrigger);
  static Insertable<MessageTemplate> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? templateContent,
    Expression<String>? statusTrigger,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (templateContent != null) 'template_content': templateContent,
      if (statusTrigger != null) 'status_trigger': statusTrigger,
    });
  }

  MessageTemplatesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? templateContent,
      Value<String>? statusTrigger}) {
    return MessageTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      templateContent: templateContent ?? this.templateContent,
      statusTrigger: statusTrigger ?? this.statusTrigger,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (templateContent.present) {
      map['template_content'] = Variable<String>(templateContent.value);
    }
    if (statusTrigger.present) {
      map['status_trigger'] = Variable<String>(statusTrigger.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('templateContent: $templateContent, ')
          ..write('statusTrigger: $statusTrigger')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ShippingAgenciesTable shippingAgencies =
      $ShippingAgenciesTable(this);
  late final $PackagesTable packages = $PackagesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ProductColorsTable productColors = $ProductColorsTable(this);
  late final $ProductSizesTable productSizes = $ProductSizesTable(this);
  late final $ProductImagesTable productImages = $ProductImagesTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $PersonalPurchasesTable personalPurchases =
      $PersonalPurchasesTable(this);
  late final $MessageTemplatesTable messageTemplates =
      $MessageTemplatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        shippingAgencies,
        packages,
        products,
        productColors,
        productSizes,
        productImages,
        customers,
        orders,
        personalPurchases,
        messageTemplates
      ];
}

typedef $$ShippingAgenciesTableCreateCompanionBuilder
    = ShippingAgenciesCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> contactInfo,
});
typedef $$ShippingAgenciesTableUpdateCompanionBuilder
    = ShippingAgenciesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> contactInfo,
});

class $$ShippingAgenciesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ShippingAgenciesTable,
    ShippingAgency,
    $$ShippingAgenciesTableFilterComposer,
    $$ShippingAgenciesTableOrderingComposer,
    $$ShippingAgenciesTableCreateCompanionBuilder,
    $$ShippingAgenciesTableUpdateCompanionBuilder> {
  $$ShippingAgenciesTableTableManager(
      _$AppDatabase db, $ShippingAgenciesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ShippingAgenciesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ShippingAgenciesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> contactInfo = const Value.absent(),
          }) =>
              ShippingAgenciesCompanion(
            id: id,
            name: name,
            contactInfo: contactInfo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> contactInfo = const Value.absent(),
          }) =>
              ShippingAgenciesCompanion.insert(
            id: id,
            name: name,
            contactInfo: contactInfo,
          ),
        ));
}

class $$ShippingAgenciesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ShippingAgenciesTable> {
  $$ShippingAgenciesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get contactInfo => $state.composableBuilder(
      column: $state.table.contactInfo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter packagesRefs(
      ComposableFilter Function($$PackagesTableFilterComposer f) f) {
    final $$PackagesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.packages,
        getReferencedColumn: (t) => t.agencyId,
        builder: (joinBuilder, parentComposers) =>
            $$PackagesTableFilterComposer(ComposerState(
                $state.db, $state.db.packages, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ShippingAgenciesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ShippingAgenciesTable> {
  $$ShippingAgenciesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get contactInfo => $state.composableBuilder(
      column: $state.table.contactInfo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PackagesTableCreateCompanionBuilder = PackagesCompanion Function({
  Value<int> id,
  Value<String?> trackingNumber,
  Value<int?> agencyId,
  Value<String> logisticStatus,
  Value<double?> packageWeight,
  Value<double> shippingCost,
  Value<double> merchandiseRealValue,
  Value<double> merchandiseSaleValue,
  Value<double> discount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String?> notes,
});
typedef $$PackagesTableUpdateCompanionBuilder = PackagesCompanion Function({
  Value<int> id,
  Value<String?> trackingNumber,
  Value<int?> agencyId,
  Value<String> logisticStatus,
  Value<double?> packageWeight,
  Value<double> shippingCost,
  Value<double> merchandiseRealValue,
  Value<double> merchandiseSaleValue,
  Value<double> discount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String?> notes,
});

class $$PackagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PackagesTable,
    Package,
    $$PackagesTableFilterComposer,
    $$PackagesTableOrderingComposer,
    $$PackagesTableCreateCompanionBuilder,
    $$PackagesTableUpdateCompanionBuilder> {
  $$PackagesTableTableManager(_$AppDatabase db, $PackagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PackagesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PackagesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> trackingNumber = const Value.absent(),
            Value<int?> agencyId = const Value.absent(),
            Value<String> logisticStatus = const Value.absent(),
            Value<double?> packageWeight = const Value.absent(),
            Value<double> shippingCost = const Value.absent(),
            Value<double> merchandiseRealValue = const Value.absent(),
            Value<double> merchandiseSaleValue = const Value.absent(),
            Value<double> discount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              PackagesCompanion(
            id: id,
            trackingNumber: trackingNumber,
            agencyId: agencyId,
            logisticStatus: logisticStatus,
            packageWeight: packageWeight,
            shippingCost: shippingCost,
            merchandiseRealValue: merchandiseRealValue,
            merchandiseSaleValue: merchandiseSaleValue,
            discount: discount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> trackingNumber = const Value.absent(),
            Value<int?> agencyId = const Value.absent(),
            Value<String> logisticStatus = const Value.absent(),
            Value<double?> packageWeight = const Value.absent(),
            Value<double> shippingCost = const Value.absent(),
            Value<double> merchandiseRealValue = const Value.absent(),
            Value<double> merchandiseSaleValue = const Value.absent(),
            Value<double> discount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              PackagesCompanion.insert(
            id: id,
            trackingNumber: trackingNumber,
            agencyId: agencyId,
            logisticStatus: logisticStatus,
            packageWeight: packageWeight,
            shippingCost: shippingCost,
            merchandiseRealValue: merchandiseRealValue,
            merchandiseSaleValue: merchandiseSaleValue,
            discount: discount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            notes: notes,
          ),
        ));
}

class $$PackagesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PackagesTable> {
  $$PackagesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get trackingNumber => $state.composableBuilder(
      column: $state.table.trackingNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get logisticStatus => $state.composableBuilder(
      column: $state.table.logisticStatus,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get packageWeight => $state.composableBuilder(
      column: $state.table.packageWeight,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get shippingCost => $state.composableBuilder(
      column: $state.table.shippingCost,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get merchandiseRealValue => $state.composableBuilder(
      column: $state.table.merchandiseRealValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get merchandiseSaleValue => $state.composableBuilder(
      column: $state.table.merchandiseSaleValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get discount => $state.composableBuilder(
      column: $state.table.discount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ShippingAgenciesTableFilterComposer get agencyId {
    final $$ShippingAgenciesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.agencyId,
            referencedTable: $state.db.shippingAgencies,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ShippingAgenciesTableFilterComposer(ComposerState($state.db,
                    $state.db.shippingAgencies, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter productsRefs(
      ComposableFilter Function($$ProductsTableFilterComposer f) f) {
    final $$ProductsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.packageId,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableFilterComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter ordersRefs(
      ComposableFilter Function($$OrdersTableFilterComposer f) f) {
    final $$OrdersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.orders,
        getReferencedColumn: (t) => t.packageId,
        builder: (joinBuilder, parentComposers) => $$OrdersTableFilterComposer(
            ComposerState(
                $state.db, $state.db.orders, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter personalPurchasesRefs(
      ComposableFilter Function($$PersonalPurchasesTableFilterComposer f) f) {
    final $$PersonalPurchasesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.personalPurchases,
            getReferencedColumn: (t) => t.packageId,
            builder: (joinBuilder, parentComposers) =>
                $$PersonalPurchasesTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.personalPurchases,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$PackagesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PackagesTable> {
  $$PackagesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get trackingNumber => $state.composableBuilder(
      column: $state.table.trackingNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get logisticStatus => $state.composableBuilder(
      column: $state.table.logisticStatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get packageWeight => $state.composableBuilder(
      column: $state.table.packageWeight,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get shippingCost => $state.composableBuilder(
      column: $state.table.shippingCost,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get merchandiseRealValue => $state.composableBuilder(
      column: $state.table.merchandiseRealValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get merchandiseSaleValue => $state.composableBuilder(
      column: $state.table.merchandiseSaleValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get discount => $state.composableBuilder(
      column: $state.table.discount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ShippingAgenciesTableOrderingComposer get agencyId {
    final $$ShippingAgenciesTableOrderingComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.agencyId,
            referencedTable: $state.db.shippingAgencies,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ShippingAgenciesTableOrderingComposer(ComposerState($state.db,
                    $state.db.shippingAgencies, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  Value<String?> category,
  Value<double?> weight,
  Value<DateTime> createdAt,
  required double supplierPrice,
  required double salePrice,
  Value<bool> isActive,
  Value<int?> packageId,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<String?> category,
  Value<double?> weight,
  Value<DateTime> createdAt,
  Value<double> supplierPrice,
  Value<double> salePrice,
  Value<bool> isActive,
  Value<int?> packageId,
});

class $$ProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder> {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ProductsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ProductsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<double> supplierPrice = const Value.absent(),
            Value<double> salePrice = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int?> packageId = const Value.absent(),
          }) =>
              ProductsCompanion(
            id: id,
            name: name,
            description: description,
            category: category,
            weight: weight,
            createdAt: createdAt,
            supplierPrice: supplierPrice,
            salePrice: salePrice,
            isActive: isActive,
            packageId: packageId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            required double supplierPrice,
            required double salePrice,
            Value<bool> isActive = const Value.absent(),
            Value<int?> packageId = const Value.absent(),
          }) =>
              ProductsCompanion.insert(
            id: id,
            name: name,
            description: description,
            category: category,
            weight: weight,
            createdAt: createdAt,
            supplierPrice: supplierPrice,
            salePrice: salePrice,
            isActive: isActive,
            packageId: packageId,
          ),
        ));
}

class $$ProductsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get weight => $state.composableBuilder(
      column: $state.table.weight,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get supplierPrice => $state.composableBuilder(
      column: $state.table.supplierPrice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get salePrice => $state.composableBuilder(
      column: $state.table.salePrice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$PackagesTableFilterComposer get packageId {
    final $$PackagesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.packageId,
        referencedTable: $state.db.packages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PackagesTableFilterComposer(ComposerState(
                $state.db, $state.db.packages, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter productColorsRefs(
      ComposableFilter Function($$ProductColorsTableFilterComposer f) f) {
    final $$ProductColorsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.productColors,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, parentComposers) =>
            $$ProductColorsTableFilterComposer(ComposerState($state.db,
                $state.db.productColors, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter productSizesRefs(
      ComposableFilter Function($$ProductSizesTableFilterComposer f) f) {
    final $$ProductSizesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.productSizes,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, parentComposers) =>
            $$ProductSizesTableFilterComposer(ComposerState($state.db,
                $state.db.productSizes, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter productImagesRefs(
      ComposableFilter Function($$ProductImagesTableFilterComposer f) f) {
    final $$ProductImagesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.productImages,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, parentComposers) =>
            $$ProductImagesTableFilterComposer(ComposerState($state.db,
                $state.db.productImages, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter ordersRefs(
      ComposableFilter Function($$OrdersTableFilterComposer f) f) {
    final $$OrdersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.orders,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, parentComposers) => $$OrdersTableFilterComposer(
            ComposerState(
                $state.db, $state.db.orders, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get weight => $state.composableBuilder(
      column: $state.table.weight,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get supplierPrice => $state.composableBuilder(
      column: $state.table.supplierPrice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get salePrice => $state.composableBuilder(
      column: $state.table.salePrice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PackagesTableOrderingComposer get packageId {
    final $$PackagesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.packageId,
        referencedTable: $state.db.packages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PackagesTableOrderingComposer(ComposerState(
                $state.db, $state.db.packages, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ProductColorsTableCreateCompanionBuilder = ProductColorsCompanion
    Function({
  Value<int> id,
  required int productId,
  required String colorName,
  Value<String?> colorHex,
});
typedef $$ProductColorsTableUpdateCompanionBuilder = ProductColorsCompanion
    Function({
  Value<int> id,
  Value<int> productId,
  Value<String> colorName,
  Value<String?> colorHex,
});

class $$ProductColorsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductColorsTable,
    ProductColor,
    $$ProductColorsTableFilterComposer,
    $$ProductColorsTableOrderingComposer,
    $$ProductColorsTableCreateCompanionBuilder,
    $$ProductColorsTableUpdateCompanionBuilder> {
  $$ProductColorsTableTableManager(_$AppDatabase db, $ProductColorsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ProductColorsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ProductColorsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> productId = const Value.absent(),
            Value<String> colorName = const Value.absent(),
            Value<String?> colorHex = const Value.absent(),
          }) =>
              ProductColorsCompanion(
            id: id,
            productId: productId,
            colorName: colorName,
            colorHex: colorHex,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int productId,
            required String colorName,
            Value<String?> colorHex = const Value.absent(),
          }) =>
              ProductColorsCompanion.insert(
            id: id,
            productId: productId,
            colorName: colorName,
            colorHex: colorHex,
          ),
        ));
}

class $$ProductColorsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ProductColorsTable> {
  $$ProductColorsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get colorName => $state.composableBuilder(
      column: $state.table.colorName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get colorHex => $state.composableBuilder(
      column: $state.table.colorHex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableFilterComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ProductColorsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ProductColorsTable> {
  $$ProductColorsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get colorName => $state.composableBuilder(
      column: $state.table.colorName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get colorHex => $state.composableBuilder(
      column: $state.table.colorHex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableOrderingComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ProductSizesTableCreateCompanionBuilder = ProductSizesCompanion
    Function({
  Value<int> id,
  required int productId,
  required String size,
  Value<int> stock,
});
typedef $$ProductSizesTableUpdateCompanionBuilder = ProductSizesCompanion
    Function({
  Value<int> id,
  Value<int> productId,
  Value<String> size,
  Value<int> stock,
});

class $$ProductSizesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductSizesTable,
    ProductSize,
    $$ProductSizesTableFilterComposer,
    $$ProductSizesTableOrderingComposer,
    $$ProductSizesTableCreateCompanionBuilder,
    $$ProductSizesTableUpdateCompanionBuilder> {
  $$ProductSizesTableTableManager(_$AppDatabase db, $ProductSizesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ProductSizesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ProductSizesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> productId = const Value.absent(),
            Value<String> size = const Value.absent(),
            Value<int> stock = const Value.absent(),
          }) =>
              ProductSizesCompanion(
            id: id,
            productId: productId,
            size: size,
            stock: stock,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int productId,
            required String size,
            Value<int> stock = const Value.absent(),
          }) =>
              ProductSizesCompanion.insert(
            id: id,
            productId: productId,
            size: size,
            stock: stock,
          ),
        ));
}

class $$ProductSizesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ProductSizesTable> {
  $$ProductSizesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get size => $state.composableBuilder(
      column: $state.table.size,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get stock => $state.composableBuilder(
      column: $state.table.stock,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableFilterComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ProductSizesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ProductSizesTable> {
  $$ProductSizesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get size => $state.composableBuilder(
      column: $state.table.size,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get stock => $state.composableBuilder(
      column: $state.table.stock,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableOrderingComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ProductImagesTableCreateCompanionBuilder = ProductImagesCompanion
    Function({
  Value<int> id,
  required int productId,
  required String imagePath,
  Value<bool> isPrimary,
  Value<int> sortOrder,
});
typedef $$ProductImagesTableUpdateCompanionBuilder = ProductImagesCompanion
    Function({
  Value<int> id,
  Value<int> productId,
  Value<String> imagePath,
  Value<bool> isPrimary,
  Value<int> sortOrder,
});

class $$ProductImagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductImagesTable,
    ProductImage,
    $$ProductImagesTableFilterComposer,
    $$ProductImagesTableOrderingComposer,
    $$ProductImagesTableCreateCompanionBuilder,
    $$ProductImagesTableUpdateCompanionBuilder> {
  $$ProductImagesTableTableManager(_$AppDatabase db, $ProductImagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ProductImagesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ProductImagesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> productId = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<bool> isPrimary = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              ProductImagesCompanion(
            id: id,
            productId: productId,
            imagePath: imagePath,
            isPrimary: isPrimary,
            sortOrder: sortOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int productId,
            required String imagePath,
            Value<bool> isPrimary = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              ProductImagesCompanion.insert(
            id: id,
            productId: productId,
            imagePath: imagePath,
            isPrimary: isPrimary,
            sortOrder: sortOrder,
          ),
        ));
}

class $$ProductImagesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ProductImagesTable> {
  $$ProductImagesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get imagePath => $state.composableBuilder(
      column: $state.table.imagePath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isPrimary => $state.composableBuilder(
      column: $state.table.isPrimary,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sortOrder => $state.composableBuilder(
      column: $state.table.sortOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableFilterComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ProductImagesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ProductImagesTable> {
  $$ProductImagesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get imagePath => $state.composableBuilder(
      column: $state.table.imagePath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isPrimary => $state.composableBuilder(
      column: $state.table.isPrimary,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sortOrder => $state.composableBuilder(
      column: $state.table.sortOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableOrderingComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> instagram,
  Value<String?> observations,
  Value<DateTime> createdAt,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> instagram,
  Value<String?> observations,
  Value<DateTime> createdAt,
});

class $$CustomersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder> {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CustomersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CustomersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> instagram = const Value.absent(),
            Value<String?> observations = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CustomersCompanion(
            id: id,
            name: name,
            instagram: instagram,
            observations: observations,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> instagram = const Value.absent(),
            Value<String?> observations = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CustomersCompanion.insert(
            id: id,
            name: name,
            instagram: instagram,
            observations: observations,
            createdAt: createdAt,
          ),
        ));
}

class $$CustomersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get instagram => $state.composableBuilder(
      column: $state.table.instagram,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get observations => $state.composableBuilder(
      column: $state.table.observations,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter ordersRefs(
      ComposableFilter Function($$OrdersTableFilterComposer f) f) {
    final $$OrdersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.orders,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder, parentComposers) => $$OrdersTableFilterComposer(
            ComposerState(
                $state.db, $state.db.orders, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get instagram => $state.composableBuilder(
      column: $state.table.instagram,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get observations => $state.composableBuilder(
      column: $state.table.observations,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$OrdersTableCreateCompanionBuilder = OrdersCompanion Function({
  Value<int> id,
  required int customerId,
  required int productId,
  Value<int?> packageId,
  required String size,
  required String color,
  Value<int> quantity,
  required double unitValue,
  required double totalValue,
  required double profit,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deliveryDate,
  Value<String?> notes,
});
typedef $$OrdersTableUpdateCompanionBuilder = OrdersCompanion Function({
  Value<int> id,
  Value<int> customerId,
  Value<int> productId,
  Value<int?> packageId,
  Value<String> size,
  Value<String> color,
  Value<int> quantity,
  Value<double> unitValue,
  Value<double> totalValue,
  Value<double> profit,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deliveryDate,
  Value<String?> notes,
});

class $$OrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdersTable,
    Order,
    $$OrdersTableFilterComposer,
    $$OrdersTableOrderingComposer,
    $$OrdersTableCreateCompanionBuilder,
    $$OrdersTableUpdateCompanionBuilder> {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$OrdersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$OrdersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> customerId = const Value.absent(),
            Value<int> productId = const Value.absent(),
            Value<int?> packageId = const Value.absent(),
            Value<String> size = const Value.absent(),
            Value<String> color = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<double> unitValue = const Value.absent(),
            Value<double> totalValue = const Value.absent(),
            Value<double> profit = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deliveryDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              OrdersCompanion(
            id: id,
            customerId: customerId,
            productId: productId,
            packageId: packageId,
            size: size,
            color: color,
            quantity: quantity,
            unitValue: unitValue,
            totalValue: totalValue,
            profit: profit,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deliveryDate: deliveryDate,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int customerId,
            required int productId,
            Value<int?> packageId = const Value.absent(),
            required String size,
            required String color,
            Value<int> quantity = const Value.absent(),
            required double unitValue,
            required double totalValue,
            required double profit,
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deliveryDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              OrdersCompanion.insert(
            id: id,
            customerId: customerId,
            productId: productId,
            packageId: packageId,
            size: size,
            color: color,
            quantity: quantity,
            unitValue: unitValue,
            totalValue: totalValue,
            profit: profit,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deliveryDate: deliveryDate,
            notes: notes,
          ),
        ));
}

class $$OrdersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get size => $state.composableBuilder(
      column: $state.table.size,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get unitValue => $state.composableBuilder(
      column: $state.table.unitValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get totalValue => $state.composableBuilder(
      column: $state.table.totalValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get profit => $state.composableBuilder(
      column: $state.table.profit,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deliveryDate => $state.composableBuilder(
      column: $state.table.deliveryDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableFilterComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableFilterComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }

  $$PackagesTableFilterComposer get packageId {
    final $$PackagesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.packageId,
        referencedTable: $state.db.packages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PackagesTableFilterComposer(ComposerState(
                $state.db, $state.db.packages, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$OrdersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get size => $state.composableBuilder(
      column: $state.table.size,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get unitValue => $state.composableBuilder(
      column: $state.table.unitValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get totalValue => $state.composableBuilder(
      column: $state.table.totalValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get profit => $state.composableBuilder(
      column: $state.table.profit,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deliveryDate => $state.composableBuilder(
      column: $state.table.deliveryDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableOrderingComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableOrderingComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }

  $$PackagesTableOrderingComposer get packageId {
    final $$PackagesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.packageId,
        referencedTable: $state.db.packages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PackagesTableOrderingComposer(ComposerState(
                $state.db, $state.db.packages, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$PersonalPurchasesTableCreateCompanionBuilder
    = PersonalPurchasesCompanion Function({
  Value<int> id,
  required String productDescription,
  required double cost,
  Value<DateTime> purchaseDate,
  Value<int?> packageId,
  Value<String?> notes,
});
typedef $$PersonalPurchasesTableUpdateCompanionBuilder
    = PersonalPurchasesCompanion Function({
  Value<int> id,
  Value<String> productDescription,
  Value<double> cost,
  Value<DateTime> purchaseDate,
  Value<int?> packageId,
  Value<String?> notes,
});

class $$PersonalPurchasesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PersonalPurchasesTable,
    PersonalPurchase,
    $$PersonalPurchasesTableFilterComposer,
    $$PersonalPurchasesTableOrderingComposer,
    $$PersonalPurchasesTableCreateCompanionBuilder,
    $$PersonalPurchasesTableUpdateCompanionBuilder> {
  $$PersonalPurchasesTableTableManager(
      _$AppDatabase db, $PersonalPurchasesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PersonalPurchasesTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$PersonalPurchasesTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> productDescription = const Value.absent(),
            Value<double> cost = const Value.absent(),
            Value<DateTime> purchaseDate = const Value.absent(),
            Value<int?> packageId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              PersonalPurchasesCompanion(
            id: id,
            productDescription: productDescription,
            cost: cost,
            purchaseDate: purchaseDate,
            packageId: packageId,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String productDescription,
            required double cost,
            Value<DateTime> purchaseDate = const Value.absent(),
            Value<int?> packageId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              PersonalPurchasesCompanion.insert(
            id: id,
            productDescription: productDescription,
            cost: cost,
            purchaseDate: purchaseDate,
            packageId: packageId,
            notes: notes,
          ),
        ));
}

class $$PersonalPurchasesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PersonalPurchasesTable> {
  $$PersonalPurchasesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get productDescription => $state.composableBuilder(
      column: $state.table.productDescription,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get cost => $state.composableBuilder(
      column: $state.table.cost,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get purchaseDate => $state.composableBuilder(
      column: $state.table.purchaseDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$PackagesTableFilterComposer get packageId {
    final $$PackagesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.packageId,
        referencedTable: $state.db.packages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PackagesTableFilterComposer(ComposerState(
                $state.db, $state.db.packages, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PersonalPurchasesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PersonalPurchasesTable> {
  $$PersonalPurchasesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get productDescription => $state.composableBuilder(
      column: $state.table.productDescription,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get cost => $state.composableBuilder(
      column: $state.table.cost,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get purchaseDate => $state.composableBuilder(
      column: $state.table.purchaseDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PackagesTableOrderingComposer get packageId {
    final $$PackagesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.packageId,
        referencedTable: $state.db.packages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PackagesTableOrderingComposer(ComposerState(
                $state.db, $state.db.packages, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$MessageTemplatesTableCreateCompanionBuilder
    = MessageTemplatesCompanion Function({
  Value<int> id,
  required String name,
  required String templateContent,
  required String statusTrigger,
});
typedef $$MessageTemplatesTableUpdateCompanionBuilder
    = MessageTemplatesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> templateContent,
  Value<String> statusTrigger,
});

class $$MessageTemplatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MessageTemplatesTable,
    MessageTemplate,
    $$MessageTemplatesTableFilterComposer,
    $$MessageTemplatesTableOrderingComposer,
    $$MessageTemplatesTableCreateCompanionBuilder,
    $$MessageTemplatesTableUpdateCompanionBuilder> {
  $$MessageTemplatesTableTableManager(
      _$AppDatabase db, $MessageTemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MessageTemplatesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MessageTemplatesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> templateContent = const Value.absent(),
            Value<String> statusTrigger = const Value.absent(),
          }) =>
              MessageTemplatesCompanion(
            id: id,
            name: name,
            templateContent: templateContent,
            statusTrigger: statusTrigger,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String templateContent,
            required String statusTrigger,
          }) =>
              MessageTemplatesCompanion.insert(
            id: id,
            name: name,
            templateContent: templateContent,
            statusTrigger: statusTrigger,
          ),
        ));
}

class $$MessageTemplatesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MessageTemplatesTable> {
  $$MessageTemplatesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get templateContent => $state.composableBuilder(
      column: $state.table.templateContent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get statusTrigger => $state.composableBuilder(
      column: $state.table.statusTrigger,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MessageTemplatesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MessageTemplatesTable> {
  $$MessageTemplatesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get templateContent => $state.composableBuilder(
      column: $state.table.templateContent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get statusTrigger => $state.composableBuilder(
      column: $state.table.statusTrigger,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ShippingAgenciesTableTableManager get shippingAgencies =>
      $$ShippingAgenciesTableTableManager(_db, _db.shippingAgencies);
  $$PackagesTableTableManager get packages =>
      $$PackagesTableTableManager(_db, _db.packages);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ProductColorsTableTableManager get productColors =>
      $$ProductColorsTableTableManager(_db, _db.productColors);
  $$ProductSizesTableTableManager get productSizes =>
      $$ProductSizesTableTableManager(_db, _db.productSizes);
  $$ProductImagesTableTableManager get productImages =>
      $$ProductImagesTableTableManager(_db, _db.productImages);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$PersonalPurchasesTableTableManager get personalPurchases =>
      $$PersonalPurchasesTableTableManager(_db, _db.personalPurchases);
  $$MessageTemplatesTableTableManager get messageTemplates =>
      $$MessageTemplatesTableTableManager(_db, _db.messageTemplates);
}
