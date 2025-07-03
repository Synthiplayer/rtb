// File: lib/src/pages/home/home_page.dart

import 'package:flutter/material.dart';
import '../widgets/responsive_scaffold.dart';
import '../sections/home_body.dart';

/// Hauptseite der Ragtag Birds Web-App (PWA).
/// Responsive Scaffold mit Menü und Content.
/// Im Web übernimmt der Browser das Back-Handling.
/// Kein spezielles Handling für "App schließen" nötig.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveScaffold(body: HomeBody());
  }
}
