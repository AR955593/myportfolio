import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF6200EE);
  static const Color lightBackground = Color(0xFFF5F5FA);
  static const Color lightSurface = Colors.white;
  static const Color lightText = Color(0xFF1E1E2C);
  static const Color lightTextSecondary = Color(0xFF757575);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFFBB86FC);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Colors.white;
  static const Color darkTextSecondary = Color(0xFFAAAAAA);

  // Gradient definitions (common for modern look)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6200EE), Color(0xFFBB86FC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBackground,
    cardColor: lightSurface,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(color: lightText, fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.poppins(color: lightText),
      bodyMedium: GoogleFonts.poppins(color: lightTextSecondary),
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: lightText),
    ),
    colorScheme: const ColorScheme.light(
      primary: lightPrimary,
      surface: lightSurface,
    ).copyWith(background: lightBackground),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBackground,
    cardColor: darkSurface,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(color: darkText, fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.poppins(color: darkText),
      bodyMedium: GoogleFonts.poppins(color: darkTextSecondary),
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: darkText),
    ),
    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      surface: darkSurface,
    ).copyWith(background: darkBackground),
  );
}
