import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'gig_share_button.dart';

class MobilTourCard extends StatefulWidget {
  final Map<String, dynamic> show;
  const MobilTourCard({required this.show, super.key});

  @override
  State<MobilTourCard> createState() => _MobilTourCardState();
}

/// Gibt einen bereinigten String zurück, oder einen Fallback ("" oder null).
String safeString(dynamic value, {String fallback = ''}) {
  if (value is String) return value.trim();
  return fallback;
}

class _MobilTourCardState extends State<MobilTourCard> {
  bool _expanded = false;

  String? _buildPriceInfo(String? vvk, String? ak) {
    if ((vvk == null || vvk.isEmpty) && (ak == null || ak.isEmpty)) {
      return null; // Nicht "Eintritt frei" automatisch!
    }
    if ((vvk != null && vvk.isNotEmpty) && (ak != null && ak.isNotEmpty)) {
      return "VVK: $vvk / AK: $ak";
    }
    if (vvk != null && vvk.isNotEmpty) return "VVK: $vvk";
    if (ak != null && ak.isNotEmpty) return "AK: $ak";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final show = widget.show;
    final event = safeString(show['event'], fallback: 'Unbenanntes Event');
    final dateStr = safeString(show['date']);
    final timeStr = safeString(show['time']);
    final city = safeString(show['city']);
    final venue = safeString(show['venue']);
    final advance = safeString(show['advance']);
    final before = safeString(show['before']);
    final ticketUrl = safeString(show['url']);
    final eventLink = safeString(show['eventlink']);
    final organizer = safeString(show['organizer']);
    final organizerStreet = safeString(show['organizer_street']);
    final organizerCity = safeString(show['organizer_city']);
    final subtitle = safeString(show['subtitle']);

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
    if (advance.isNotEmpty) priceLines.add('VVK: $advance');
    if (before.isNotEmpty) priceLines.add('AK: $before');

    // Immer aufklappbar, also immer Pfeil anzeigen
    Widget right = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (ticketUrl.isNotEmpty)
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
        IconButton(
          icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
          tooltip: _expanded ? 'Weniger Details' : 'Mehr Details',
          onPressed: () => setState(() => _expanded = !_expanded),
          padding: EdgeInsets.zero,
        ),
      ],
    );

    // Unaufgeklappte linke Seite: Event, Datum/Uhrzeit, Ort
    final showDate = formattedTime.isNotEmpty
        ? '$formattedDate – $formattedTime'
        : formattedDate;

    final leftCol = <Widget>[
      Text(event, style: Theme.of(context).textTheme.titleMedium),
      if (showDate.isNotEmpty)
        Text(showDate, style: Theme.of(context).textTheme.bodyMedium),
      if (city.isNotEmpty || venue.isNotEmpty)
        Text('$city, $venue', style: Theme.of(context).textTheme.bodyMedium),
    ];

    // --- Expanded-Bereich ---
    Widget? expandedBlock;
    if (_expanded) {
      expandedBlock = Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Gig teilen (AppColors.accent)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GigShareButton(
                      eventTitle: event,
                      subtitle: subtitle.isNotEmpty ? subtitle : null,
                      date: formattedTime.isNotEmpty
                          ? '$formattedDate – $formattedTime'
                          : formattedDate,
                      location: [
                        city,
                        venue,
                      ].where((s) => s.isNotEmpty).join(', '),
                      priceInfo: _buildPriceInfo(advance, before),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 2. Subtitle
                  if (subtitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  // 3. Eventlink (Textbutton)
                  if (eventLink.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: TextButton.icon(
                        onPressed: () async {
                          final uri = Uri.parse(eventLink);
                          if (await canLaunchUrl(uri)) await launchUrl(uri);
                        },
                        icon: const Icon(Icons.link, size: 18),
                        label: const Text('Weitere Infos zum Event'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          foregroundColor: Colors.blue[700],
                        ),
                      ),
                    ),
                  // 4. Adresse/Veranstalter
                  if (organizer.isNotEmpty ||
                      organizerStreet.isNotEmpty ||
                      organizerCity.isNotEmpty) ...[
                    if (organizer.isNotEmpty)
                      Text(
                        organizer,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    if (organizerStreet.isNotEmpty)
                      Text(
                        organizerStreet,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    if (organizerCity.isNotEmpty)
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
            // Rechte Seite: Preise rechtsbündig
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
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
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
            if (_expanded) const SizedBox(height: 12),
            if (expandedBlock != null) expandedBlock,
          ],
        ),
      ),
    );
  }
}
