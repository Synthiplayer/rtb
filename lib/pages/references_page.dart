// File: lib/src/pages/references_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtb/widgets/responsive_scaffold.dart';
import 'package:rtb/widgets/band_drawer.dart';
import 'package:rtb/ui/breakpoints.dart';

class ReferencesPage extends StatelessWidget {
  const ReferencesPage({super.key});

  // Festival-Bullet-List für die weiteren Spielorte
  Widget festivalBulletList(
    List<String> venues,
    TextStyle style, {
    double spacing = 10,
    double runSpacing = 12,
  }) {
    final items = <Widget>[];
    for (var i = 0; i < venues.length; i++) {
      items.add(Text(venues[i], style: style, textAlign: TextAlign.center));
      if (i != venues.length - 1) {
        items.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing / 2),
            child: Text(
              "·",
              style: style.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: style.fontSize != null
                    ? style.fontSize! * 1.15
                    : null,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 0,
      runSpacing: runSpacing,
      children: items,
    );
  }

  // Schöne Eintrag-Listen mit Eintrag pro Zeile (zentriert, kein Bullet)
  Widget venueColumn(
    List<String> venues,
    TextStyle style, {
    double verticalSpacing = 10,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      for (var i = 0; i < venues.length; i++) ...[
        Text(venues[i], style: style, textAlign: TextAlign.center),
        if (i != venues.length - 1) SizedBox(height: verticalSpacing),
      ],
    ],
  );

  @override
  Widget build(BuildContext context) {
    const topVenues = [
      "Pullman City Bayern",
      "Rock'n'Roll-Festival Ganderkesee",
      "Fischauktionshalle Hamburg",
    ];
    const featuredVenues = [
      "Hapag-Hallen Cuxhaven",
      "Altstadtfest Stade",
      "Santa Pauli Hamburg",
      "Stadtfest Hamburg-Winterhude",
      "Airbus SE Stade",
    ];
    const venueList = [
      "Altstadtfest Buxtehude",
      "Altstadtfest Uelzen",
      "Ferienpark Fehmarn",
      "Hannes Bremervörde",
      "Pipapo Stade",
      "Harley-Casting-Show Jork",
    ];

    final theme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.mobile;

    // Styles
    final topStyle = GoogleFonts.roboto(
      fontSize: isMobile ? 32 : 32,
      fontWeight: FontWeight.w800,
      height: 1.16,
      letterSpacing: 0.2,
    );
    final featuredStyle = GoogleFonts.roboto(
      fontSize: isMobile ? 20 : 22,
      fontWeight: FontWeight.w700,
      height: 1.17,
    );
    final listStyle = GoogleFonts.roboto(
      fontSize: isMobile ? 15 : 16,
      fontWeight: FontWeight.w500,
      height: 1.18,
    );

    // Content-Column
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Spielorte',
          style: theme.headlineLarge?.copyWith(
            fontSize: isMobile ? 46 : 56,
            fontFamily: 'Airstream',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 26),

        // Top Venues: je Zeile, ohne Bullet
        venueColumn(topVenues, topStyle, verticalSpacing: 20),
        const SizedBox(height: 40),

        // Featured Venues: je Zeile, ohne Bullet
        venueColumn(featuredVenues, featuredStyle, verticalSpacing: 10),
        const SizedBox(height: 40),

        // Überschrift weitere
        Text(
          'Weitere Spielorte',
          style: GoogleFonts.roboto(
            fontSize: theme.titleMedium?.fontSize ?? (isMobile ? 16 : 18),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // Restliche Venues: Festival-Bullets
        festivalBulletList(
          venueList,
          listStyle,
          spacing: isMobile ? 6 : 10,
          runSpacing: 9,
        ),
        const SizedBox(height: 30),

        Text(
          '… u. v. m.',
          style: GoogleFonts.roboto(fontSize: 12, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ],
    );

    // Desktop: Max-Width
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
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 22),
        child: content,
      ),
    );
  }
}
