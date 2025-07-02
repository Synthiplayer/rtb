import 'package:flutter/material.dart';
// Neuer Import für saubere Web-Pfade ohne "#"
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/app.dart';

void main() {
  // Entfernt das "#" aus allen GoRouter-URLs im Web
  usePathUrlStrategy();
  runApp(const ProviderScope(child: App()));
}
