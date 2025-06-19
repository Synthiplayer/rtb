// lib/src/app.dart
import 'package:flutter/material.dart';
import 'package:rtb/src/ui/theme.dart';
import 'router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ragtag Birds',
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
