// File: lib/src/router.dart
import 'package:go_router/go_router.dart';
import 'package:rtb/src/pages/booking_page.dart';
import 'package:rtb/src/pages/gallery_page.dart';
import 'package:rtb/src/pages/home/home_page.dart';
import 'package:rtb/src/pages/impressum_page.dart';
import 'package:rtb/src/pages/detail_page.dart';
import 'package:rtb/src/pages/references_page.dart'; // neu
import 'package:rtb/src/data/band_members.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (ctx, st) => const HomePage()),
    GoRoute(path: '/gallery', builder: (ctx, st) => const GalleryPage()),
    GoRoute(path: '/booking', builder: (ctx, st) => const BookingPage()),
    GoRoute(path: '/impressum', builder: (ctx, st) => const ImpressumPage()),
    GoRoute(
      path: '/references',
      builder: (ctx, st) => const ReferencesPage(),
    ), // neu
    GoRoute(
      path: '/member/:index',
      builder: (ctx, st) {
        final idx = int.tryParse(st.pathParameters['index']!) ?? 0;
        return DetailPage(member: bandMembers[idx]);
      },
    ),
  ],
);
