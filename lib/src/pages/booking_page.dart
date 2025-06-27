import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/band_drawer.dart';
import '../components/responsive_scaffold.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

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
              'Für Buchungsanfragen schreibt uns bitte eine E-Mail an:\n'
              'booking@ragtagbirds.de\n\n'
              'Oder ruft uns an unter:\n'
              '+49 151 241017641',
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                launchUrl(Uri.parse('mailto:booking@ragtagbirds.de'));
              },
              icon: const Icon(Icons.mail_outline),
              label: const Text('Per E-Mail anfragen'),
            ),
          ],
        ),
      ),
    );
  }
}
