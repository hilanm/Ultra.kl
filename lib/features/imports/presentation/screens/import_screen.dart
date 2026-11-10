import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' hide Border, BorderStyle;
import 'dart:io';
import 'package:ultra_kl/core/database/app_database.dart';
import 'package:ultra_kl/core/providers/database_provider.dart';
import 'package:ultra_kl/core/theme/app_theme.dart';
import 'package:ultra_kl/core/utils/widgets.dart';
import 'package:drift/drift.dart' hide Column;


class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({super.key});

  @override
  ConsumerState<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends ConsumerState<ImportScreen> {
  List<Map<String, dynamic>> _preview = [];
  List<String> _errors = [];
  bool _loading = false;
  bool _imported = false;
  String? _fileName;

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(
              title: 'Importar Excel',
              subtitle: 'Importa pedidos masivamente desde archivos XLSX o XLS',
            ),
            const SizedBox(height: 24),
            // Upload zone
            GestureDetector(
              onTap: _pickFile,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppTheme.cardDark
                      : AppTheme.accent.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.accent.withValues(alpha: 0.3),
                      width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.upload_file_outlined,
                        size: 40, color: AppTheme.accent.withValues(alpha: 0.6)),
                    const SizedBox(height: 12),
                    Text(
                      _fileName ?? 'Haz clic para seleccionar archivo',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white70 : AppTheme.primary.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Formatos soportados: .xlsx, .xls',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Column reference
            _ColumnGuide(isDark: isDark),
            const SizedBox(height: 16),
            // Errors
            if (_errors.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.error.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.error.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.error_outline,
                            size: 16, color: AppTheme.error),
                        const SizedBox(width: 6),
                        Text('${_errors.length} errores encontrados',
                            style: const TextStyle(
                                color: AppTheme.error, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ..._errors.take(5).map((e) => Text('• $e',
                        style: const TextStyle(fontSize: 12, color: AppTheme.error))),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            // Preview
            if (_preview.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    'Vista previa: ${_preview.length} filas',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  if (!_imported)
                    ElevatedButton.icon(
                      onPressed: _loading ? null : _import,
                      icon: _loading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Icon(Icons.upload, size: 16),
                      label: Text(_loading ? 'Importando...' : 'Importar Todo'),
                    ),
                  if (_imported)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.check_circle_outline,
                              size: 16, color: AppTheme.success),
                          SizedBox(width: 6),
                          Text('Importado',
                              style: TextStyle(color: AppTheme.success)),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _PreviewTable(rows: _preview, isDark: isDark),
              ),
            ] else if (_fileName == null)
              Expanded(
                child: EmptyState(
                  icon: Icons.table_chart_outlined,
                  title: 'Sin archivo seleccionado',
                  subtitle:
                      'Selecciona un archivo Excel para ver la vista previa e importar',
                ),
              ),
          ],
        ),
      ),
    );
  }
  

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );
    if (result == null) return;

    setState(() {
      _loading = true;
      _fileName = result.files.first.name;
      _preview = [];
      _errors = [];
      _imported = false;
    });

    try {
      final bytes = result.files.first.bytes ??
          (result.files.first.path != null
              ? File(result.files.first.path!).readAsBytesSync()
              : null);

      if (bytes == null) {
        setState(() => _errors = ['No se pudo leer el archivo']);
        return;
      }

      final workbook = Excel.decodeBytes(bytes);
      final sheet = workbook.tables[workbook.tables.keys.first];
      if (sheet == null) {
        setState(() => _errors = ['Hoja de cálculo vacía']);
        return;
      }

      final rows = <Map<String, dynamic>>[];
      final errors = <String>[];

      for (int i = 1; i < sheet.rows.length; i++) {
        final row = sheet.rows[i];
        if (row.isEmpty) continue;

        String cell(int idx) =>
            row.length > idx ? '${row[idx]?.value ?? ''}' : '';

        final instagram = cell(5);
        final productName = cell(2);
        final totalStr = cell(7);
        final logisticStatus = cell(11).trim();

        String normalizeStatus(String raw) {
  switch (raw.trim().toUpperCase()) {

    case 'PENDIENTE': 'pending';
      return 'Pendiente';

    case 'COMPRADO': 'purchased';
      return 'Comprado';

    case 'PREPARANDO ENVIO': 'preparing_shipment';
      return 'Preparando envío';

    case 'EN TRANSITO': 'in_transit';
      return 'En tránsito';

    case 'ADUANAS': 'customs';
      return 'Aduanas';

    case 'CENTRO DISTRIBUCION': 'distribution_center';
      return 'Centro de distribución';

    case 'ENTREGADO': 'delivered';
      return 'Entregado';

    case 'CANCELADO': 'cancelled';
      return 'Cancelado';

    default:
      return 'Pendiente';
  }
}

        if (instagram.isEmpty && productName.isEmpty) continue;

        final total = double.tryParse(totalStr);
        if (total == null && totalStr.isNotEmpty) {
          errors.add('Fila ${i + 1}: Valor total inválido ($totalStr)');
        }
        final String status = normalizeStatus(logisticStatus);

        rows.add({
          'row': i + 1,
          'orderId': cell(0),
          'packageId': cell(1),
          'productName': productName,
          'size': cell(3),
          'color': cell(4),
          'instagram': instagram,
          'productValue': cell(6),
          'total': cell(7),
          'profit': cell(8),
          'createdAt': cell(9),
          'finishedAt': cell(10),
          'logisticStatus': status,
          'valid': total != null || totalStr.isEmpty,
        });
      }

      setState(() {
        _preview = rows;
        _errors = errors;
      });
    } catch (e) {
      setState(() => _errors = ['Error al leer el archivo: $e']);
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _import() async {
  setState(() => _loading = true);

  final db = ref.read(databaseProvider);
  int imported = 0;

  for (final row in _preview) {
    if (row['valid'] != true) continue;

    try {
      // CLIENTE
      String instagram = '${row['instagram']}'.trim();

      Customer? customer;

      if (instagram.isNotEmpty) {
        customer = await db.getCustomerByInstagram(instagram);

        if (customer == null) {
          final customerId = await db.createCustomer(
            CustomersCompanion.insert(
              name: instagram,
              instagram: Value(instagram),
            ),
          );

          customer = await db.getCustomerById(customerId);
        }
      }

      // 📦 PACKAGE STATUS (NUEVO FIX)
      final packageId = int.tryParse('${row['packageId']}');
      final status = '${row['logisticStatus'] ?? ''}'.trim();

      const allowed = [
        'purchase_made',
        'sent',
        'in_transit',
        'delivered',
      ];

      final finalStatus =
          allowed.contains(status) ? status : 'purchase_made';

      // 🔥 UPDATE PACKAGE STATE
      if (packageId != null) {
        await db.updatePackage(
          PackagesCompanion(
            id: Value(packageId),
            logisticStatus: Value(finalStatus),
          ),
        );
      }

      // PRODUCTO
      final productName = '${row['productName']}'.trim();

      final products = await db.getAllProducts();

      Product? product;

      try {
        product = products.firstWhere(
          (p) => p.name.toLowerCase() == productName.toLowerCase(),
        );
      } catch (_) {
        final newProductId = await db.createProduct(
          ProductsCompanion.insert(
            name: productName.isEmpty
                ? 'Producto sin nombre'
                : productName,
            supplierPrice:
              double.tryParse('${row['productValue']}') ?? 0,
            salePrice:
                double.tryParse('${row['total']}') ?? 0,
            description: const Value(null),
            category: const Value(null),
            weight: const Value(null),

            // SOLO RELACIÓN (NO ESTADO)
            packageId: Value(packageId),
            
          ),
        );

        product = await db.getProductById(newProductId);
      }

      // ORDER
      if (customer != null) {
        final unitValue =
    double.tryParse('${row['productValue']}') ?? 0;

      final total =
          double.tryParse('${row['total']}') ?? 0;

      final profit = total - unitValue;

        await db.createOrder(
          OrdersCompanion.insert(
            customerId: customer.id,
            productId: product.id,
            size: row['size']?.toString().isEmpty == true
                ? 'M'
                : '${row['size']}',
            color: row['color']?.toString().isEmpty == true
                ? 'Sin color'
                : '${row['color']}',
            unitValue: unitValue,
            totalValue: total,
            profit: profit,
            status: Value(status),
          ),
        );

        imported++;
      }
    } catch (e) {
      debugPrint('Error importando fila: $e');
    }
  }

  if (mounted) {
    setState(() {
      _loading = false;
      _imported = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$imported pedidos importados correctamente',
        ),
      ),
    );
  }
}

}
class _ColumnGuide extends StatelessWidget {
  final bool isDark;
  const _ColumnGuide({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cols = [
      'A: ID Pedido', 'B: ID Paquete', 'C: Producto', 'D: Talla',
      'E: Color', 'F: Instagram', 'G: Valor Producto', 'H: Valor Total',
      'I: Ganancia', 'J: Fecha Creación', 'K: Fecha Finalización',
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? AppTheme.borderDark : AppTheme.borderLight),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: cols.map((c) => Text(c,
            style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.white54 : Colors.black45))).toList(),
      ),
    );
  }
}
Color _statusColor(String status) {
  switch (status) {
    case 'Entregado':
      return AppTheme.success;
    case 'En tránsito':
      return Colors.orange;
    case 'Aduanas':
      return Colors.orange;
    case 'Centro de distribución':
      return Colors.green;
      case 'Cancelado':
      return const Color.fromARGB(255, 255, 0, 0);
    case 'Enviado':
      return Colors.blue;
    case 'Comprado':
      return Colors.blue;
    case 'Compra realizada':
    default:
      return Colors.grey;
  }
}

class _PreviewTable extends StatelessWidget {
  final List<Map<String, dynamic>> rows;
  final bool isDark;
  const _PreviewTable({required this.rows, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: isDark ? AppTheme.borderDark : AppTheme.borderLight),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            headingRowHeight: 40,
            dataRowMinHeight: 36,
            dataRowMaxHeight: 36,
            columns: const [
              DataColumn(label: Text('Fila', style: TextStyle(fontSize: 12))),
              DataColumn(label: Text('Instagram', style: TextStyle(fontSize: 12))),
              DataColumn(label: Text('Producto', style: TextStyle(fontSize: 12))),
              DataColumn(label: Text('Talla', style: TextStyle(fontSize: 12))),
              DataColumn(label: Text('Color', style: TextStyle(fontSize: 12))),
              DataColumn(label: Text('Total', style: TextStyle(fontSize: 12))),
              DataColumn(label: Text('Estado', style: TextStyle(fontSize: 12))),
              DataColumn(label: Text('Estado', style: TextStyle(fontSize: 12))),
            ],
            rows: rows.map((r) {
              final isValid = r['valid'] == true;
              return DataRow(
                color: WidgetStateProperty.all(
                  isValid
                      ? Colors.transparent
                      : AppTheme.error.withValues(alpha: 0.06),
                ),
                cells: [
                  DataCell(Text('${r['row']}', style: const TextStyle(fontSize: 12))),
                  DataCell(Text('${r['instagram']}', style: const TextStyle(fontSize: 12))),
                  DataCell(Text('${r['productName']}', style: const TextStyle(fontSize: 12))),
                  DataCell(Text('${r['size']}', style: const TextStyle(fontSize: 12))),
                  DataCell(Text('${r['color']}', style: const TextStyle(fontSize: 12))),
                  DataCell(Text('\$${r['total']}', style: const TextStyle(fontSize: 12))),
                  DataCell(
                    Text(
                      '${r['logisticStatus']}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _statusColor('${r['logisticStatus']}'),
                      ),
                    ),
                  ),
                  DataCell(
    Icon(
      isValid ? Icons.check_circle_outline : Icons.error_outline,
      size: 14,
      color: isValid ? AppTheme.success : AppTheme.error,
    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
