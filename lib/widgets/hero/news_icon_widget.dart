import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web/web.dart' as web;
import 'dart:convert';

import '../generate_hash.dart';
import 'news_widget.dart';

class NewsIconWidget extends StatefulWidget {
  const NewsIconWidget({super.key});

  @override
  State<NewsIconWidget> createState() => _NewsIconWidgetState();
}

class _NewsIconWidgetState extends State<NewsIconWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1250),
    vsync: this,
  );

  late final Animation<Color?> _colorAnimation = ColorTween(
    begin: Colors.white70,
    end: Colors.green,
  ).animate(_controller);

  bool _hasNewNews = false;

  @override
  void initState() {
    super.initState();
    _checkForNewNews();
  }

  /* ───────── News prüfen ───────── */

  Future<void> _checkForNewNews() async {
    final data = await _loadNews();
    final newHash = generateHashFromNews(data);

    final lastHash = web.window.localStorage.getItem('lastNewsHash') ?? '';

    final hasNew = newHash != lastHash;
    if (mounted) {
      setState(() {
        _hasNewNews = hasNew;
        if (hasNew) {
          _controller.repeat(reverse: true);
        } else {
          _controller.reset();
        }
      });
    }
  }

  Future<List<dynamic>> _loadNews() async {
    const url = '/news/news.json';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return jsonDecode(res.body) as List<dynamic>;
      }
    } catch (_) {}
    return [];
  }

  /* ───────── UI ───────── */

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openNewsDialog,
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (_, _) => Icon(
          Icons.newspaper,
          color: _hasNewNews ? _colorAnimation.value : Colors.white70,
          size: 28,
        ),
      ),
    );
  }

  /* ───────── Dialog & Mark as read ───────── */

  void _openNewsDialog() async {
    // Dialog anzeigen
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('News & Events'),
        content: const NewsWidget(),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Schließen'),
          ),
        ],
      ),
    );

    // Danach als „gelesen“ markieren
    if (_hasNewNews) {
      web.window.localStorage.setItem(
        'lastNewsHash',
        generateHashFromNews(await _loadNews()),
      );
      setState(() {
        _hasNewNews = false;
        _controller.reset();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
