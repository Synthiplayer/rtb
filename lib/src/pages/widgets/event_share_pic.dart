import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventSharePicWidget extends StatelessWidget {
  final String eventTitle;
  final String date;
  final String location;
  final String? priceInfo;

  const EventSharePicWidget({
    super.key,
    required this.eventTitle,
    required this.date,
    required this.location,
    this.priceInfo,
  });

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.85;
    if (size > 380) size = 380; // max 380 z.B.
    if (size < 220) size = 220; // min 220 z.B.
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/sharepic_bg.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color.fromARGB(210, 0, 0, 0),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo (SVG rund, scharf, skaliert)
            Container(
              margin: const EdgeInsets.only(bottom: 0),
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black45,
                border: Border.all(color: Colors.white70, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Container(
                  color: Colors.black87, // Oder dein Kreis-Hintergrund
                  padding: const EdgeInsets.all(6), // Abstand zum Rand
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 44, // Größe des SVG INNEN
                    height: 44,
                    fit: BoxFit
                        .contain, // <- 'contain' statt 'cover' ist besser für SVG!
                  ),
                ),
              ),
            ),
            // Bandname
            const Text(
              'Ragtag Birds',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Airstream', // <<-- HIER!
                color: Colors.white,
                fontSize: 52, // gern größer machen!
                fontWeight: FontWeight.normal, // Airstream ist ohnehin bold
                letterSpacing: 1.1,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black54,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Eventtitel
            Text(
              eventTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            // Datum + Uhrzeit
            Text(
              date,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black45,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            // Ort + Venue
            Text(
              location,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 20,
                shadows: [
                  Shadow(
                    blurRadius: 3,
                    color: Colors.black38,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // Eintritt/Preis-Info
            if (priceInfo != null && priceInfo!.isNotEmpty)
              Text(
                priceInfo!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
