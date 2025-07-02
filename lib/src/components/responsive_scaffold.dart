import 'package:flutter/material.dart';
import 'band_app_bar.dart'; // Passe ggf. den Importpfad an
import '../ui/breakpoints.dart';
import 'band_drawer.dart'; // Importiere deine Breakpoints

class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  final Widget drawer; // nicht mehr nullable

  const ResponsiveScaffold({
    super.key,
    required this.body,
    this.drawer = const BandDrawer(), // <-- jetzt Standard!
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
