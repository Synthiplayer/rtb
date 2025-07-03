import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Hauptmenü (Drawer) für die Ragtag Birds Web-App.
/// Bietet Navigation zu allen wichtigen Seiten.
class BandDrawer extends StatelessWidget {
  const BandDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Text(
              'Ragtag Birds',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: 'Airstream',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              context.go('/');
            },
          ),
          const Divider(),
          const _DrawerItem('Galerie', '/gallery'),
          const _DrawerItem('Referenzen', '/references'),
          const _DrawerItem('Booking', '/booking'),
          const _DrawerItem('Impressum', '/impressum'),
        ],
      ),
    );
  }
}

/// Ein einzelner Menüpunkt im Drawer.
class _DrawerItem extends StatelessWidget {
  final String title;
  final String route;

  const _DrawerItem(this.title, this.route);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        context.go(route);
      },
    );
  }
}
