import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- Light Theme Colors ---
  static const Color lightBackground = Color(0xFFF8F9FA); // Main Background
  static const Color lightSecondaryBackground = Color(0xFFF1F3F5); // Secondary Background
  static const Color lightSurface = Color(0xFFFCFCFD); // Card Background
  static const Color lightNavbar = Color(0xFDF8F9FA); // Navbar (transparent white)
  static const Color lightFooter = Color(0xFFE9ECEF); // Footer Background
  
  static const Color lightPrimary = Color(0xFF4F46E5); // Primary Accent (Indigo)
  static const Color lightSecondary = Color(0xFF0D9488); // Secondary Accent (Teal)
  static const Color lightSuccess = Color(0xFF16A34A);
  static const Color lightWarning = Color(0xFFD97706);
  static const Color lightError = Color(0xFFDC2626);

  static const Color lightTextPrimary = Color(0xFF212529); // Primary Text
  static const Color lightTextSecondary = Color(0xFF495057); // Secondary Text
  static const Color lightTextMuted = Color(0xFF6C757D); // Muted Text
  static const Color lightTextHeading = Color(0xFF1A1D20); // Heading Text

  static const Color lightBorder = Color(0xFFE9ECEF);
  static const Color lightDivider = Color(0xFFDEE2E6);

  // --- Dark Theme Colors ---
  static const Color darkBackground = Color(0xFF0F1115); // Main Background (Obsidian)
  static const Color darkSecondaryBackground = Color(0xFF16181D); // Secondary Background
  static const Color darkSurface = Color(0xFF1D212A); // Card Background
  static const Color darkNavbar = Color(0xFD0F1115); // Navbar (transparent black)
  static const Color darkFooter = Color(0xFF0B0C0E); // Footer Background

  static const Color darkPrimary = Color(0xFF818CF8); // Primary Accent (Soft Indigo)
  static const Color darkSecondary = Color(0xFF2DD4BF); // Secondary Accent (Teal/Eucalyptus)
  static const Color darkSuccess = Color(0xFF4ADE80);
  static const Color darkWarning = Color(0xFFF59E0B);
  static const Color darkError = Color(0xFFF87171);

  static const Color darkTextPrimary = Color(0xFFE9ECEF); // Primary Text (Silver)
  static const Color darkTextSecondary = Color(0xFFADB5BD); // Secondary Text
  static const Color darkTextMuted = Color(0xFF6C757D); // Muted Text
  static const Color darkTextHeading = Color(0xFFF8F9FA); // Heading Text

  static const Color darkBorder = Color(0xFF262930);
  static const Color darkDivider = Color(0xFF1E2026);

  // Organic custom gradient definitions for accents (no harsh neon gradients)
  static const LinearGradient lightPrimaryGradient = LinearGradient(
    colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkPrimaryGradient = LinearGradient(
    colors: [Color(0xFF818CF8), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBackground,
    cardColor: lightSurface,
    dividerColor: lightDivider,
    useMaterial3: true,
    
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: lightTextPrimary),
      titleTextStyle: TextStyle(
        color: lightTextHeading,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardThemeData(
      color: lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: lightBorder),
      ),
    ),

    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(color: lightTextHeading, fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.poppins(color: lightTextPrimary),
      bodyMedium: GoogleFonts.poppins(color: lightTextSecondary),
      bodySmall: GoogleFonts.poppins(color: lightTextMuted),
    ),

    colorScheme: const ColorScheme.light(
      primary: lightPrimary,
      secondary: lightSecondary,
      surface: lightSurface,
      error: lightError,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBackground,
    cardColor: darkSurface,
    dividerColor: darkDivider,
    useMaterial3: true,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: darkTextPrimary),
      titleTextStyle: TextStyle(
        color: darkTextHeading,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardThemeData(
      color: darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: darkBorder),
      ),
    ),

    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(color: darkTextHeading, fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.poppins(color: darkTextPrimary),
      bodyMedium: GoogleFonts.poppins(color: darkTextSecondary),
      bodySmall: GoogleFonts.poppins(color: darkTextMuted),
    ),

    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkSecondary,
      surface: darkSurface,
      error: darkError,
    ),
  );
}
