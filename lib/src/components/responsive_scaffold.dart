// lib/src/components/responsive_scaffold.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui/breakpoints.dart';

/// Responsive Scaffold mit Drawer (Mobile) und Hover-NavBar (Desktop)
class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  const ResponsiveScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.mobile;

    if (isMobile) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Ragtag Birds',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 200,
          leading: TextButton(
            onPressed: () => context.go('/'),
            style: TextButton.styleFrom(padding: const EdgeInsets.all(16)),
            child: Text(
              'Ragtag Birds',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontFamily: 'Airstream',
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          title: const SizedBox.shrink(),
          titleSpacing: 0,
          actions: const [_DesktopNavBar()],
        ),
        body: body,
      );
    }
  }
}

/// Drawer für Mobile
class _AppDrawer extends StatelessWidget {
  const _AppDrawer();
  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      children: const [
        DrawerHeader(child: Text('Menu')),
        _DrawerItem('Home', '/'),
        _DrawerItem('Tour', '/#tour'),
        _DrawerItem('Gallery', '/gallery'),
        _DrawerItem('Booking', '/booking'),
        _DrawerItem('Impressum', '/impressum'),
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
    onTap: () {
      // schließt den Drawer und navigiert
      Navigator.of(context).pop();
      context.go(route);
    },
  );
}

/// Desktop NavBar mit Hover-Effekt: hovered Link weiß, andere grau
class _DesktopNavBar extends StatefulWidget {
  const _DesktopNavBar();

  @override
  State<_DesktopNavBar> createState() => _DesktopNavBarState();
}

class _DesktopNavBarState extends State<_DesktopNavBar> {
  int? _hoveredIndex;

  final List<Map<String, String>> _items = const [
    {'label': 'Tour', 'route': '/#tour'},
    {'label': 'Gallery', 'route': '/gallery'},
    {'label': 'Booking', 'route': '/booking'},
    {'label': 'Impressum', 'route': '/impressum'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_items.length, (index) {
        final item = _items[index];
        final isHovered = _hoveredIndex == index;

        // Wenn kein Hover, alle weiß. Sonst nur das hovered-Item weiß, Rest grau.
        final color = (_hoveredIndex == null || isHovered)
            ? Colors.white
            : Colors.grey;

        return MouseRegion(
          onEnter: (_) => setState(() => _hoveredIndex = index),
          onExit: (_) => setState(() => _hoveredIndex = null),
          child: TextButton(
            onPressed: () => context.go(item['route']!),
            style: TextButton.styleFrom(foregroundColor: color),
            child: Text(item['label']!),
          ),
        );
      })..add(const SizedBox(width: 24)), // Abstand rechts
    );
  }
}
