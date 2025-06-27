import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BandDrawer extends StatelessWidget {
  const BandDrawer({super.key});
  @override
  Widget build(BuildContext context) => Drawer(
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
        const _DrawerItem('Gallery', '/gallery'),
        const _DrawerItem('Booking', '/booking'),
        const _DrawerItem('Impressum', '/impressum'),
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
      Navigator.of(context).pop();
      context.go(route);
    },
  );
}
