import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand colors
  static const Color primary = Color(0xFF0A0A0A);
  static const Color accent = Color(0xFF6366F1); // Indigo
  static const Color accentLight = Color(0xFF818CF8);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Light theme surfaces
  static const Color surfaceLight = Color(0xFFFAFAFA);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE5E7EB);

  // Dark theme surfaces
  static const Color surfaceDark = Color(0xFF0F0F0F);
  static const Color cardDark = Color(0xFF1A1A1A);
  static const Color borderDark = Color(0xFF2D2D2D);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.light,
          surface: surfaceLight,
        ),
        scaffoldBackgroundColor: surfaceLight,
        cardTheme: CardThemeData(
          color: cardLight,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: borderLight),
          ),
        ),
        textTheme: _buildTextTheme(Brightness.light),
        appBarTheme: AppBarTheme(
          backgroundColor: cardLight,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: primary,
          ),
          iconTheme: const IconThemeData(color: primary),
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: cardLight,
          indicatorColor: accent.withValues(alpha: 0.12),
          selectedIconTheme: const IconThemeData(color: accent),
          selectedLabelTextStyle:
              GoogleFonts.inter(color: accent, fontWeight: FontWeight.w600),
          unselectedIconTheme: IconThemeData(color: primary.withValues(alpha: 0.5)),
          unselectedLabelTextStyle: GoogleFonts.inter(
              color: primary.withValues(alpha: 0.5), fontWeight: FontWeight.w500),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: borderLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: borderLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: accent, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accent,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle:
                GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: accent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: surfaceLight,
          selectedColor: accent.withValues(alpha: 0.15),
          labelStyle: GoogleFonts.inter(fontSize: 12),
          side: const BorderSide(color: borderLight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        dividerTheme: const DividerThemeData(
          color: borderLight,
          thickness: 1,
          space: 0,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
          surface: surfaceDark,
        ),
        scaffoldBackgroundColor: surfaceDark,
        cardTheme: CardThemeData(
          color: cardDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: borderDark),
          ),
        ),
        textTheme: _buildTextTheme(Brightness.dark),
        appBarTheme: AppBarTheme(
          backgroundColor: cardDark,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: cardDark,
          indicatorColor: accent.withValues(alpha: 0.2),
          selectedIconTheme: const IconThemeData(color: accentLight),
          selectedLabelTextStyle: GoogleFonts.inter(
              color: accentLight, fontWeight: FontWeight.w600),
          unselectedIconTheme:
              IconThemeData(color: Colors.white.withValues(alpha: 0.4)),
          unselectedLabelTextStyle: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.4),
              fontWeight: FontWeight.w500),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cardDark,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: borderDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: borderDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: accentLight, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accent,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle:
                GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: accent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: cardDark,
          selectedColor: accent.withValues(alpha: 0.25),
          labelStyle: GoogleFonts.inter(fontSize: 12, color: Colors.white),
          side: const BorderSide(color: borderDark),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        dividerTheme: const DividerThemeData(
          color: borderDark,
          thickness: 1,
          space: 0,
        ),
      );

  static TextTheme _buildTextTheme(Brightness brightness) {
    final color =
        brightness == Brightness.light ? primary : Colors.white;
    return GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.inter(
          fontSize: 32, fontWeight: FontWeight.w700, color: color),
      displayMedium: GoogleFonts.inter(
          fontSize: 28, fontWeight: FontWeight.w700, color: color),
      headlineLarge: GoogleFonts.inter(
          fontSize: 24, fontWeight: FontWeight.w700, color: color),
      headlineMedium: GoogleFonts.inter(
          fontSize: 20, fontWeight: FontWeight.w600, color: color),
      headlineSmall: GoogleFonts.inter(
          fontSize: 18, fontWeight: FontWeight.w600, color: color),
      titleLarge: GoogleFonts.inter(
          fontSize: 16, fontWeight: FontWeight.w600, color: color),
      titleMedium: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w600, color: color),
      titleSmall: GoogleFonts.inter(
          fontSize: 13, fontWeight: FontWeight.w500, color: color),
      bodyLarge: GoogleFonts.inter(
          fontSize: 15, fontWeight: FontWeight.w400, color: color),
      bodyMedium: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w400, color: color),
      bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: color.withValues(alpha: 0.6)),
      labelLarge: GoogleFonts.inter(
          fontSize: 13, fontWeight: FontWeight.w500, color: color),
      labelMedium: GoogleFonts.inter(
          fontSize: 12, fontWeight: FontWeight.w500, color: color),
      labelSmall: GoogleFonts.inter(
          fontSize: 11, fontWeight: FontWeight.w500, color: color),
    );
  }

  // Status colors
  static Color statusColor(String status) {
    switch (status) {
      case 'pending':
        return warning;
      case 'purchased':
      case 'purchase_made':
        return info;
      case 'preparing_shipment':
      case 'supplier_preparing':
        return const Color(0xFF8B5CF6);
      case 'in_transit':
      case 'left_china':
        return const Color(0xFF06B6D4);
      case 'customs':
        return const Color(0xFFF97316);
      case 'distribution_center':
        return const Color(0xFF3B82F6);
      case 'out_for_delivery':
        return const Color(0xFF10B981);
      case 'delivered':
        return success;
      case 'cancelled':
        return error;
      case 'in_china_warehouse':
        return const Color(0xFFEC4899);
      default:
        return const Color(0xFF6B7280);
    }
  }

  static String statusLabel(String status) {
    switch (status) {
      case 'pending':
        return 'Pendiente';
      case 'purchased':
        return 'Comprado';
      case 'purchase_made':
        return 'Compra Realizada';
      case 'preparing_shipment':
        return 'Preparando Envío';
      case 'supplier_preparing':
        return 'Proveedor Preparando';
      case 'in_china_warehouse':
        return 'Almacén China';
      case 'left_china':
        return 'Salida de China';
      case 'in_transit':
        return 'En Tránsito';
      case 'customs':
        return 'Aduanas';
      case 'distribution_center':
        return 'Centro Distribución';
      case 'out_for_delivery':
        return 'En Reparto';
      case 'delivered':
        return 'Entregado';
      case 'cancelled':
        return 'Cancelado';
      default:
        return status;
    }
  }
}
