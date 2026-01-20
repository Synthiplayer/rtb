// desktop_tour_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'gig_share_button.dart';

/// Desktop-Version einer Tour-Karte im Tabellen-Layout.
class DesktopTourCard extends StatefulWidget {
  final Map<String, dynamic> show;
  const DesktopTourCard({required this.show, super.key});

  @override
  State<DesktopTourCard> createState() => _DesktopTourCardState();
}

class _DesktopTourCardState extends State<DesktopTourCard> {
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
    String str(String key) => (widget.show[key] as String?)?.trim() ?? '';

    final eventRaw = str('event');
    final event = eventRaw.isNotEmpty ? eventRaw : 'Unbenanntes Event';
    final dateStr = str('date');
    final timeStr = str('time');
    final city = str('city');
    final venue = str('venue');
    final advance = str('advance');
    final before = str('before');
    final ticketUrl = str('tickets');
    final eventLink = str('eventlink');
    final subtitle = str('subtitle');
    final organizer = str('organizer');
    final organizerStreet = str('organizer_street');
    final organizerCity = str('organizer_city');

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
    final showDate = formattedTime.isNotEmpty
        ? '$formattedDate, $formattedTime'
        : formattedDate;

    final priceLines = <String>[];
    if (advance.isNotEmpty) priceLines.add('VVK: $advance');
    if (before.isNotEmpty) priceLines.add('AK: $before');

    final expandedBlock = Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GigShareButton(
                  eventTitle: event,
                  subtitle: subtitle.isNotEmpty ? subtitle : null,
                  date: showDate,
                  location: [city, venue].where((s) => s.isNotEmpty).join(', '),
                  priceInfo: _buildPriceInfo(advance, before),
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
                        await launchUrl(uri);
                      },
                      icon: const Icon(Icons.link, size: 18),
                      label: const Text('Weitere Infos zum Event'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        textStyle: const TextStyle(fontWeight: FontWeight.w500),
                        foregroundColor: Colors.blue,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (organizer.isNotEmpty ||
                    organizerStreet.isNotEmpty ||
                    organizerCity.isNotEmpty) ...[
                  Text(
                    'Veranstalter:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (organizer.isNotEmpty)
                    Text(
                      organizer,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  if (organizerStreet.isNotEmpty)
                    Text(
                      organizerStreet,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  if (organizerCity.isNotEmpty)
                    Text(
                      organizerCity,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    event,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Text(showDate, overflow: TextOverflow.ellipsis),
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
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 95,
                        alignment: Alignment.centerRight,
                        child: Builder(
                          builder: (context) {
                            if (ticketUrl.isNotEmpty) {
                              return TextButton(
                                onPressed: () =>
                                    launchUrl(Uri.parse(ticketUrl)),
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text('Tickets'),
                              );
                            }
                            if (priceLines.isEmpty) {
                              return const Text(
                                'Eintritt frei',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _expanded ? Icons.expand_less : Icons.expand_more,
                        ),
                        tooltip: _expanded ? 'Weniger Details' : 'Mehr Details',
                        onPressed: () => setState(() => _expanded = !_expanded),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_expanded) expandedBlock,
        ],
      ),
    );
  }
}
