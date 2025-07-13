import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MusicStreamingSection extends StatelessWidget {
  const MusicStreamingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final border = BorderSide(color: Colors.white24, width: 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Hauptüberschrift
        Text(
          'Streaming',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 18),

        // Plattform-Profile-Links (Bandprofile)
        Text(
          'Hier findet ihr uns:',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              _StreamChip(
                label: 'Spotify',
                url: 'https://open.spotify.com/artist/4PBISxXLfk34sgUpVLQMFl',
                border: border,
              ),
              _StreamChip(
                label: 'Deezer',
                url: 'https://www.deezer.com/de/artist/11559555',
                border: border,
              ),
              _StreamChip(
                label: 'Apple Music',
                url:
                    'https://music.apple.com/de/artist/ragtag-birds/1189557564',
                border: border,
              ),
              _StreamChip(
                label: 'Amazon Music',
                url: 'https://music.amazon.de/artists/B01MXYLIGW/ragtag-birds',
                border: border,
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        // Featured Song Card: exakt wie die Bildkarte in der MediaSection!
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            color: cardColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: AspectRatio(
              aspectRatio: 2 / 1,
              child: Container(
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    // Optional: Coverbild (wenn du willst, sonst weglassen)
                    /*Expanded(
                      flex: 1,
                      child: Image.network(
                        'https://img.youtube.com/vi/h20b0iBQyuc/hqdefault.jpg',
                        fit: BoxFit.cover,
                        height: double.infinity,
                      ),
                    ),*/
                    // Featured Song Info
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 32,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Featured Song',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Crazy Hairy Daisy',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Jetzt anhören auf:',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withAlpha((0.75 * 255).round()),
                                  ),
                            ),

                            const SizedBox(height: 10),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 10,
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.music_note),
                                  label: const Text('Spotify'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1DB954),
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () => launchUrlString(
                                    'https://open.spotify.com/intl-de/track/0fncu5k52kM0ptNW20s5ke',
                                    mode: LaunchMode.externalApplication,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.music_note),
                                  label: const Text('Apple Music'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () => launchUrlString(
                                    'https://music.apple.com/ca/album/crazy-hairy-daisy-single/1676674851',
                                    mode: LaunchMode.externalApplication,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.music_note),
                                  label: const Text('Deezer'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () => launchUrlString(
                                    'https://www.deezer.com/mx/album/416291537',
                                    mode: LaunchMode.externalApplication,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Hinweis: Der Song öffnet sich auf der jeweiligen Streaming-Plattform.',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withAlpha((0.5 * 255).round()),
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StreamChip extends StatelessWidget {
  final String label;
  final String url;
  final BorderSide? border;
  const _StreamChip({required this.label, required this.url, this.border});

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
      side: border ?? BorderSide(color: Colors.white24, width: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      onPressed: () =>
          launchUrlString(url, mode: LaunchMode.externalApplication),
      elevation: 1,
    );
  }
}
