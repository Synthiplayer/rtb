import 'dart:async';
import 'package:flutter/material.dart';

class HeroHeaderSlideshow extends StatefulWidget {
  const HeroHeaderSlideshow({super.key});

  @override
  State<HeroHeaderSlideshow> createState() => _HeroHeaderSlideshowState();
}

class _HeroHeaderSlideshowState extends State<HeroHeaderSlideshow> {
  final List<String> _images = [
    'assets/images/hero.jpeg',
    'assets/images/hero2.jpeg',
    'assets/images/hero3.jpeg',
  ];

  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _images.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 600; // laut Breakpoints
    final double height = isDesktop
        ? 350
        : size.height * 0.3 < 220
        ? 220
        : size.height * 0.3;

    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: SizedBox(
        key: ValueKey(_images[_currentIndex]),
        width: double.infinity,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Bild im Hintergrund
            Image.asset(
              _images[_currentIndex],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.red),
            ),

            // Dunkles Overlay
            Container(color: Colors.black.withAlpha(140)),
            // Text-Overlay
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: isDesktop ? 52 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 153),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Diese Seite befindet sich noch im Aufbau.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: isDesktop ? 26 : 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 128),
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Wir freuen uns, euch bald auf unserer neuen Homepage begrüßen zu dürfen.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: isDesktop ? 20 : 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white60,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 128),
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
          ],
        ),
      ),
    );
  }
}
