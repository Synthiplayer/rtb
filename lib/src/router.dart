// lib/src/router.dart

import 'package:go_router/go_router.dart';
import 'package:rtb/src/pages/booking_page.dart';
import 'package:rtb/src/pages/gallery_page.dart';
import 'package:rtb/src/pages/home/home_page.dart';
import 'package:rtb/src/pages/impressum_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    // Tour läuft per Scroll-Anker in HomePage; keine eigene Route
    GoRoute(path: '/gallery', builder: (context, state) => const GalleryPage()),
    GoRoute(path: '/booking', builder: (context, state) => const BookingPage()),
    GoRoute(
      path: '/impressum',
      builder: (context, state) => const ImpressumPage(),
    ),
  ],
);
