import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DesktopTourCard extends StatelessWidget {
  final Map<String, dynamic> show;
  const DesktopTourCard({required this.show, super.key});

  @override
  Widget build(BuildContext context) {
    final event = (show['event'] as String?)?.trim() ?? 'Unbenanntes Event';
    final dateStr = show['date'] as String? ?? '';
    final timeStr = (show['time'] as String?)?.trim() ?? '';
    final city = (show['city'] as String?)?.trim() ?? '';
    final venue = (show['venue'] as String?)?.trim() ?? '';
    final advance = (show['advance'] as String?)?.trim();
    final before = (show['before'] as String?)?.trim();
    final ticketUrl = (show['url'] as String?)?.trim() ?? '';
    final eventLink = (show['eventlink'] as String?)?.trim() ?? '';

    String formattedDate = dateStr;
    if (dateStr.isNotEmpty) {
      try {
        formattedDate = DateFormat(
          'dd.MM.yyyy',
        ).format(DateTime.parse(dateStr));
      } catch (_) {}
    }
    final formattedTime = timeStr.isNotEmpty ? '$timeStr Uhr' : '';

    final priceLines = <String>[];
    if (advance?.isNotEmpty ?? false) priceLines.add('VVK: ${advance!}');
    if (before?.isNotEmpty ?? false) priceLines.add('AK: ${before!}');

    // Ticket-/Eintritt-Widget
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
    } else {
      ticketSection = const Text(
        'Eintritt frei',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
