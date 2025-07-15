import 'package:flutter/material.dart';

class HeroTitleOverlay extends StatelessWidget {
  final bool isDesktop;
  const HeroTitleOverlay({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final showNameInHero = !isDesktop;
    final t = Theme.of(context).textTheme;

    return Align(
      alignment: isDesktop ? Alignment.center : const Alignment(0, 0.55),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Container(
          // leicht abgedunkelter Hintergrund hinter dem Text
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showNameInHero)
                Text(
                  'Willkommen',
                  style: t.displayMedium?.copyWith(
                    color: Colors.white,
                  ), // Airstream
                  textAlign: TextAlign.center,
                ),
              if (showNameInHero) const SizedBox(height: 8),
              Text(
                'Live · Stories · News · Music · Merch',
                style: t.titleMedium?.copyWith(
                  fontSize: isDesktop ? 24 : 16,
                  color: Colors.white70,
                ), // Inter
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
