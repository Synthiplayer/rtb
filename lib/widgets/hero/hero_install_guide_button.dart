import 'package:flutter/material.dart';

class HeroInstallGuideButton extends StatelessWidget {
  final bool show;
  final double width;
  final double height;
  final bool isDesktop;
  final VoidCallback onShowDialog;

  const HeroInstallGuideButton({
    super.key,
    required this.show,
    required this.width,
    required this.height,
    required this.isDesktop,
    required this.onShowDialog,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();
    return Positioned(
      left: 0,
      bottom: 0,
      width: width / 2,
      height: height / 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onShowDialog, // <- Trigger für Dialog
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.download_outlined,
                        color: Colors.white70,
                        size: isDesktop ? 28 : 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Installationsanleitung',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isDesktop ? 20 : 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
