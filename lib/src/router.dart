import 'package:go_router/go_router.dart';
import 'package:rtb/src/pages/booking_page.dart';
import 'package:rtb/src/pages/gallery_page.dart';
import 'package:rtb/src/pages/home/home_page.dart';
import 'package:rtb/src/pages/impressum_page.dart';
import 'package:rtb/src/pages/detail_page.dart';
import 'package:rtb/src/data/band_members.dart';

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
    // Detail-Route für Band-Mitglieder
    GoRoute(
      path: '/member/:index',
      builder: (context, state) {
        final idx = int.tryParse(state.pathParameters['index']!) ?? 0;
        final member = bandMembers[idx];
        return DetailPage(member: member);
      },
    ),
  ],
);
