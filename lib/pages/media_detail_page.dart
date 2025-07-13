import 'package:flutter/material.dart';
import '../sections/spotify_section.dart';
import '../widgets/band_videos_gallery.dart';
import '../widgets/band_drawer.dart';

class MediaDetailPage extends StatelessWidget {
  const MediaDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: const [
            BandVideosGallery(),
            SizedBox(height: 32),
            SpotifySection(
              spotifyUrl:
                  'https://open.spotify.com/intl-de/artist/4PBISxXLfk34sgUpVLQMFl',
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
