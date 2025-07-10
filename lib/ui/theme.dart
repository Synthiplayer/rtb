import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark();

    // TextTheme mit lokaler 'NunitoSans' Familie
    final nunitoTextTheme = base.textTheme.apply(
      fontFamily: 'NunitoSans',
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    );

    // Airstream nur für Headlines (lokal eingebunden)
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
      textTheme: nunitoTextTheme.copyWith(
        headlineLarge: airstream(48),
        headlineMedium: airstream(36),
        headlineSmall: airstream(28),
        // Body-Styles sind Nunito Sans mit Farbe aus base.textTheme
        labelLarge: nunitoTextTheme.labelLarge?.copyWith(
          color: AppColors.fadedText,
        ),
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
