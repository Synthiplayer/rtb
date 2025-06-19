import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    // surface statt background
    scaffoldBackgroundColor: AppColors.surface,
    primaryColor: AppColors.accent,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.accent,
      secondary: AppColors.text,
      surface: AppColors.surface,
    ),
    // Standard-Text: Roboto, Farbe überall weiß
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      bodyMedium: const TextStyle(color: AppColors.text),
      // Überschriften: Airstream
      headlineLarge: const TextStyle(
        fontFamily: 'Airstream',
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
      headlineMedium: const TextStyle(
        fontFamily: 'Airstream',
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
      headlineSmall: const TextStyle(
        fontFamily: 'Airstream',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      ),
      labelMedium: const TextStyle(color: AppColors.fadedText),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.text,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardColor: AppColors.surface,
    dividerColor: AppColors.fadedText,
    iconTheme: const IconThemeData(color: AppColors.text),
  );
}
