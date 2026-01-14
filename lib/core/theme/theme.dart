import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that provides theme data for the KelasQNA application.
class KelasQNATheme {
  /// Provides the light theme for the application.
  static ThemeData lightMode() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.lightBlue,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      brightness: Brightness.light,
      textTheme: GoogleFonts.googleSansCodeTextTheme(),
    );
  }

  /// Provides the dark theme for the application.
  static ThemeData darkMode() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.lightBlue,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: GoogleFonts.googleSansCodeTextTheme(),
    );
  }
}
