import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

/// Desktop-Version einer Tour-Karte. Zeigt alle Infos als Row (Tabellen-Layout).
class DesktopTourCard extends StatelessWidget {
  final Map<String, dynamic> show;

  const DesktopTourCard({required this.show, super.key});

  @override
  Widget build(BuildContext context) {
    // Hilfsfunktion für robustes Trimmen & Null-Handling
    String str(Map<String, dynamic> m, String key) =>
        (m[key] as String?)?.trim() ?? '';

    final event = str(show, 'event').isNotEmpty
        ? str(show, 'event')
        : 'Unbenanntes Event';
    final dateStr = str(show, 'date');
    final timeStr = str(show, 'time');
    final city = str(show, 'city');
    final venue = str(show, 'venue');
    final advance = str(show, 'advance');
    final before = str(show, 'before');
    final ticketUrl = str(show, 'url');
    final eventLink = str(show, 'eventlink');

    // Formatierung Datum/Uhrzeit
    String formattedDate = dateStr;
    if (dateStr.isNotEmpty) {
      try {
        formattedDate = DateFormat(
          'dd.MM.yyyy',
        ).format(DateTime.parse(dateStr));
      } catch (_) {}
    }
    final formattedTime = timeStr.isNotEmpty ? '$timeStr Uhr' : '';

    // Preise auflisten
    final priceLines = <String>[];
    if (advance.isNotEmpty) priceLines.add('VVK: $advance');
    if (before.isNotEmpty) priceLines.add('AK: $before');

    // Ticket-/Eventlink oder Hinweis
    Widget ticketSection;
    if (ticketUrl.isNotEmpty || eventLink.isNotEmpty) {
      ticketSection = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (ticketUrl.isNotEmpty)
            TextButton(
              onPressed: () => launchUrl(Uri.parse(ticketUrl)),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Tickets'),
            ),
          if (eventLink.isNotEmpty)
            TextButton(
              onPressed: () => launchUrl(Uri.parse(eventLink)),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('Eventlink'),
            ),
        ],
      );
    } else if (priceLines.isNotEmpty) {
      // Wenn Preis bekannt, aber kein Link: nichts anzeigen (Preise stehen ja schon da)
      ticketSection = const SizedBox.shrink();
    } else {
      // Weder Link noch Preis: expliziter Hinweis
      ticketSection = const Text(
        'Noch kein Preis / Link bekannt',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ), // Etwas weniger Abstand
      child: Padding(
        padding: const EdgeInsets.all(
          14,
        ), // Weniger Padding für kompaktere Darstellung
        child: Row(
          children: [
            Expanded(
              child: Text(
                event,
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(formattedDate, overflow: TextOverflow.ellipsis),
            ),
            Expanded(
              child: Text(formattedTime, overflow: TextOverflow.ellipsis),
            ),
            Expanded(child: Text(city, overflow: TextOverflow.ellipsis)),
            Expanded(child: Text(venue, overflow: TextOverflow.ellipsis)),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: priceLines
                    .map(
                      (l) => Text(
                        l,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(child: Center(child: ticketSection)),
          ],
        ),
      ),
    );
  }
}
