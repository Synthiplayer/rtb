import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'long_press_progress.dart';

/// „To the Music“-Karte ohne feste Breite
class ToMusicCard extends StatelessWidget {
  const ToMusicCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LongPressProgress(
      onLongPressComplete: () => context.push('/to-the-music'),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.music_note,
                size: 48,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'To the Music',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
