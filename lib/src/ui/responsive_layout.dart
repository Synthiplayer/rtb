import 'package:flutter/material.dart';

/// Ein Widget, das ab einer definierten Breite zwischen Mobile- und Desktop-Layout wechselt.
class ResponsiveLayout extends StatelessWidget {
  // Grenze für „Mobile“ (alles darunter) vs. „Desktop“ (alles darüber)
  static const mobileMaxWidth = 1024.0;

  final Widget mobile;
  final Widget desktop;

  const ResponsiveLayout({
    required this.mobile,
    required this.desktop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Wenn Breite < mobileMaxWidth, zeige mobile UI, sonst Desktop
        if (constraints.maxWidth < mobileMaxWidth) {
          return mobile;
        }
        return desktop;
      },
    );
  }
}
