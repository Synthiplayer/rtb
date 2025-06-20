// lib/src/pages/gallery/gallery_page.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> _images = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadGallery();
  }

  Future<void> _loadGallery() async {
    const url = 'https://ragtagbirds.de/gallery/gallery.json';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        setState(() {
          _images = data.cast<String>();
          _loading = false;
        });
      } else {
        throw Exception('Status ${res.statusCode}');
      }
    } catch (e) {
      setState(() {
        _error = 'Fehler beim Laden: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null) {
      return Scaffold(body: Center(child: Text(_error!)));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _images.length,
          itemBuilder: (ctx, i) {
            return CachedNetworkImage(
              imageUrl: _images[i],
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
