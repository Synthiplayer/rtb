import 'package:flutter/material.dart';
import '../widgets/shirtee_iframe.dart';
import '../widgets/band_drawer.dart';

class ShopDetailPage extends StatelessWidget {
  const ShopDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Merch-Shop'),
        leading: canPop ? const BackButton() : null,
      ),
      drawer: const BandDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            SizedBox(height: 12),
            ShirteeIframe(), // Widget mit Shirtee-iFrame
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
