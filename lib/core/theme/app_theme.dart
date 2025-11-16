import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Modern Color Palette
  static const Color primaryColor = Color(0xFF4F46E5);
  static const Color secondaryColor = Color(0xFF7C3AED);
  static const Color accentColor = Color(0xFFEC4899);

  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color onSurfaceColor = Color(0xFF1E293B);

  static const Color textColorPrimary = Color(0xFF1E293B);
  static const Color textColorSecondary = Color(0xFF475569);
  static const Color textColorMuted = Color(0xFF94A3B8);

  static const Color successColor = Color(0xFF22C55E);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFEF4444);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentColor, Color(0xFFD946EF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Typography
  static final TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
        fontSize: 48, fontWeight: FontWeight.w700, color: textColorPrimary),
    displayMedium: GoogleFonts.inter(
        fontSize: 36, fontWeight: FontWeight.w700, color: textColorPrimary),
    displaySmall: GoogleFonts.inter(
        fontSize: 24, fontWeight: FontWeight.w700, color: textColorPrimary),
    headlineMedium: GoogleFonts.inter(
        fontSize: 20, fontWeight: FontWeight.w600, color: textColorPrimary),
    titleLarge: GoogleFonts.inter(
        fontSize: 18, fontWeight: FontWeight.w600, color: textColorPrimary),
    bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColorSecondary),
    bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColorSecondary),
    labelLarge: GoogleFonts.inter(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
  );

  // Button Styles
  static final ElevatedButtonThemeData elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      textStyle: textTheme.labelLarge,
      elevation: 0,
    ),
  );

  // Input Decoration
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: surfaceColor,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: primaryColor, width: 2),
    ),
    labelStyle: textTheme.bodyMedium,
    hintStyle: textTheme.bodyMedium?.copyWith(color: textColorMuted),
  );

  // Card Theme
  static final CardThemeData cardTheme = CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.grey.shade200),
    ),
    color: surfaceColor,
    margin: const EdgeInsets.all(0),
  );

  // Main Theme Data
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: textTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      inputDecorationTheme: inputDecorationTheme,
      cardTheme: cardTheme,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: onSurfaceColor,
        onBackground: onSurfaceColor,
        onError: Colors.white,
      ),
    );
  }
}