import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BandAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showDrawer;
  const BandAppBar({super.key, this.showDrawer = false});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return AppBar(
      // Auf Desktop: breiter Leading-Bereich für kompletten Bandnamen!
      leadingWidth: isMobile ? null : 180,
      leading: showDrawer
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
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
      // Auf Mobile: Bandname als Title, mittig!
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
      actions: isMobile
          ? null
          : [
              _NavButton(label: 'Gallery', route: '/gallery'),
              _NavButton(label: 'Booking', route: '/booking'),
              _NavButton(label: 'Impressum', route: '/impressum'),
              const SizedBox(width: 18),
            ],
    );
  }
}

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
