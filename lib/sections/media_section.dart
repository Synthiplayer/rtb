// File: lib/src/pages/widgets/media_section.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/long_press_progress.dart';

/// Teaser-Bereich für die Media-Seite mit Long-Press-Navigation.
/// Zeigt Bild und Hinweistext an. Langer Druck öffnet die Detailseite.
class MediaSection extends StatelessWidget {
  const MediaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Überschrift & Hinweistext
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Media',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Bild lange drücken, um zur Media-Seite zu wechseln',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                'Long press for details',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Bildkarte, die bei langem Druck zur Media-Detailseite führt
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LongPressProgress(
            onLongPressComplete: () {
              // Navigiert zur Media-Detailseite
              GoRouter.of(context).push('/media');
            },
            child: Card(
              elevation: 4,
              // Weder Ecken noch Clipping, um den Bild-Rahmen nicht zu stören
              shape: const RoundedRectangleBorder(),
              clipBehavior: Clip.none,
              // Kein AspectRatio mehr nötig. Das Bild passt sich von selbst an.
              child: Image.asset(
                'assets/images/mediabild_retro_v2.webp',
                // BoxFit.contain skaliert das Bild passend herunter, ohne es zu beschneiden.
                // Das ist die korrekte Lösung für das Problem.
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
