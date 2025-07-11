// mobil_tour_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'gig_share_button.dart';

/// Gibt einen bereinigten String zurück, oder einen Fallback ("" oder null).
String safeString(dynamic value, {String fallback = ''}) {
  if (value is String) return value.trim();
  return fallback;
}

class MobilTourCard extends StatefulWidget {
  final Map<String, dynamic> show;
  const MobilTourCard({required this.show, super.key});

  @override
  State<MobilTourCard> createState() => _MobilTourCardState();
}

class _MobilTourCardState extends State<MobilTourCard> {
  bool _expanded = false;

  String? _buildPriceInfo(String? vvk, String? ak) {
    if ((vvk == null || vvk.isEmpty) && (ak == null || ak.isEmpty)) {
      return null;
    }
    if ((vvk?.isNotEmpty == true) && (ak?.isNotEmpty == true)) {
      return "VVK: $vvk / AK: $ak";
    }
    if (vvk?.isNotEmpty == true) return "VVK: $vvk";
    if (ak?.isNotEmpty == true) return "AK: $ak";
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

    Widget right = Column(
      mainAxisSize: MainAxisSize.min,
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

    final showDate = formattedTime.isNotEmpty
        ? '$formattedDate – $formattedTime'
        : formattedDate;
    final leftCol = <Widget>[
      Text(
        event,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      if (showDate.isNotEmpty)
        Text(showDate, style: Theme.of(context).textTheme.bodyMedium),
      if (city.isNotEmpty || venue.isNotEmpty)
        Text('$city, $venue', style: Theme.of(context).textTheme.bodyMedium),
    ];

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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GigShareButton(
                      eventTitle: event,
                      subtitle: subtitle.isNotEmpty ? subtitle : null,
                      date: showDate,
                      location: [
                        city,
                        venue,
                      ].where((s) => s.isNotEmpty).join(', '),
                      priceInfo: _buildPriceInfo(advance, before),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (subtitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
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
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          foregroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  if (organizer.isNotEmpty ||
                      organizerStreet.isNotEmpty ||
                      organizerCity.isNotEmpty) ...[
                    if (organizer.isNotEmpty)
                      Text(
                        organizer,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    if (organizerStreet.isNotEmpty)
                      Text(
                        organizerStreet,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    if (organizerCity.isNotEmpty)
                      Text(
                        organizerCity,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                  ],
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: priceLines.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Eintritt:',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        for (var l in priceLines)
                          Text(
                            l,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
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
