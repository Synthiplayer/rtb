import 'package:flutter/material.dart';
import '../../ui/breakpoints.dart';
import 'desktop_tour_card.dart';
import 'mobil_tour_card.dart';

class TourCard extends StatelessWidget {
  final Map<String, dynamic> show;
  const TourCard({required this.show, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= Breakpoints.mobile;

    if (isDesktop) {
      return DesktopTourCard(show: show);
    } else {
      return MobilTourCard(show: show);
    }
  }
}
