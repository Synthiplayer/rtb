// lib/src/ui/theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.surface,
    primaryColor: AppColors.accent,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.accent,
      secondary: AppColors.text,
      surface: AppColors.surface,
    ),
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      // Neue, helle Überschrift für Titel
      titleLarge: const TextStyle(
        color: AppColors.text, // weiß
        fontSize: 22, // oder deine Wunschgröße
        fontWeight: FontWeight.bold, // optional
      ),
      titleMedium: const TextStyle(
        color: AppColors.text,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: const TextStyle(color: AppColors.text),
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
