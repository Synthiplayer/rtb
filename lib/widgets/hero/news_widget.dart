import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (ctx, i) {
          final item = _news![i] as Map<String, dynamic>;
          return ListTile(
            title: Text(
              item['title'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((item['date'] ?? '').isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      item['date'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ),
                if ((item['content'] ?? '').isNotEmpty)
                  Text(item['content'], style: const TextStyle(fontSize: 15)),
              ],
            ),
            // onTap: () { /* Optional: Detailseite, Link, ... */ },
          );
        },
      ),
    );
  }
}
