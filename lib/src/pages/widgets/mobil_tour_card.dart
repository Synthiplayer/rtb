import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class MobilTourCard extends StatefulWidget {
  final Map<String, dynamic> show;
  const MobilTourCard({required this.show, super.key});

  @override
  State<MobilTourCard> createState() => _MobilTourCardState();
}

class _MobilTourCardState extends State<MobilTourCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final show = widget.show;
    final event = (show['event'] as String?)?.trim() ?? 'Unbenanntes Event';
    final dateStr = show['date'] as String? ?? '';
    final timeStr = (show['time'] as String?)?.trim() ?? '';
    final city = (show['city'] as String?)?.trim() ?? '';
    final venue = (show['venue'] as String?)?.trim() ?? '';
    final advance = (show['advance'] as String?)?.trim();
    final before = (show['before'] as String?)?.trim();
    final ticketUrl = (show['url'] as String?)?.trim() ?? '';
    final eventLink = (show['eventlink'] as String?)?.trim() ?? '';
    final organizer = (show['organizer'] as String?)?.trim();
    final organizerStreet = (show['organizer_street'] as String?)?.trim();
    final organizerCity = (show['organizer_city'] as String?)?.trim();
    final subtitle = (show['subtitle'] as String?)?.trim();

    // Zusatzinfos (Subtitle, Eventlink, Adresse/Veranstalter)
    final hasExtraInfos =
        (subtitle != null && subtitle.isNotEmpty) ||
        eventLink.isNotEmpty ||
        (organizer != null && organizer.isNotEmpty) ||
        (organizerStreet != null && organizerStreet.isNotEmpty) ||
        (organizerCity != null && organizerCity.isNotEmpty);

    String formattedDate = dateStr;
    if (dateStr.isNotEmpty) {
      try {
        formattedDate = DateFormat(
          'dd.MM.yyyy',
        ).format(DateTime.parse(dateStr));
      } catch (_) {}
    }
    final formattedTime = timeStr.isNotEmpty ? '$timeStr Uhr' : '';

    // Preise-Infos (VVK/AK) – für Expanded-Block
    final priceLines = <String>[];
    if (advance?.isNotEmpty ?? false) priceLines.add('VVK: ${advance!}');
    if (before?.isNotEmpty ?? false) priceLines.add('AK: ${before!}');

    // --- LOGIK: Nur Abendkasse ohne Zusatzinfos ---
    final isAbendkasseOnly =
        (advance == null || advance.isEmpty) &&
        (before != null && before.isNotEmpty) &&
        ticketUrl.isEmpty &&
        !hasExtraInfos;

    // --- Rechte Seite (Button, Preise, Eintritt frei, Pfeil) ---
    Widget right;
    if (ticketUrl.isNotEmpty) {
      // Tickets-Button – Pfeil nur falls Preise oder Zusatzinfos
      final canExpand =
          (hasExtraInfos ||
          (advance != null && advance.isNotEmpty) ||
          (before != null &&
              (advance != null && advance.isNotEmpty) &&
              advance != before));
      right = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              final uri = Uri.parse(ticketUrl);
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Tickets'),
          ),
          if (canExpand)
            IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              tooltip: _expanded ? 'Weniger Details' : 'Mehr Details',
              onPressed: () => setState(() => _expanded = !_expanded),
              padding: EdgeInsets.zero,
            ),
        ],
      );
    } else if (isAbendkasseOnly) {
      // Nur Abendkasse, keine weiteren Infos, kein Pfeil!
      right = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Eintritt:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text('AK: $before', style: Theme.of(context).textTheme.bodyMedium),
        ],
      );
    } else if ((advance == null || advance.isEmpty) &&
        (before == null || before.isEmpty) &&
        !hasExtraInfos) {
      // Eintritt frei, keine weiteren Infos, kein Pfeil
      right = const Text(
        'Eintritt frei',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );
    } else {
      // Eintritt frei ODER VVK/AK/weitere Details
      final canExpand =
          hasExtraInfos ||
          (advance != null && advance.isNotEmpty) ||
          (before != null && advance != null && advance.isNotEmpty);
      right = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if ((advance == null || advance.isEmpty) &&
              (before == null || before.isEmpty))
            const Text(
              'Eintritt frei',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          if (canExpand)
            IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              tooltip: _expanded ? 'Weniger Details' : 'Mehr Details',
              onPressed: () => setState(() => _expanded = !_expanded),
              padding: EdgeInsets.zero,
            ),
        ],
      );
    }

    // Linke Seite: Event, Datum/Uhrzeit, Ort
    final leftCol = <Widget>[
      Text(event, style: Theme.of(context).textTheme.titleMedium),
      Row(
        children: [
          if (formattedDate.isNotEmpty)
            Text(formattedDate, style: Theme.of(context).textTheme.bodyMedium),
          if (formattedTime.isNotEmpty) ...[
            if (formattedDate.isNotEmpty) const SizedBox(width: 8),
            Text(formattedTime, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ],
      ),
      if (city.isNotEmpty || venue.isNotEmpty)
        Text('$city, $venue', style: Theme.of(context).textTheme.bodyMedium),
      // KEIN Subtitle, KEIN Pfeil hier!
    ];

    // Aufgeklappter Bereich (Expanded)
    Widget? expandedBlock;
    if (_expanded) {
      expandedBlock = Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Links: Subtitle, Eventlink, Veranstalter (mehrzeilig)
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle != null && subtitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  if (eventLink.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: TextButton(
                        onPressed: () async {
                          final uri = Uri.parse(eventLink);
                          if (await canLaunchUrl(uri)) await launchUrl(uri);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text('Eventlink'),
                      ),
                    ),
                  if ((organizer != null && organizer.isNotEmpty) ||
                      (organizerStreet != null && organizerStreet.isNotEmpty) ||
                      (organizerCity != null && organizerCity.isNotEmpty)) ...[
                    if (organizer != null && organizer.isNotEmpty)
                      Text(
                        organizer,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    if (organizerStreet != null && organizerStreet.isNotEmpty)
                      Text(
                        organizerStreet,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    if (organizerCity != null && organizerCity.isNotEmpty)
                      Text(
                        organizerCity,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ],
              ),
            ),
            // Rechts: Preise (VVK, AK) rechtsbündig
            Expanded(
              flex: 1,
              child: priceLines.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Eintritt:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        for (var l in priceLines)
                          Text(
                            l,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: leftCol,
                  ),
                ),
                Expanded(flex: 1, child: Center(child: right)),
              ],
            ),
            if (expandedBlock != null) expandedBlock,
          ],
        ),
      ),
    );
  }
}
