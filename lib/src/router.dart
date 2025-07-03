// File: lib/src/router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rtb/src/pages/booking_page.dart';
import 'package:rtb/src/pages/gallery_page.dart';
import 'package:rtb/src/pages/home/home_page.dart';
import 'package:rtb/src/pages/impressum_page.dart';
import 'package:rtb/src/pages/detail_page.dart';
import 'package:rtb/src/pages/references_page.dart';
import 'package:rtb/src/data/band_members.dart';
import 'package:rtb/src/pages/widgets/media_detail_page.dart';

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  errorBuilder: (context, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fehler')),
      body: Center(child: Text('Routing-Fehler:\n${state.error}')),
    );
  },
  routes: [
    GoRoute(path: '/', builder: (ctx, state) => const HomePage()),
    GoRoute(path: '/gallery', builder: (ctx, state) => const GalleryPage()),
    GoRoute(path: '/booking', builder: (ctx, state) => const BookingPage()),
    GoRoute(path: '/impressum', builder: (ctx, state) => const ImpressumPage()),
    GoRoute(
      path: '/references',
      builder: (ctx, state) => const ReferencesPage(),
    ),
    GoRoute(path: '/media', builder: (ctx, state) => const MediaDetailPage()),
    GoRoute(
      path: '/member/:index',
      builder: (ctx, state) {
        final idx = int.tryParse(state.pathParameters['index']!) ?? 0;
        return DetailPage(member: bandMembers[idx]);
      },
    ),
    GoRoute(path: '/:_(.*)', redirect: (ctx, state) => '/'),
  ],
);
