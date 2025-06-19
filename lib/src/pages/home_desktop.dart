// lib/src/pages/home/home_desktop.dart
import 'package:flutter/material.dart';

/// Desktop-Layout ohne Poster-Section, nur Hero-Bereich
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
                image: AssetImage('assets/images/hero.jpeg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Center(
              child: Text(
                'Ragtag Birds',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(
                      fontFamily: 'Airstream',
                      fontSize: 96,
                      fontWeight: FontWeight.bold,
                    ).copyWith(
                      color: Colors.white, // statt colorScheme.secondary
                    ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // ... weitere Sections können hier folgen
        ],
      ),
    );
  }
}
