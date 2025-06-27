import 'package:flutter/material.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;

    return Container(
      width: double.infinity,
      height: isDesktop ? 350 : 220,
      padding: const EdgeInsets.only(top: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/hero.jpeg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.67), // ca. 170/255
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: isDesktop ? 56 : 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.3,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Diese Seite befindet sich noch im Aufbau.',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: isDesktop ? 28 : 16,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Wir freuen uns, euch bald auf unserer neuen Homepage begrüßen zu dürfen.',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: isDesktop ? 22 : 14,
                fontWeight: FontWeight.w400,
                color: Colors.white60,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
