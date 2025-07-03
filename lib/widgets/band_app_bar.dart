import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// AppBar für die Ragtag Birds Web-App.
/// - Zeigt links ein Menü-Icon (Mobile) oder ein großes Branding (Desktop)
/// - Navigation per Button (Desktop) oder Drawer (Mobile)
class BandAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showDrawer;
  const BandAppBar({super.key, this.showDrawer = false});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // Breakpoint kann projektweit gesetzt werden
    final isMobile = MediaQuery.of(context).size.width < 800;

    return AppBar(
      // Breiteres "leading" für das Branding im Desktop
      leadingWidth: isMobile ? null : 180,
      // Mobile: Burger-Icon, Desktop: Branding als TextButton
      leading: showDrawer
          ? Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            )
          : TextButton(
              onPressed: () => context.go('/'),
              style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
              child: Text(
                'Ragtag Birds',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Airstream',
                  color: Colors.white,
                  fontSize: 28,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
      // Mobile: App-Name in der Mitte antippbar, Desktop: kein Titel
      title: isMobile
          ? GestureDetector(
              onTap: () => context.go('/'),
              child: Text(
                'Ragtag Birds',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Airstream',
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            )
          : const SizedBox.shrink(),
      centerTitle: isMobile,
      // Desktop: Navigationsbuttons
      actions: isMobile
          ? null
          : [
              _NavButton(label: 'Galerie', route: '/gallery'),
              _NavButton(label: 'Referenzen', route: '/references'),
              _NavButton(label: 'Booking', route: '/booking'),
              _NavButton(label: 'Impressum', route: '/impressum'),
              const SizedBox(width: 18), // etwas Abstand rechts
            ],
    );
  }
}

/// Navigation-Button für die AppBar (Desktop)
class _NavButton extends StatelessWidget {
  final String label;
  final String route;
  const _NavButton({required this.label, required this.route});

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () => context.go(route),
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
    child: Text(label),
  );
}
