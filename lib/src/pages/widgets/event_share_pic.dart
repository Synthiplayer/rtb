import 'package:flutter/material.dart';

class EventSharePicWidget extends StatelessWidget {
  final String eventTitle;
  final String? subtitle;
  final String date;
  final String location;
  final String? priceInfo;

  const EventSharePicWidget({
    super.key,
    required this.eventTitle,
    this.subtitle,
    required this.date,
    required this.location,
    this.priceInfo,
  });

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.85;
    if (size > 380) size = 380;
    if (size < 220) size = 220;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/sharepic_bg_v3.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            // Event-Titel (immer!)
            Text(
              eventTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black54,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
            ),
            // Subtitle (falls vorhanden)
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black45,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
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
            const SizedBox(height: 8),
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
