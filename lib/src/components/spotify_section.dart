import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// Wandelt eine Spotify-URL (Artist, Album, Track, Playlist …)
/// in ihre Embed-Variante um, z. B.
String toSpotifyEmbed(String url) {
  final uri = Uri.parse(url);

  // evtl. Locale-Segment entfernen (intl-de, intl-en, …)
  final filteredSegments = uri.pathSegments.where(
    (s) => !s.startsWith('intl-'),
  );

  return Uri(
    scheme: 'https',
    host: 'open.spotify.com',
    pathSegments: ['embed', ...filteredSegments],
  ).toString();
}

class SpotifySection extends StatelessWidget {
  /// Vollständige Spotify-URL (kann normal oder bereits embed sein)
  final String spotifyUrl;

  const SpotifySection({super.key, required this.spotifyUrl});

  @override
  Widget build(BuildContext context) {
    // Widget in Nicht-Web-Targets ausblenden
    if (!kIsWeb) return const SizedBox.shrink();

    // In jedem Fall eine gültige Embed-URL erzeugen
    final embedUrl = spotifyUrl.contains('/embed/')
        ? spotifyUrl // bereits embed
        : toSpotifyEmbed(spotifyUrl); // konvertieren

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Hört unsere Songs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 352, // Artist-Player-Höhe
          child: HtmlElementView.fromTagName(
            tagName: 'iframe',
            key: const ValueKey('spotify-iframe'), // Hot-Reload stabil
            onElementCreated: (element) {
              final iframe = element as web.HTMLIFrameElement
                ..src = embedUrl
                ..width = '100%'
                ..height = '352'
                ..allow =
                    'autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture'
                ..loading = 'lazy'
                ..allowFullscreen = true;

              // Style-Attribute sauber setzen
              iframe.style
                ..setProperty('border', 'none')
                ..setProperty('border-radius', '12px');
            },
          ),
        ),
      ],
    );
  }
}
