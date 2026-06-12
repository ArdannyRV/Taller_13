import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF151D20);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color scaffoldBackground = Color(0xFFF4F6F8);
  static const Color onSurface = Color(0xFF151D20);
  static const Color surfaceVariant = Color(0xFFEAEAEA);
  static const Color onSurfaceVariant = Color(0xFF5A6360);
  static const Color outline = Color(0xFFD1D1D1);
  static const Color gold = Color(0xFFFCD400);
  static const Color error = Color(0xFFD32F2F);

  static const double gapComponent = 12.0;
  static const double marginMobile = 16.0;
  static const double marginDesktop = 24.0;
  static const double baseSpacing = 8.0;
  static const double gutter = 16.0;
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(12.0));

  static const TextStyle headlineLg = TextStyle(
    fontFamily: 'Archivo Narrow', fontSize: 32, fontWeight: FontWeight.w800, color: onSurface,
  );
  static const TextStyle headlineMd = TextStyle(
    fontFamily: 'Archivo Narrow', fontSize: 24, fontWeight: FontWeight.w700, color: onSurface,
  );
  static const TextStyle bodyMd = TextStyle(
    fontFamily: 'Hanken Grotesk', fontSize: 16, fontWeight: FontWeight.w600, color: onSurfaceVariant,
  );
  static const TextStyle statsNumeric = TextStyle(
    fontFamily: 'JetBrains Mono', fontSize: 16, fontWeight: FontWeight.w800, color: primary,
  );
  static const TextStyle labelCaps = TextStyle(
    fontFamily: 'Hanken Grotesk', fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.8, color: onSurfaceVariant,
  );

  static ThemeData get themeData {
    return ThemeData(
      scaffoldBackgroundColor: scaffoldBackground,
      primaryColor: primary,
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        surface: surface,
        onSurface: onSurface,
        error: error,
        secondary: gold,
      ),
    );
  }
}
