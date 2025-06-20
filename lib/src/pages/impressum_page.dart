// lib/src/pages/impressum_page.dart
import 'package:flutter/material.dart';

class ImpressumPage extends StatelessWidget {
  const ImpressumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Impressum')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Angaben gemäß § 5 TMG:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text('Ragtag Birds GmbH\nMusterstraße 1\n12345 Musterstadt'),
            const SizedBox(height: 16),
            Text(
              'Vertreten durch:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('Max Mustermann'),
            const SizedBox(height: 16),
            Text('Kontakt:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text('Telefon: +49 123 456789\nE-Mail: info@ragtagbirds.de'),
            const SizedBox(height: 16),
            Text(
              'Umsatzsteuer-ID:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('DE123456789'),
            // …weitere Pflichtangaben nach Bedarf…
          ],
        ),
      ),
    );
  }
}
