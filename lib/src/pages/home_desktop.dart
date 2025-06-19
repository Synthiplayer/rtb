import 'package:flutter/material.dart';

/// Desktop-Layout ohne Poster-Section, nur Hero-Bereich.
class HomePageDesktop extends StatelessWidget {
  const HomePageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // FULLSCREEN HERO
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/hero.jpeg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  // deprecated-Fix ↓
                  Colors.black.withValues(
                    alpha: 153, // 0.6 * 255
                  ),
                  BlendMode.darken,
                ),
              ),
            ),
            child: const Center(
              child: Text(
                'Ragtag Birds',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Airstream',
                  fontSize: 96,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          // … weitere Sections
        ],
      ),
    );
  }
}
