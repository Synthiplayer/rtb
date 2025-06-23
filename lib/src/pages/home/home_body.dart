// lib/src/pages/home/home_body.dart

import 'package:flutter/material.dart';
import '../../components/hero_header.dart';
import '../widgets/band_section.dart';
import '../../components/spotify_section.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          HeroHeader(),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Unsere neue Webseite entsteht gerade. Schaut bald wieder vorbei für News, Tourdaten & mehr!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 32),

          // Erst die Band-Section (statt Spotify zuerst)
          BandSection(),
          SizedBox(height: 32),

          // Dann Spotify
          SpotifySection(
            spotifyUrl:
                'https://open.spotify.com/intl-de/artist/4PBISxXLfk34sgUpVLQMFl',
          ),
          SizedBox(height: 32),

          // (Hier könntest du später TourSection hinzufügen)
        ],
      ),
    );
  }
}
