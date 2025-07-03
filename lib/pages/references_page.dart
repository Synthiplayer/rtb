// File: lib/src/pages/references_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtb/widgets/responsive_scaffold.dart';
import 'package:rtb/widgets/band_drawer.dart';
import 'package:rtb/ui/breakpoints.dart'; // für mobile Cutoff

/// Zeigt eine Liste der wichtigsten Auftrittsorte (Venues) der Band.
///
/// Unterteilt in Top-Venues, Featured Venues und weitere Spielorte.
/// Responsiv: Darstellung und Maximalbreite passen sich an Desktop/Mobile an.
///
/// Wird als eigene Seite ("/references") geroutet.

class ReferencesPage extends StatelessWidget {
  const ReferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daten
    const topVenues = [
      'Olympiastadion Berlin',
      'Neue Heimat Hamburg',
      'Stadthalle Köln',
    ];
    const featuredVenues = [
      'Zeche Bochum',
      'Tempodrom Berlin',
      'Grugahalle Essen',
      'Volksparkstadion Hamburg',
    ];
    const venueList = [
      'Druckluft Oberhausen',
      'Rockhal Luxemburg',
      'Palladium Köln',
      'Fabrik Hamburg',
      'Stadtgarten Düsseldorf',
      'Kesselhaus München',
    ];

    final theme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.mobile;

    //  Bullet-List als Wrap
    Widget buildBulletList(List<String> items, TextStyle style) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            Text(items[i], style: style, textAlign: TextAlign.center),
            if (i < items.length - 1)
              Text('·', style: style, textAlign: TextAlign.center),
          ],
        ],
      );
    }

    // Styles
    final topStyle = GoogleFonts.roboto(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      height: 1.1,
    );
    final featuredStyle = GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
    final listStyle = GoogleFonts.roboto(
      fontSize: theme.bodyMedium?.fontSize ?? 16,
    );

    // 1. Column mit zentriertem Inhalt
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Airstream-Überschrift
        Text(
          'Spielorte',
          style: theme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),

        // Top Venues mit Punkten
        buildBulletList(topVenues, topStyle),
        const SizedBox(height: 30),

        // Featured Venues mit Punkten
        buildBulletList(featuredVenues, featuredStyle),
        const SizedBox(height: 32),

        // Weitere Spielorte-Überschrift
        Text(
          'Weitere Spielorte',
          style: GoogleFonts.roboto(
            fontSize: theme.titleMedium?.fontSize,
            fontWeight: theme.titleMedium?.fontWeight,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        // VenueList mit Punkten
        buildBulletList(venueList, listStyle),
        const SizedBox(height: 32),

        // Abschluss
        Text(
          '… u. v. m.',
          style: GoogleFonts.roboto(fontSize: 12, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ],
    );

    // 2. Desktop: Max-Breite & zentrieren
    if (!isMobile) {
      content = Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: content,
        ),
      );
    }

    return ResponsiveScaffold(
      drawer: const BandDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: content,
      ),
    );
  }
}
