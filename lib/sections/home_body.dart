// lib/src/pages/home/home_body.dart

import 'package:flutter/material.dart';
import '../widgets/hero/hero_header_slide_show.dart';
import 'band_section.dart';
import 'media_section.dart';
import 'music_streaming_section.dart';
import 'tour_section.dart';

/// Startseite-Inhalt: Header, Tourdaten, Bandvorstellung, Media & Streaming-Links.
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Oben: Hero-Slideshow mit Bandbildern
          const HeroHeaderSlideshow(),
          const SizedBox(height: 16),

          // Tourdaten/Live-Termine direkt unter dem Header
          const TourSection(),
          const SizedBox(height: 32),

          // Band-Mitglieder horizontal scrollbar
          const BandSection(),
          const SizedBox(height: 32),

          // Video-Galerie/Media-Section (YouTube, etc.)
          const MediaSection(),
          const SizedBox(height: 32),

          // Streaming-Links (als ausgelagertes Widget)
          const MusicStreamingSection(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
