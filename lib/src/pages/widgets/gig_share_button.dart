import 'dart:js_interop';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import 'event_share_pic.dart';
import '../../ui/app_colors.dart';

// Interop zu JS (web/index.html muss wie gehabt die Funktion exportieren!)
@JS('shareImageWeb')
external JSAny? _shareImageWeb(
  JSUint8Array bytes,
  String filename,
  String text,
);

void shareImageWeb(Uint8List bytes, String filename, String text) {
  final jsBytes = bytes.toJS;
  _shareImageWeb(jsBytes, filename, text);
}

class GigShareButton extends StatelessWidget {
  final String eventTitle;
  final String? subtitle;
  final String date;
  final String location;
  final String? priceInfo;

  const GigShareButton({
    super.key,
    required this.eventTitle,
    this.subtitle,
    required this.date,
    required this.location,
    this.priceInfo,
  });

  Future<void> _doShare(BuildContext context) async {
    final screenshotController = ScreenshotController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final sharePicWidget = Positioned(
      top: -10000,
      left: 0,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Screenshot(
            controller: screenshotController,
            child: EventSharePicWidget(
              eventTitle: eventTitle,
              subtitle: subtitle,
              date: date,
              location: location,
              priceInfo: priceInfo,
            ),
          ),
        ),
      ),
    );

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(builder: (ctx) => sharePicWidget);
    overlay.insert(overlayEntry);

    await Future.delayed(const Duration(milliseconds: 120));
    final imageBytes = await screenshotController.capture();

    overlayEntry.remove();
    Navigator.of(context).pop();

    if (imageBytes != null) {
      shareImageWeb(imageBytes, 'sharepic.png', 'Ragtag Birds live!');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bild konnte nicht erstellt werden.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _doShare(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.share, color: AppColors.accent, size: 28),
          const SizedBox(height: 2),
          Text(
            "Gigbild teilen",
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
