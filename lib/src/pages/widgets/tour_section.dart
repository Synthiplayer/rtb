import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'tour_card.dart'; // Importiere das ausgelagerte Widget

class TourSection extends StatefulWidget {
  const TourSection({super.key});

  @override
  State<TourSection> createState() => _TourSectionState();
}

class _TourSectionState extends State<TourSection> {
  bool _loading = true;
  String? _error;
  List<Map<String, dynamic>> _shows = [];

  @override
  void initState() {
    super.initState();
    _loadTour();
  }

  Future<void> _loadTour() async {
    const url = '/tour/tour.json';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List<dynamic>;
        setState(() {
          _shows = data.cast<Map<String, dynamic>>();
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
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Text(_error!, style: const TextStyle(color: Colors.red)),
      );
    }
    if (_shows.isEmpty) {
      return const Center(child: Text('Keine Termine verfügbar.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Tourdaten',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ),
        ..._shows.map((show) => TourCard(show: show)),
      ],
    );
  }
}
