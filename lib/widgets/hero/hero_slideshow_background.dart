import 'package:flutter/material.dart';

class HeroSlideshowBackground extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final double height;

  const HeroSlideshowBackground({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            images[currentIndex],
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.red),
          ),
          Container(color: Colors.black.withAlpha(140)),
        ],
      ),
    );
  }
}
