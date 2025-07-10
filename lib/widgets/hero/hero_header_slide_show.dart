import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:web/web.dart' as web;

import '../../providers/install_flag_provider.dart';
import '../../ui/app_colors.dart';
import '../../ui/breakpoints.dart';
import '../generate_hash.dart';
import 'news_widget.dart';
import 'hero_slideshow_background.dart';
import 'hero_title_overlay.dart';
import 'hero_install_guide_button.dart';
import 'hero_news_button.dart';
import 'install_guide.dart';

class HeroHeaderSlideshow extends ConsumerStatefulWidget {
  const HeroHeaderSlideshow({super.key});

  @override
  ConsumerState<HeroHeaderSlideshow> createState() =>
      _HeroHeaderSlideshowState();
}

class _HeroHeaderSlideshowState extends ConsumerState<HeroHeaderSlideshow>
    with SingleTickerProviderStateMixin {
  final List<String> _images = [
    'assets/images/hero.jpeg',
    'assets/images/hero2.jpeg',
    'assets/images/hero3.jpeg',
  ];

  int _currentIndex = 0;
  late Timer _timer;

  String? _latestNewsHash;
  bool _hasNewNews = false;

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  /* ───────────────────────── init / dispose ───────────────────────── */

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _images.length;
      });
    });

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1250),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Colors.white70,
      end: AppColors.accent,
    ).animate(_controller);

    _checkForNewNews();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  /* ───────────────────────── News-Handling ───────────────────────── */

  Future<void> markNewsAsRead() async {
    if (_latestNewsHash == null) return;

    // Hash im localStorage ablegen
    web.window.localStorage.setItem('lastNewsHash', _latestNewsHash!);

    setState(() => _hasNewNews = false);
    _controller.reset();
  }

  Future<void> _checkForNewNews() async {
    final news = await _loadNews();
    final newHash = generateHashFromNews(news);

    final lastNewsHash = web.window.localStorage.getItem('lastNewsHash') ?? '';
    final hasNew = newHash != lastNewsHash;

    setState(() => _hasNewNews = hasNew);

    if (hasNew) {
      _controller.repeat(reverse: true);
    } else {
      _controller.reset();
    }

    _latestNewsHash = newHash;
  }

  Future<List<Map<String, dynamic>>> _loadNews() async {
    const url = '/news/news.json';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as List<dynamic>;
        return data.cast<Map<String, dynamic>>();
      }
    } catch (_) {}
    return [];
  }

  /* ───────────────────────── PWA-Status ───────────────────────── */

  bool get _isPwaInstalled {
    if (!kIsWeb) return false;
    try {
      final isStandalone = web.window
          .matchMedia('(display-mode: standalone)')
          .matches;
      final isIosStandalone =
          (web.window.navigator as dynamic).standalone == true;
      return isStandalone || isIosStandalone;
    } catch (_) {
      return false;
    }
  }

  bool _isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < Breakpoints.mobile;

  /* ───────────────────────── UI ───────────────────────── */

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= Breakpoints.mobile;
    final double height = isDesktop
        ? 350
        : (size.height * 0.3 < 220 ? 220 : size.height * 0.3);

    final hideInstallGuide = ref.watch(hideInstallGuideProvider);
    final showInstallGuide =
        _isMobile(context) && !_isPwaInstalled && !hideInstallGuide;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: _buildHeroContent(
        context: context,
        size: size,
        isDesktop: isDesktop,
        height: height,
        showInstallGuide: showInstallGuide,
      ),
    );
  }

  Widget _buildHeroContent({
    required BuildContext context,
    required Size size,
    required bool isDesktop,
    required double height,
    required bool showInstallGuide,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        HeroSlideshowBackground(
          images: _images,
          currentIndex: _currentIndex,
          height: height,
        ),
        HeroTitleOverlay(isDesktop: isDesktop),
        HeroInstallGuideButton(
          show: showInstallGuide,
          width: size.width,
          height: height,
          isDesktop: isDesktop,
          onShowDialog: () => _showPwaInfoDialog(context),
        ),
        HeroNewsButton(
          isDesktop: isDesktop,
          width: size.width,
          height: height,
          colorAnimation: _colorAnimation,
          hasNewNews: _hasNewNews,
          onOpenNewsDialog: () async {
            await markNewsAsRead();
            if (!mounted) return;
            _openNewsDialog(context);
            Future.delayed(const Duration(milliseconds: 250), _checkForNewNews);
          },
        ),
      ],
    );
  }

  /* ───────────────────────── Dialoge ───────────────────────── */

  Future<void> _showPwaInfoDialog(BuildContext context) async {
    final neverShowAgain =
        await showDialog<bool>(
          context: context,
          builder: (_) => const InstallGuideDialog(),
        ) ??
        false;

    if (neverShowAgain) {
      ref.read(hideInstallGuideProvider.notifier).set(true);
    }
  }

  void _openNewsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'News & Events',
          style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20, // falls du die Größe explizit möchtest
          ),
        ),
        content: const NewsWidget(),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Schließen'),
          ),
        ],
      ),
    );
  }
}
