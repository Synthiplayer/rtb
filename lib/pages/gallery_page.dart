// lib/src/pages/gallery/gallery_page.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:photo_view/photo_view_gallery.dart';

import '../widgets/band_drawer.dart';
import '../widgets/responsive_scaffold.dart';

/// Zeigt alle Bilder in assets/images/gallery/ als Gitter.
/// Tippen öffnet einen Vollbild-Viewer (GalleryViewer).
class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> _images = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadGalleryAssets();
  }

  /// Liest AssetManifest.json und filtert nach /gallery/.
  Future<void> _loadGalleryAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final images =
        manifestMap.keys
            .where((p) => p.startsWith('assets/images/gallery/'))
            .toList()
          ..sort(); // optional alphabetisch

    setState(() {
      _images = images;
      _loading = false;
    });
  }

  void _openViewer(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GalleryViewer(images: _images, initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const ResponsiveScaffold(
        body: Center(child: CircularProgressIndicator()),
        drawer: BandDrawer(),
      );
    }

    return ResponsiveScaffold(
      drawer: const BandDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: _images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (ctx, i) => GestureDetector(
            onTap: () => _openViewer(i),
            child: Image.asset(_images[i], fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

/// Vollbild-Galerie mit Blätter-Funktion
class GalleryViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const GalleryViewer({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<GalleryViewer> createState() => _GalleryViewerState();
}

class _GalleryViewerState extends State<GalleryViewer> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _previous() => _pageController.previousPage(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  void _next() => _pageController.nextPage(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${_currentIndex + 1}/${widget.images.length}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: widget.images.length,
            builder: (_, index) => PhotoViewGalleryPageOptions(
              imageProvider: AssetImage(widget.images[index]),
            ),
            onPageChanged: (index) => setState(() => _currentIndex = index),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
          if (isDesktop) ...[
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: _previous,
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onPressed: _next,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
