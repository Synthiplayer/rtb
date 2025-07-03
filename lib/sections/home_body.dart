// lib/src/pages/home/home_body.dart

import 'package:flutter/material.dart';
import '../widgets/hero_header_slide_show.dart';
import 'band_section.dart';
import 'media_section.dart';
import 'spotify_section.dart';
import 'tour_section.dart';

/// Startseite-Inhalt: Header, Tourdaten, Bandvorstellung, Media & Spotify.
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          // Oben: Hero-Slideshow mit Bandbildern
          HeroHeaderSlideshow(),
          SizedBox(height: 16),

          // Tourdaten/Live-Termine direkt unter dem Header
          TourSection(),
          SizedBox(height: 32),

          // Band-Mitglieder horizontal scrollbar
          BandSection(),
          SizedBox(height: 32),

          // Video-Galerie/Media-Section (YouTube, etc.)
          MediaSection(),
          SizedBox(height: 32),

          // Spotify-Player zum Reinhören
          SpotifySection(
            spotifyUrl:
                'https://open.spotify.com/intl-de/artist/4PBISxXLfk34sgUpVLQMFl',
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
