// lib/src/pages/widgets/band_section.dart
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
  static const _cardW = 240.0;
  static const _gap = 12.0;
  static const _h = 340.0;
  static const _pad = 16.0;

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
    final theme = Theme.of(context);

    // Kartenzeile als Widget-Funktion, damit wir sie zweimal verwenden können
    Widget _cardsRow() => Row(
      mainAxisSize: MainAxisSize.min, // nur so breit wie nötig
      children: [
        for (final m in bandMembers) ...[
          SizedBox(
            width: _cardW,
            child: BandMemberCard(member: m),
          ),
          if (m != bandMembers.last) const SizedBox(width: _gap),
        ],
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _pad, vertical: 8),
          child: Text(
            'Die 5 Ragtag Birds',
            style: theme.textTheme.headlineSmall,
          ),
        ),

        // ───────────────── Karten-Bereich ───────────────────────────
        SizedBox(
          height: _h,
          child: LayoutBuilder(
            builder: (ctx, cons) {
              // Gesamtbreite aller Karten + Abstände
              final totalWidth = bandMembers.length * (_cardW + _gap) - _gap;

              final bool center = totalWidth + 2 * _pad < cons.maxWidth;

              // ------------ breiter Bildschirm → Block mittig ------------
              if (center) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: _pad),
                    child: _cardsRow(),
                  ),
                );
              }

              // ------------ schmaler Bildschirm → Scroll-Variante ---------
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragUpdate: (d) {
                  final newPos = _scroll.offset - d.delta.dx;
                  _scroll.jumpTo(
                    newPos.clamp(0.0, _scroll.position.maxScrollExtent),
                  );
                },
                child: SingleChildScrollView(
                  controller: _scroll,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: _pad),
                  child: _cardsRow(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
