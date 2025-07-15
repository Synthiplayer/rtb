import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class ShirteeIframe extends StatelessWidget {
  const ShirteeIframe({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height, // voller Viewport
      child: HtmlElementView.fromTagName(
        tagName: 'iframe',
        key: const ValueKey('shirtee-iframe'),
        onElementCreated: (element) {
          final iframe = element as web.HTMLIFrameElement
            ..id =
                'shirtee-iframe' // ★ ID setzen
            ..src = 'https://www.shirtee.com/de/iframe/?store_id=101201'
            ..width = '100%'
            ..height = '100%'
            ..loading = 'lazy'
            ..setAttribute('scrolling', 'yes'); // Scrollbars

          // Style-Eigenschaften
          iframe.style
            ..border = 'none'
            ..setProperty('overflow', 'auto')
            ..setProperty('-webkit-overflow-scrolling', 'touch');
        },
      ),
    );
  }
}
