import 'package:flutter/material.dart';
import '../../ui/app_colors.dart';

class SocialShareBar extends StatelessWidget {
  final Future<void> Function()? onShare; // Einziger Callback!
  final String? infoText;

  const SocialShareBar({super.key, this.onShare, this.infoText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (infoText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                infoText!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.text,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ElevatedButton.icon(
            icon: Icon(Icons.share, color: AppColors.accent),
            label: Text(
              "Bild jetzt teilen",
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            onPressed: onShare,
            style: ElevatedButton.styleFrom(
              elevation: 5,
              foregroundColor: AppColors.accent,
              backgroundColor: AppColors.background,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
