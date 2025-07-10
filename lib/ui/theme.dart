// lib/ui/theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark();

    // 1) Nunito Sans als Default-Font
    final nunito = GoogleFonts.nunitoSansTextTheme(base.textTheme);

    // 2) Airstream nur für Headlines
    TextStyle airstream(double size) => TextStyle(
      fontFamily: 'Airstream',
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: AppColors.text,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.surface,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.accent,
        surface: AppColors.surface,
      ),

      // ---------- TextTheme ----------
      textTheme: nunito.copyWith(
        headlineLarge: airstream(48),
        headlineMedium: airstream(36),
        headlineSmall: airstream(28),
        // Body-Styles bleiben Nunito Sans
        bodyLarge: nunito.bodyLarge,
        bodyMedium: nunito.bodyMedium,
        labelLarge: nunito.labelLarge?.copyWith(color: AppColors.fadedText),
      ),

      // ---------- AppBar ----------
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
