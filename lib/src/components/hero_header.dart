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
      padding: const EdgeInsets.only(top: 12), // ← Abstand nach unten
      alignment: Alignment.topCenter, // ← oben zentrieren
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/hero.jpeg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withAlpha(153),
            BlendMode.darken,
          ),
        ),
      ),
      child: Text(
        'Ragtag Birds',
        style: TextStyle(
          fontFamily: 'Airstream',
          fontSize: isDesktop ? 96 : 42,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
