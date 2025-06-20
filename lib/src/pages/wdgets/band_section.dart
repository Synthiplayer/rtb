// lib/src/pages/widgets/band_section.dart
//
// Horizontale Band-Section mit eigenem ScrollController + GestureDetector.
// ● Click-&-Drag (Maus) oder Wischen (Touch) scrollt die Zeile.
// ● Kein Overflow dank fixer Kartenbreite.

import 'package:flutter/material.dart';

import '../../components/band_member_card.dart';
import '../../data/band_members.dart';

class BandSection extends StatefulWidget {
  const BandSection({super.key});

  @override
  State<BandSection> createState() => _BandSectionState();
}

class _BandSectionState extends State<BandSection> {
  // Layout-Konstanten
  static const _cardWidth = 240.0;
  static const _gap = 12.0;
  static const _sectionHeight = 340.0;

  late final ScrollController _scroll;

  @override
  void initState() {
    super.initState();
    _scroll = ScrollController();
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Die 5 Ragtag Birds',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        //------------------ Scrollbarer Bereich ------------------------
        SizedBox(
          height: _sectionHeight,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            // Maus-Drag / Touch-Wisch
            onHorizontalDragUpdate: (details) {
              final newPos = _scroll.offset - details.delta.dx;
              _scroll.jumpTo(
                newPos.clamp(0.0, _scroll.position.maxScrollExtent),
              );
            },
            child: SingleChildScrollView(
              controller: _scroll,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  for (final member in bandMembers) ...[
                    SizedBox(
                      width: _cardWidth,
                      child: BandMemberCard(member: member),
                    ),
                    const SizedBox(width: _gap),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
