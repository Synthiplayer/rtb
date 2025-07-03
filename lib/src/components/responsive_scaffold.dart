import 'package:flutter/material.dart';
import 'band_app_bar.dart'; // AppBar mit Menü-Icon (bei Mobile)
import '../ui/breakpoints.dart'; // Responsive Breakpoints
import 'band_drawer.dart'; // Navigation Drawer

/// Ein Scaffold, das automatisch zwischen Drawer (Mobile) und reiner AppBar (Desktop) unterscheidet.
/// [body] ist der Seiteninhalt.
/// [drawer] ist standardmäßig der BandDrawer, kann aber überschrieben werden.
class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  final Widget drawer;

  const ResponsiveScaffold({
    super.key,
    required this.body,
    this.drawer = const BandDrawer(),
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < Breakpoints.mobile;

    return Scaffold(
      appBar: BandAppBar(showDrawer: isMobile),
      drawer: isMobile ? drawer : null,
      body: body,
    );
  }
}
