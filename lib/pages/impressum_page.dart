import 'package:flutter/material.dart';
import '../widgets/band_drawer.dart';
import '../widgets/responsive_scaffold.dart';

/// Zeigt das Impressum gemäß § 5 TMG sowie Kontaktdaten und rechtliche Hinweise.
///
/// Wird als eigene Seite ("/impressum") angezeigt.
/// Enthält Adressdaten, Vertreter, Kontakt sowie Hinweise zu Haftung und Urheberrecht.

class ImpressumPage extends StatelessWidget {
  const ImpressumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      drawer: const BandDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Oberteil
            Text('Impressum', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              'Angaben gemäß § 5 TMG',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            const Text(
              'Ragtag Birds\n'
              'Rock\'n\'Roll-Band\n\n'
              'Teichstr. 53\n'
              '21680 Stade',
              style: TextStyle(height: 1.4),
            ),

            const SizedBox(height: 24),

            // Vertretung
            Text(
              'Vertreten durch:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            const Text(
              'D. Reinhardt\n'
              'S. Rose',
              style: TextStyle(height: 1.4),
            ),

            const SizedBox(height: 32),

            // Kontakt
            Text('Kontakt', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            const Text(
              'E-Mail: info@ragtagbirds.de',
              style: TextStyle(height: 1.4),
            ),

            const SizedBox(height: 32),

            // Haftung für Links
            Text(
              'Haftung für Links',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            const Text(
              'Diese App enthält Links zu Ticketanbietern, Veranstalter-Seiten und externen Diensten (z. B. Spotify). '
              '\nAuf deren Inhalte haben wir keinen Einfluss und übernehmen daher keine Gewähr. '
              '\nVerantwortlich sind die jeweiligen Anbieter oder Betreiber.',
              style: TextStyle(height: 1.4),
            ),

            const SizedBox(height: 32),

            // Urheberrecht
            Text(
              'Urheberrecht',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            const Text(
              'Die Inhalte dieser App, insbesondere unser Logo und die Fotos, sind urheberrechtlich geschützt '
              '\nund ihre Verwendung bedarf unserer vorherigen Zustimmung. '
              '\n\nDas Teilen der Gig-Teilen-Bilder ist ausdrücklich erlaubt und gewünscht. '
              '\n\nExterne Musik-Streams (z. B. Spotify) und Inhalte Dritter unterliegen deren eigenen Lizenzbestimmungen.',
              style: TextStyle(height: 1.4),
            ),

            const SizedBox(height: 32),

            // Haftung für Inhalte
            Text(
              'Haftung für Inhalte',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            const Text(
              'Als Diensteanbieter sind wir gemäß § 7 Abs. 1 TMG für eigene Inhalte verantwortlich. '
              '\nGemäß §§ 8–10 TMG sind wir jedoch nicht verpflichtet, fremde Inhalte zu überwachen.',
              style: TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
