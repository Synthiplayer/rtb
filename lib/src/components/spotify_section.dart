// lib/src/components/spotify_section.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html';

//spotify implementaion
class SpotifySection extends StatelessWidget {
  /// Embed-URL (Track, Album oder Playlist)
  final String embedUrl;
  const SpotifySection({super.key, required this.embedUrl});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // Registrierung des iFrame-ViewTypes
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        embedUrl,
        (int viewId) => IFrameElement()
          ..src = embedUrl
          ..style.border = 'none'
          ..allow =
              'autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Text(
            'Hört unsere Songs',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 380,
          child: HtmlElementView(viewType: embedUrl),
        ),
      ],
    );
  }
}
