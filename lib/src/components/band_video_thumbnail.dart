import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui;
import 'package:url_launcher/url_launcher_string.dart';

/// Zeigt ein Video-Thumbnail mit YouTube-Player (Web) oder Link-Button (Mobile).
class BandVideoThumbnail extends StatelessWidget {
  final String videoId;
  final String title;
  final String? description;
  final bool showPlayer;
  final VoidCallback onShowPlayer;
  final VoidCallback onClosePlayer;

  const BandVideoThumbnail({
    super.key,
    required this.videoId,
    required this.title,
    this.description,
    required this.showPlayer,
    required this.onShowPlayer,
    required this.onClosePlayer,
  });

  static final _registeredIframes = <String>{};

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
    final iframeViewType = 'youtube-iframe-$videoId';

    // ViewFactory nur 1x pro videoId registrieren!
    if (kIsWeb && !_registeredIframes.contains(iframeViewType)) {
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(iframeViewType, (int viewId) {
        final iframe = web.HTMLIFrameElement()
          ..width = '560'
          ..height = '315'
          ..src = 'https://www.youtube.com/embed/$videoId?autoplay=1&mute=1'
          ..style.border = 'none'
          ..allowFullscreen = true;
        return iframe;
      });
      _registeredIframes.add(iframeViewType);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        if (description?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 8),
            child: Text(
              description!,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
        if (!showPlayer)
          GestureDetector(
            onTap: onShowPlayer,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    thumbnailUrl,
                    height: 200,
                    width: 356,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ],
            ),
          )
        else if (kIsWeb)
          Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: SizedBox(
                  width: 560,
                  height: 315,
                  child: HtmlElementView(viewType: iframeViewType),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: onClosePlayer,
                tooltip: "Schließen",
              ),
            ],
          )
        else
          OutlinedButton.icon(
            onPressed: () => launchUrlString('https://youtu.be/$videoId'),
            icon: const Icon(Icons.play_circle_outline),
            label: const Text("Auf YouTube anschauen"),
          ),
      ],
    );
  }
}
