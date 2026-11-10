import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ultra_kl/core/database/app_database.dart';

/// ===============================
/// DATABASE PROVIDER
/// ===============================
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();

  ref.onDispose(() {
    db.close();
  });

  return db;
});

/// ===============================
/// THEME PROVIDER
/// ===============================
/// false = light mode
/// true = dark mode
final themeModeProvider = StateProvider<bool>((ref) => false);