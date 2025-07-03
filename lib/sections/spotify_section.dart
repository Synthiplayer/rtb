// File: lib/src/components/spotify_section.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// Zeigt einen Spotify-Embed-Player als Section auf der Webseite.
///
/// Akzeptiert eine Spotify-URL und wandelt sie ggf. in die Embed-Variante um.
/// Wird nur im Web angezeigt (kein Widget auf Mobil/Flutter Desktop).

/// Wandelt eine Spotify-URL in ihre Embed-Variante um
String toSpotifyEmbed(String url) {
  final uri = Uri.parse(url);
  final filtered = uri.pathSegments.where((s) => !s.startsWith('intl-'));
  return Uri(
    scheme: 'https',
    host: 'open.spotify.com',
    pathSegments: ['embed', ...filtered],
  ).toString();
}

class SpotifySection extends StatelessWidget {
  /// Vollständige Spotify-URL (kann normal oder bereits embed sein)
  final String spotifyUrl;

  const SpotifySection({super.key, required this.spotifyUrl});

  @override
  Widget build(BuildContext context) {
    // Nur im Web anzeigen
    if (!kIsWeb) return const SizedBox.shrink();

    final embedUrl = spotifyUrl.contains('/embed/')
        ? spotifyUrl
        : toSpotifyEmbed(spotifyUrl);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Überschrift in Airstream
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Spotify',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),

          // Untertitel in Roboto
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Hier direkt reinhören',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),

          // Embed-IFrame in 16:9
          AspectRatio(
            aspectRatio: 16 / 9,
            child: HtmlElementView.fromTagName(
              tagName: 'iframe',
              key: const ValueKey('spotify-iframe'),
              onElementCreated: (element) {
                final iframe = element as web.HTMLIFrameElement
                  ..src = embedUrl
                  ..width = '100%'
                  ..height = '100%'
                  ..allow =
                      'autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture'
                  ..loading = 'lazy';

                // Styling
                iframe.style
                  ..setProperty('border', 'none')
                  ..setProperty('border-radius', '12px');
              },
            ),
          ),
        ],
      ),
    );
  }
}
