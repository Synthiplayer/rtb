// lib/src/pages/booking/booking_page.dart

import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking')),
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
              '+49 123 456789',
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: z.B. URL Launcher auf ein externes Formular oder Mail-Link
                // launchUrl(Uri.parse('mailto:booking@ragtagbirds.de'));
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
