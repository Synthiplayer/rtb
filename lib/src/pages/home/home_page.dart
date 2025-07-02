// lib/src/pages/home/home_page.dart

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import '../../components/responsive_scaffold.dart';
import 'home_body.dart';

/// Entscheidet automatisch zwischen Mobile (Drawer) und Desktop (AppBar-Buttons).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    // Nur auf Android nachfragen, iOS lässt den Nutzer per System-Geste zurückspringen
    if (Platform.isAndroid) {
      final shouldExit = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('App verlassen?'),
          content: const Text('Möchtest du die App wirklich schließen?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Nein'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Ja'),
            ),
          ],
        ),
      );
      return shouldExit ?? false;
    }
    // Auf anderen Plattformen Default-Verhalten
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Stack(children: const [ResponsiveScaffold(body: HomeBody())]),
    );
  }
}
