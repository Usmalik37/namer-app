import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cyber Mint & Obsidian Palette
  static const Color primaryAccent = Color(0xFF00F59B); // Electric Cyber Mint
  static const Color onPrimaryColor = Color(0xFF022615); // Deep forest contrast
  static const Color secondaryAccent = Color(0xFF38BDF8); // Sky Neon
  static const Color darkBackground = Color(0xFF090D14); // Deep Obsidian
  static const Color darkSurface = Color(0xFF111723); // Elevated Slate Surface
  static const Color heartAccent = Color(0xFFFF2E63); // Vivid Neon Rose

  static ThemeData get darkTheme {
    final textTheme = GoogleFonts.outfitTextTheme(
      ThemeData.dark().textTheme,
    ).apply(
      bodyColor: const Color(0xFFE2E8F0),
      displayColor: const Color(0xFFF8FAFC),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: primaryAccent,
        onPrimary: onPrimaryColor,
        primaryContainer: Color(0xFF142B23),
        onPrimaryContainer: Color(0xFFB4FCE0),
        secondary: secondaryAccent,
        onSecondary: Color(0xFF0F172A),
        surface: darkSurface,
        onSurface: Color(0xFFF1F5F9),
      ),
      textTheme: textTheme,
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: Color(0xFF0B101A),
        indicatorColor: Color(0x2A00F59B),
        selectedIconTheme: IconThemeData(color: primaryAccent),
        unselectedIconTheme: IconThemeData(color: Color(0xFF64748B)),
        selectedLabelTextStyle: TextStyle(
          color: primaryAccent,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: Color(0xFF64748B),
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryAccent,
          foregroundColor: onPrimaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.outfit(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF172033),
        contentTextStyle: GoogleFonts.outfit(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
