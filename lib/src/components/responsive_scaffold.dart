// lib/src/components/responsive_scaffold.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../ui/breakpoints.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  const ResponsiveScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < Breakpoints.mobile;

    if (isMobile) {
      return Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset('assets/images/logo.svg', height: 40),
        ),
        drawer: const _AppDrawer(),
        body: body,
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          titleSpacing: 24,
          title: SvgPicture.asset('assets/images/logo.svg', height: 48),
          actions: const [
            _NavButton('Home', '/'),
            _NavButton('Tour', '/tour'),
            _NavButton('Gallery', '/gallery'),
            _NavButton('Kontakt', '/contact'),
            SizedBox(width: 24),
          ],
        ),
        body: body,
      );
    }
  }
}

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

class _NavButton extends StatelessWidget {
  final String label, route;
  const _NavButton(this.label, this.route);
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () => Navigator.pushNamed(context, route),
    child: Text(label, style: const TextStyle(color: Colors.white)),
  );
}
