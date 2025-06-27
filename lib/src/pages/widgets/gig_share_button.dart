import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart'; // <-- FEHLTE!
import 'dart:io';

import 'event_share_pic.dart';
import 'social_share_bar.dart';
import '../../ui/app_colors.dart';

class GigShareButton extends StatelessWidget {
  final String eventTitle;
  final String date;
  final String location;
  final String? priceInfo;

  const GigShareButton({
    super.key,
    required this.eventTitle,
    required this.date,
    required this.location,
    this.priceInfo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (ctx) => _GigShareSheetContent(
            eventTitle: eventTitle,
            date: date,
            location: location,
            priceInfo: priceInfo,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.share, color: Colors.white, size: 28),
          const SizedBox(height: 2),
          const Text(
            "Gig teilen",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _GigShareSheetContent extends StatefulWidget {
  final String eventTitle;
  final String date;
  final String location;
  final String? priceInfo;

  const _GigShareSheetContent({
    required this.eventTitle,
    required this.date,
    required this.location,
    this.priceInfo,
  });

  @override
  State<_GigShareSheetContent> createState() => _GigShareSheetContentState();
}

class _GigShareSheetContentState extends State<_GigShareSheetContent> {
  final ScreenshotController _screenshotController = ScreenshotController();
  String? savedImagePath;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _captureAndSave());
  }

  Future<void> _captureAndSave() async {
    final image = await _screenshotController.capture();
    if (image == null) return;
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/sharepic.png');
    await file.writeAsBytes(image);
    setState(() => savedImagePath = file.path);
  }

  Future<void> _shareImage() async {
    if (savedImagePath == null) return;
    final xFile = XFile(savedImagePath!);
    await Share.shareXFiles([xFile], text: "Ragtag Birds live!");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Screenshot(
                controller: _screenshotController,
                child: EventSharePicWidget(
                  eventTitle: widget.eventTitle,
                  date: widget.date,
                  location: widget.location,
                  priceInfo: widget.priceInfo,
                ),
              ),
              const SizedBox(height: 22),
              SocialShareBar(
                infoText: "Teile das Eventbild auf Social Media:",
                onShareInstagram: _shareImage,
                onShareTiktok: _shareImage,
                onShareFacebook: _shareImage,
                onShareWhatsapp: _shareImage,
                onCopyLink: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
