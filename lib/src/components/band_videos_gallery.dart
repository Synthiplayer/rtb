import 'package:flutter/material.dart';
import '../models/band_video.dart';
import 'band_video_thumbnail.dart';

/// Galerie ausgewählter Bandvideos mit Thumbnail-Preview & Player.
class BandVideosGallery extends StatefulWidget {
  const BandVideosGallery({super.key});

  @override
  State<BandVideosGallery> createState() => _BandVideosGalleryState();
}

class _BandVideosGalleryState extends State<BandVideosGallery> {
  String? openVideoId;

  static const bandVideos = [
    BandVideo(
      id: '5c64zdcrng4',
      title: 'Perfect – Studio Recording',
      description: 'Studioaufnahme',
    ),
    BandVideo(
      id: 'oylZfGGpnto',
      title: 'Cry To Me – Live at Pullman City',
      description: 'Live-Cover aus Pullman City',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Video-Highlights – Seht & Hört die Birds',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ...bandVideos.map(
          (video) => Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: BandVideoThumbnail(
              videoId: video.id,
              title: video.title,
              description: video.description,
              showPlayer: openVideoId == video.id,
              onShowPlayer: () => setState(() => openVideoId = video.id),
              onClosePlayer: () => setState(() => openVideoId = null),
            ),
          ),
        ),
      ],
    );
  }
}
