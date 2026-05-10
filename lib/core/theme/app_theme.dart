import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF0B0E2B),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ).copyWith(
      titleLarge: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 16,
        height: 1.6,
      ),
    ),
  );
}