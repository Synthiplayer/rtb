import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'social_share_bar.dart'; // Wichtig: SocialShareBar importieren!

class EventShareButton extends StatelessWidget {
  final String eventUrl;
  final String? shareText;
  final bool useTextButton;

  const EventShareButton({
    super.key,
    required this.eventUrl,
    this.shareText,
    this.useTextButton = false,
  });

  void _shareTo(BuildContext context, String platform) async {
    String? url;
    final text = shareText ?? '';
    switch (platform) {
      case 'instagram':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Instagram'),
            content: const Text(
              'Um dieses Event auf Instagram zu teilen, poste den Link in deiner Bio oder teile ihn als Story mit Link-Sticker.\n\nEin Direkt-Share-Link zu Instagram ist leider technisch nicht möglich.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      case 'tiktok':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('TikTok'),
            content: const Text(
              'TikTok unterstützt kein direktes Teilen von Links. Poste den Link z. B. in deine Bio.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      case 'facebook':
        url = 'https://www.facebook.com/sharer/sharer.php?u=$eventUrl';
        break;
      case 'whatsapp':
        url = 'https://wa.me/?text=${Uri.encodeFull('$text $eventUrl')}';
        break;
      case 'copy':
        await Clipboard.setData(ClipboardData(text: eventUrl));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Link kopiert!')));
        return;
    }
    if (url != null) {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: SocialShareBar(
          infoText: "Eventlink teilen auf …",
          onShareInstagram: () async => _shareTo(ctx, 'instagram'),
          onShareTiktok: () async => _shareTo(ctx, 'tiktok'),
          onShareFacebook: () async => _shareTo(ctx, 'facebook'),
          onShareWhatsapp: () async => _shareTo(ctx, 'whatsapp'),
          onCopyLink: () async => _shareTo(ctx, 'copy'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (useTextButton) {
      // TextButton mit Icon und Label (z.B. für „Jetzt teilen“)
      return TextButton.icon(
        icon: const Icon(Icons.share, color: Colors.green),
        label: const Text(
          'Jetzt teilen',
          style: TextStyle(color: Colors.green),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          minimumSize: const Size(0, 36),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () => _showShareSheet(context),
      );
    } else {
      // Standard IconButton
      return IconButton(
        icon: const Icon(Icons.share),
        tooltip: 'Event teilen',
        onPressed: () => _showShareSheet(context),
      );
    }
  }
}
