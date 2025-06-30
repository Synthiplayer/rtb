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

class _MobilTourCardState extends State<MobilTourCard> {
  bool _expanded = false;

  String? _buildPriceInfo(String? vvk, String? ak) {
    if ((vvk == null || vvk.isEmpty) && (ak == null || ak.isEmpty)) {
      return "Eintritt frei";
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
                      date:
                          formattedDate +
                          (formattedTime.isNotEmpty ? ' $formattedTime' : ''),
                      location: [
                        city,
                        venue,
                      ].where((s) => s.isNotEmpty).join(', '),
                      priceInfo: _buildPriceInfo(advance, before),
                    ),
                  ),

                  const SizedBox(height: 12),
                  // 2. Subtitle
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
            if (_expanded) const SizedBox(height: 12),
            if (expandedBlock != null) expandedBlock,
          ],
        ),
      ),
    );
  }
}
