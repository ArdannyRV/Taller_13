import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF003520);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFD1E4D4);
  static const Color surface = Color(0xFFF2FBFF);
  static const Color onSurface = Color(0xFF151D20);
  static const Color surfaceVariant = Color(0xFFDBE4E8);
  static const Color onSurfaceVariant = Color(0xFF404943);
  static const Color error = Color(0xFFBA1A1A);
  static const Color outline = Color(0xFF727970);

  static const double gapComponent = 12.0;
  static const double marginMobile = 16.0;
  static const double marginDesktop = 24.0;
  static const double baseSpacing = 8.0;
  static const double gutter = 16.0;
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(8.0));

  static const TextStyle headlineLg = TextStyle(
    fontFamily: 'Archivo Narrow', fontSize: 32, fontWeight: FontWeight.w700, color: onSurface,
  );
  static const TextStyle headlineMd = TextStyle(
    fontFamily: 'Archivo Narrow', fontSize: 24, fontWeight: FontWeight.w600, color: onSurface,
  );
  static const TextStyle bodyMd = TextStyle(
    fontFamily: 'Hanken Grotesk', fontSize: 16, fontWeight: FontWeight.w400, color: onSurfaceVariant,
  );
  static const TextStyle statsNumeric = TextStyle(
    fontFamily: 'JetBrains Mono', fontSize: 14, fontWeight: FontWeight.w500, color: primary,
  );
  static const TextStyle labelCaps = TextStyle(
    fontFamily: 'Hanken Grotesk', fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: onSurfaceVariant,
  );

  static ThemeData get themeData {
    return ThemeData(
      scaffoldBackgroundColor: surface,
      primaryColor: primary,
      colorScheme: const ColorScheme.light(
        primary: primary, onPrimary: onPrimary, surface: surface, onSurface: onSurface, error: error,
      ),
    );
  }
}
