import 'package:flutter/material.dart';

class HeroNewsButton extends StatelessWidget {
  final bool isDesktop;
  final double width;
  final double height;
  final Animation<Color?> colorAnimation;
  final bool hasNewNews;
  final VoidCallback onOpenNewsDialog;

  const HeroNewsButton({
    super.key,
    required this.isDesktop,
    required this.width,
    required this.height,
    required this.colorAnimation,
    required this.hasNewNews,
    required this.onOpenNewsDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      width: width / 2,
      height: height / 2,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onOpenNewsDialog,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 12, bottom: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'News',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isDesktop ? 20 : 14,
                  ),
                ),
                const SizedBox(width: 6),
                AnimatedBuilder(
                  animation: colorAnimation,
                  builder: (context, child) => Icon(
                    Icons.newspaper,
                    color: hasNewNews ? colorAnimation.value : Colors.white70,
                    size: isDesktop ? 28 : 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
