import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../ui/app_colors.dart';

class SocialShareBar extends StatelessWidget {
  final Future<void> Function()? onShareInstagram;
  final Future<void> Function()? onShareTiktok;
  final Future<void> Function()? onShareFacebook;
  final Future<void> Function()? onShareWhatsapp;
  final Future<void> Function()? onCopyLink; // Optional
  final String? infoText; // Optional (Überschrift oder Beschreibung)

  const SocialShareBar({
    super.key,
    this.onShareInstagram,
    this.onShareTiktok,
    this.onShareFacebook,
    this.onShareWhatsapp,
    this.onCopyLink,
    this.infoText,
  });

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
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            children: [
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Color(0xFFC13584),
                  size: 30,
                ),
                onPressed: onShareInstagram,
              ),
              IconButton(
                icon: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 14,
                  child: FaIcon(
                    FontAwesomeIcons.tiktok,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
                onPressed: onShareTiktok,
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Color(0xFF1877F3),
                  size: 28,
                ),
                onPressed: onShareFacebook,
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Color(0xFF25D366),
                  size: 28,
                ),
                onPressed: onShareWhatsapp,
              ),
              if (onCopyLink != null)
                IconButton(
                  icon: const Icon(
                    Icons.link,
                    color: AppColors.fadedText,
                    size: 28,
                  ),
                  onPressed: onCopyLink,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
