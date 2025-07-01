// lib/src/pages/widgets/band_section.dart
import 'package:flutter/material.dart';
import '../../components/band_member_card.dart';
import '../../data/band_members.dart';
import '../detail_page.dart';

/// Bereich mit horizontal scrollbarer Reihe von BandMemberCards.
class BandSection extends StatefulWidget {
  const BandSection({Key? key}) : super(key: key);

  @override
  State<BandSection> createState() => _BandSectionState();
}

class _BandSectionState extends State<BandSection> {
  static const _cardWidth = 240.0;
  static const _gap = 12.0;
  static const _height = 340.0;
  static const _padding = 16.0;

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget cardsRow() => Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(bandMembers.length * 2 - 1, (index) {
        if (index.isEven) {
          final member = bandMembers[index ~/ 2];
          return SizedBox(
            width: _cardWidth,
            child: BandMemberCard(
              member: member,
              onLongPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailPage(member: member)),
                );
              },
            ),
          );
        }
        return const SizedBox(width: _gap);
      }),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _padding,
            vertical: 8,
          ),
          child: Text('Die 5 Birds', style: theme.textTheme.headlineSmall),
        ),
        SizedBox(
          height: _height,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final totalWidth =
                  bandMembers.length * _cardWidth +
                  (bandMembers.length - 1) * _gap;
              final fits = totalWidth + 2 * _padding <= constraints.maxWidth;

              if (fits) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: _padding),
                    child: cardsRow(),
                  ),
                );
              }

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragUpdate: (details) {
                  final newOffset = _scrollController.offset - details.delta.dx;
                  _scrollController.jumpTo(
                    newOffset.clamp(
                      0.0,
                      _scrollController.position.maxScrollExtent,
                    ),
                  );
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: _padding),
                  child: cardsRow(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
