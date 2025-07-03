import 'package:flutter/material.dart';
import '../../components/band_videos_gallery.dart';
import '../../components/band_drawer.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Medien-Seite: Zeigt Video-Galerie + Streaming-Links.
class MediaDetailPage extends StatelessWidget {
  const MediaDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Prüft, ob eine Rücknavigation im Navigator-Stack möglich ist
    final canPop = Navigator.of(context).canPop();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medien'),
        leading: canPop ? const BackButton() : null,
      ),
      drawer: const BandDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BandVideosGallery(),
            const SizedBox(height: 32),
            Text(
              'Hört uns auch hier:',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 12,
              children: const [
                _StreamLink(
                  label: 'Spotify',
                  url: 'https://open.spotify.com/artist/4PBISxXLfk34sgUpVLQMFl',
                ),
                _StreamLink(
                  label: 'Deezer',
                  url: 'https://www.deezer.com/artist/123456',
                ),
                _StreamLink(
                  label: 'Tidal',
                  url: 'https://tidal.com/browse/artist/123456',
                ),
                _StreamLink(
                  label: 'Apple Music',
                  url: 'https://music.apple.com/artist/123456',
                ),
                _StreamLink(
                  label: 'Amazon Music',
                  url: 'https://music.amazon.com/artists/123456',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Einzelner Streaming-Link-Button.
class _StreamLink extends StatelessWidget {
  final String label;
  final String url;
  const _StreamLink({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () =>
          launchUrlString(url, mode: LaunchMode.externalApplication),
      child: Text(label),
    );
  }
}
