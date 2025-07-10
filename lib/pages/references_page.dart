import 'package:flutter/material.dart';
import 'package:rtb/widgets/responsive_scaffold.dart';
import 'package:rtb/widgets/band_drawer.dart';
import 'package:rtb/ui/breakpoints.dart';
import 'package:rtb/pages/app_text.dart'; // <- zentrale Textstyles

class ReferencesPage extends StatelessWidget {
  const ReferencesPage({super.key});

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

    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.mobile;

    final topStyle = AppText.topVenue(isMobile: isMobile);
    final featuredStyle = AppText.featuredVenue(isMobile: isMobile);
    final listStyle = AppText.listVenue(isMobile: isMobile);
    final sectionTitleStyle = AppText.sectionTitle(isMobile: isMobile);
    final otherTitleStyle = AppText.otherTitle(isMobile: isMobile);
    final footerStyle = AppText.footerText();

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Spielorte',
          style: sectionTitleStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 26),
        venueColumn(topVenues, topStyle, verticalSpacing: 20),
        const SizedBox(height: 40),
        venueColumn(featuredVenues, featuredStyle, verticalSpacing: 10),
        const SizedBox(height: 40),
        Text(
          'Weitere Spielorte',
          style: otherTitleStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        festivalBulletList(
          venueList,
          listStyle,
          spacing: isMobile ? 6 : 10,
          runSpacing: 9,
        ),
        const SizedBox(height: 30),
        Text('… u. v. m.', style: footerStyle, textAlign: TextAlign.center),
      ],
    );

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
