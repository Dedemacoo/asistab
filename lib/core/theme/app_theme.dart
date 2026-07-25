import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class AppTheme {
  // Logo ile uyumlu Premium Indigo & Cyan Paleti
  static const Color primaryColor = Color(0xFF6366F1); // Indigo / Violet AI Accent
  static const Color secondaryColor = Color(0xFF06B6D4); // Neon Cyan
  static const Color backgroundColor = Color(0xFFF8FAFC); // Soft Slate Light
  static const Color darkBackgroundColor = Color(0xFF0B0F19); // Rich Deep Slate Dark
  static const Color cardColor = Colors.white;
  static const Color cardDarkColor = Color(0xFF1E293B);
  static const Color textPrimaryColor = Color(0xFF0F172A);
  static const Color textSecondaryColor = Color(0xFF64748B);
  static const Color dangerColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color successColor = Color(0xFF10B981);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        brightness: Brightness.light,
        background: backgroundColor,
        surface: cardColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        bodyColor: textPrimaryColor,
        displayColor: textPrimaryColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textPrimaryColor),
        titleTextStyle: TextStyle(
          color: textPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        brightness: Brightness.dark,
        background: darkBackgroundColor,
        surface: cardDarkColor,
      ),
      scaffoldBackgroundColor: darkBackgroundColor,
      textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardDarkColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
