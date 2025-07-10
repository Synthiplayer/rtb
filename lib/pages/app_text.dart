import 'package:flutter/material.dart';
import '../ui/app_colors.dart';

class AppText {
  // Basis-Funktion für Nunito Sans (Variable Font)
  static TextStyle nunitoSans({
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    double height = 1.2,
    double? letterSpacing,
    Color? color,
  }) => TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    height: height,
    letterSpacing: letterSpacing,
    color: color ?? AppColors.text,
  );

  // Stile für verschiedene Anwendungsfälle

  static TextStyle topVenue({required bool isMobile}) => nunitoSans(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 1.16,
    letterSpacing: 0.2,
  );

  static TextStyle featuredVenue({required bool isMobile}) => nunitoSans(
    fontSize: isMobile ? 20 : 22,
    fontWeight: FontWeight.w700,
    height: 1.17,
  );

  static TextStyle listVenue({required bool isMobile}) => nunitoSans(
    fontSize: isMobile ? 15 : 16,
    fontWeight: FontWeight.w500,
    height: 1.18,
  );

  // Airstream nur für Headlines, statisch eingebunden
  static TextStyle airstream(double size) => const TextStyle(
    fontFamily: 'Airstream',
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  ).copyWith(fontSize: size);

  static TextStyle sectionTitle({required bool isMobile}) =>
      airstream(isMobile ? 46 : 56);

  static TextStyle otherTitle({required bool isMobile}) =>
      nunitoSans(fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.w700);

  static TextStyle footerText() =>
      nunitoSans(fontSize: 12, fontStyle: FontStyle.italic);
}
