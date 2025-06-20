import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/band_member.dart';

class BandMemberCard extends StatelessWidget {
  final BandMember member;
  const BandMemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: InkWell(
          onTap: member.hasSocials ? () => _openFirstLink(member) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(member.imageAsset, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(member.name, style: theme.textTheme.labelLarge),
                    Text(member.role, style: theme.textTheme.labelMedium),
                    const SizedBox(height: 6),
                    _SocialRow(member),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  final BandMember m;
  const _SocialRow(this.m);

  @override
  Widget build(BuildContext context) {
    const size = 18.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (m.instagramUrl != null)
          _IconBtn(FontAwesomeIcons.instagram, m.instagramUrl!, size),
        if (m.facebookUrl != null)
          _IconBtn(FontAwesomeIcons.facebookF, m.facebookUrl!, size),
        if (m.emailUrl != null) _IconBtn(Icons.email, m.emailUrl!, size),
      ],
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final Uri url;
  final double size;
  const _IconBtn(this.icon, this.url, this.size);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: size),
      padding: EdgeInsets.zero,
      onPressed: () async {
        if (await canLaunchUrl(url)) {
          launchUrl(url, mode: LaunchMode.externalApplication);
        }
      },
    );
  }
}

void _openFirstLink(BandMember m) {
  final link = m.instagramUrl ?? m.facebookUrl ?? m.emailUrl;
  if (link != null) launchUrl(link, mode: LaunchMode.externalApplication);
}
