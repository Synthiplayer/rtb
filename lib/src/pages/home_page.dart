// lib/src/pages/home/home_page.dart
import 'package:flutter/material.dart';
import '../ui/responsive_layout.dart';
import 'home_mobile.dart';
import 'home_desktop.dart';

/// Entscheidungs-Widget: Mobile vs. Desktop
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const HomePageMobile(),
      desktop: const HomePageDesktop(),
    );
  }
}
