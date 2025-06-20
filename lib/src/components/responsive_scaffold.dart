// lib/src/components/responsive_scaffold.dart

import 'package:flutter/material.dart';
import '../ui/breakpoints.dart';

/// Ein Scaffold, das zwischen Mobile (Drawer) und Desktop (AppBar mit Nav-Buttons)
/// unterscheidet und den Text "Ragtag Birds" als Home-Link nutzt.
class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  const ResponsiveScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < Breakpoints.mobile;
    final theme = Theme.of(context);

    if (isMobile) {
      // ---------- MOBILE ---------- //
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Ragtag Birds',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontFamily: 'Airstream',
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        drawer: const _AppDrawer(),
        body: body,
      );
    } else {
      // ---------- DESKTOP ---------- //
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 200, // ausreichend Platz für den Text
          leading: TextButton(
            onPressed: () => Navigator.pushNamed(context, '/'),
            style: TextButton.styleFrom(padding: const EdgeInsets.all(16)),
            child: Text(
              'Ragtag Birds',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontFamily: 'Airstream',
                color: Colors.white,
                fontSize: 24, // optional anpassen für bessere Lesbarkeit
              ),
            ),
          ),
          title: const SizedBox.shrink(),
          titleSpacing: 0,
          // Nav-Buttons rechts
          actions: const [
            _NavButton('Tour', '/tour'),
            _NavButton('Gallery', '/gallery'),
            _NavButton('Kontakt', '/contact'),
            _NavButton('Impressum', '/legal'),
            SizedBox(width: 24),
          ],
        ),
        body: body,
      );
    }
  }
}

/// Drawer-Punkte für Mobile
class _AppDrawer extends StatelessWidget {
  const _AppDrawer();
  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      children: const [
        DrawerHeader(child: Text('Menu')),
        _DrawerItem('Home', '/'),
        _DrawerItem('Tour', '/tour'),
        _DrawerItem('Gallery', '/gallery'),
        _DrawerItem('Kontakt', '/contact'),
        _DrawerItem('Impressum', '/legal'),
      ],
    ),
  );
}

class _DrawerItem extends StatelessWidget {
  final String title, route;
  const _DrawerItem(this.title, this.route);
  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(title),
    onTap: () => Navigator.pushNamed(context, route),
  );
}

/// TextButtons in AppBar für Desktop
class _NavButton extends StatelessWidget {
  final String label, route;
  const _NavButton(this.label, this.route);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
