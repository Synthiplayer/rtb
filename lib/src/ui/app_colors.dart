import 'package:flutter/material.dart';

/// Zentrale Farbpalette für die Band-Website.
///
/// Hier sind alle wichtigen Farben als Konstanten definiert.
/// Benutze diese Farben überall im Theme und in Widgets für ein konsistentes Branding.
class AppColors {
  /// Modernes, sehr dunkles Grau für den App-Hintergrund.
  static const Color background = Color(0xFF18191A);

  /// Helles, fast schwarzes Grau für Oberflächen wie Cards oder AppBar.
  static const Color surface = Color(0xFF232427);

  /// Primäre Textfarbe (meist weiß).
  static const Color text = Colors.white;

  /// Dezente Textfarbe für Untertitel, Labels etc.
  static const Color fadedText = Color(0xFFCCCCCC);

  /// Akzentfarbe in Band-Grün für Buttons, Icons etc.
  static const Color accent = Color(0xFF1ED760);
}
