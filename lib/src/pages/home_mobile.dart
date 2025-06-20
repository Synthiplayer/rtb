// lib/src/pages/home/home_mobile.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rtb/src/components/spotify_section.dart';
import 'package:rtb/src/pages/wdgets/band_section.dart';

import '../components/hero_header.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/logo.svg', height: 40),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu')),
            const ListTile(title: Text('Home')),
            const ListTile(title: Text('Über uns')),
            const ListTile(title: Text('Kontakt')),
          ],
        ),
      ),
      body: ListView(
        children: [
          HeroHeader(),
          const SizedBox(height: 32),

          // Untertitel im Roboto-Font
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Unsere neue Webseite entsteht gerade. Schaut bald wieder vorbei für News, Tourdaten & mehr!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),

          const SizedBox(height: 32),

          const SpotifySection(
            spotifyUrl:
                'https://open.spotify.com/intl-de/artist/4PBISxXLfk34sgUpVLQMFl',
          ),
          const SizedBox(height: 32),
          const BandSection(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
