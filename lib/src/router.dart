// lib/src/router.dart

import 'package:go_router/go_router.dart';
import 'package:rtb/src/pages/home/home_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    // weitere Routen…
  ],
);
