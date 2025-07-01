// lib/src/pages/detail_page.dart

import 'package:flutter/material.dart';
import '../models/band_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Detail-Seite für ein Band-Mitglied oder die Band selbst,
/// mit großem Bild oben und darunter eine Zeile mit Name, Rolle und Social-Icons.
class DetailPage extends StatelessWidget {
  final BandMember member;
  const DetailPage({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(member.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Großes Bild oben (volle Breite, ursprüngliche Größe)
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(member.imageAsset, fit: BoxFit.cover),
            ),
          ),

          // Abstand zwischen Bild und Zeile
          const SizedBox(height: 16),

          // Eine Zeile: Name | Rolle | Icons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Name & Rolle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(member.name, style: theme.textTheme.headlineSmall),
                      const SizedBox(height: 4),
                      Text(
                        member.role,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Social Icons
                if (member.hasSocials)
                  Row(
                    children: [
                      if (member.instagramUrl != null)
                        _DetailIcon(
                          FontAwesomeIcons.instagram,
                          member.instagramUrl!,
                        ),
                      if (member.facebookUrl != null)
                        _DetailIcon(
                          FontAwesomeIcons.facebookF,
                          member.facebookUrl!,
                        ),
                      if (member.emailUrl != null)
                        _DetailIcon(Icons.email, member.emailUrl!),
                    ],
                  ),
              ],
            ),
          ),

          const Divider(height: 32),

          // Scrollbarer Beschreibungstext
          if (member.description != null)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Text(member.description!, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DetailIcon extends StatelessWidget {
  final IconData icon;
  final Uri url;

  const _DetailIcon(this.icon, this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(icon, size: 28),
    onPressed: () async {
      if (await canLaunchUrl(url)) {
        launchUrl(url, mode: LaunchMode.externalApplication);
      }
    },
  );
}
