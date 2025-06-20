import 'package:flutter/material.dart';
import '../../data/band_members.dart';
import '../../components/band_member_card.dart';

class BandSection extends StatelessWidget {
  const BandSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (_, i) => BandMemberCard(member: bandMembers[i]),
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: bandMembers.length,
      ),
    );
  }
}
