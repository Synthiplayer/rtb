import 'package:flutter/material.dart';
import 'package:rtb/src/pages/wdgets/band_section.dart';
import '../components/hero_header.dart';
import '../components/spotify_section.dart';

/// Desktop-Layout mit Scroll-Support.
class HomePageDesktop extends StatelessWidget {
  const HomePageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // ← neu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeroHeader(),
            const SizedBox(height: 32),

            const SpotifySection(
              spotifyUrl:
                  'https://open.spotify.com/intl-de/artist/4PBISxXLfk34sgUpVLQMFl',
            ),
            const SizedBox(height: 32),

            const BandSection(),
            const SizedBox(height: 32),

            // … weitere Sections
          ],
        ),
      ),
    );
  }
}
