// desktop_tour_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

/// Desktop-Version einer Tour-Karte im Tabellen-Layout.
class DesktopTourCard extends StatelessWidget {
  final Map<String, dynamic> show;
  const DesktopTourCard({required this.show, super.key});

  @override
  Widget build(BuildContext context) {
    String str(String key) => (show[key] as String?)?.trim() ?? '';

    final eventRaw = str('event');
    final event = eventRaw.isNotEmpty ? eventRaw : 'Unbenanntes Event';
    final dateStr = str('date');
    final timeStr = str('time');
    final city = str('city');
    final venue = str('venue');
    final advance = str('advance');
    final before = str('before');
    final ticketUrl = str('url');
    final eventLink = str('eventlink');

    // Datum formatieren oder Fallback
    String formattedDate;
    if (dateStr.isNotEmpty) {
      try {
        formattedDate = DateFormat(
          'dd.MM.yyyy',
        ).format(DateTime.parse(dateStr));
      } catch (_) {
        formattedDate = 'Ungültiges Datum';
      }
    } else {
      formattedDate = 'Datum unbekannt';
    }
    final formattedTime = timeStr.isNotEmpty ? '$timeStr Uhr' : '';

    final priceLines = <String>[];
    if (advance.isNotEmpty) priceLines.add('VVK: $advance');
    if (before.isNotEmpty) priceLines.add('AK: $before');

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
      ticketSection = const SizedBox.shrink();
    } else {
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
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                event,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
