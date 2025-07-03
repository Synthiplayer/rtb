import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/band_model.dart';

/// Kompakte Card (240×320) für ein Bandmitglied oder die Band.
/// Zeigt Bild, Name, Rolle und Social Icons an.
class BandMemberCard extends StatelessWidget {
  final BandMember member;
  final VoidCallback? onLongPress;

  const BandMemberCard({super.key, required this.member, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: onLongPress,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Portrait mit dunklem Verlauf am unteren Rand
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(member.imageAsset, fit: BoxFit.cover),
                    // Dunkler Gradient am unteren Rand für Lesbarkeit
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha((0.35 * 255).round()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              member.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            Text(
              member.role,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            // Social-Icons in einer Reihe (falls vorhanden)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (member.instagramUrl != null)
                  _SocialIcon(FontAwesomeIcons.instagram, member.instagramUrl!),
                if (member.facebookUrl != null)
                  _SocialIcon(FontAwesomeIcons.facebookF, member.facebookUrl!),
                if (member.emailUrl != null)
                  _SocialIcon(Icons.email, member.emailUrl!),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

/// Ein einzelnes Social-Icon mit URL-Launcher
class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Uri url;
  const _SocialIcon(this.icon, this.url);

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(icon, size: 20),
    padding: EdgeInsets.zero,
    onPressed: () async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    },
    tooltip: url.toString(),
  );
}
