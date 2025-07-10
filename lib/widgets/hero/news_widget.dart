import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  List<dynamic>? _news;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    const url = '/news/news.json';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        setState(() {
          _news = jsonDecode(res.body) as List<dynamic>;
        });
      } else {
        setState(() {
          _error = 'Server-Fehler (${res.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Fehler beim Laden: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(_error!, style: const TextStyle(color: Colors.red)),
      );
    }
    if (_news == null) {
      return const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_news!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Keine News verfügbar.'),
      );
    }

    return SizedBox(
      width: double.maxFinite,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _news!.length,
        separatorBuilder: (_, _) => const Divider(),
        itemBuilder: (ctx, i) {
          final item = _news![i] as Map<String, dynamic>;
          final imageUrl = item['image'] as String? ?? '';
          final title = item['title'] as String? ?? '';
          final date = item['date'] as String? ?? '';
          final content = item['content'] as String? ?? '';
          final author = item['author'] as String? ?? '';
          final link = item['link'] as String? ?? '';
          final tags = (item['tags'] as List?)?.cast<String>() ?? [];

          return ListTile(
            leading: imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      imageUrl,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          const Icon(Icons.image_not_supported, size: 32),
                    ),
                  )
                : null,
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (date.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      date,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ),
                if (author.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      'von $author',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                if (content.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(content, style: const TextStyle(fontSize: 15)),
                  ),
                if (tags.isNotEmpty)
                  Wrap(
                    spacing: 4,
                    children: tags
                        .map((tag) => Chip(label: Text(tag)))
                        .toList(),
                  ),
                if (link.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: TextButton.icon(
                      icon: const Icon(Icons.link),
                      label: const Text('Mehr erfahren'),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () async {
                        final uri = Uri.tryParse(link);
                        if (uri != null && await canLaunchUrl(uri)) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
