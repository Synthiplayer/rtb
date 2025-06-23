// lib/src/pages/home/home_page.dart

import 'package:flutter/material.dart';
import '../../components/responsive_scaffold.dart';
import '../../widgets/install_banner.dart';
import 'home_body.dart';

/// Entscheidet automatisch zwischen Mobile (Drawer) und Desktop (AppBar-Buttons).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [ResponsiveScaffold(body: const HomeBody())]);
  }
}
