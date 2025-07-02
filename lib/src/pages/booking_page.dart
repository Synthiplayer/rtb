import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/band_drawer.dart';
import '../components/responsive_scaffold.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  Future<void> _launchMail() => launchUrl(
    Uri.parse('mailto:booking@ragtagbirds.de?subject=Buchungsanfrage'),
  );

  Future<void> _downloadEpk() =>
      launchUrl(Uri.parse('https://ragtagbirds.de/epk/epk.zip'));

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      drawer: const BandDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking-Anfrage',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            const Text(
              'Für telefonische Anfragen wende dich gerne direkt an Danny:\n'
              'Telefon: +49 151 24101764\n\n'
              'Für alle anderen Buchungsanfragen schreib uns bitte eine E-Mail an:\n'
              'booking@ragtagbirds.de',
              style: TextStyle(height: 1.4),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _launchMail,
              icon: const Icon(Icons.mail_outline),
              label: const Text('Per E-Mail anfragen'),
            ),

            const SizedBox(height: 40),

            Text(
              'Download Electronic Press Kit',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            const Text(
              'Hier kannst du das offizielle EPK herunterladen:',
              style: TextStyle(height: 1.4),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _downloadEpk,
              icon: const Icon(Icons.download_outlined),
              label: const Text('EPK (ZIP) herunterladen'),
            ),
          ],
        ),
      ),
    );
  }
}
