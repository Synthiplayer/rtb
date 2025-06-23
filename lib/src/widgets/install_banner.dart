// lib/src/widgets/install_banner.dart

import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:js_util'; // promiseToFuture
import '../ui/app_colors.dart';

class InstallBanner extends StatefulWidget {
  const InstallBanner({super.key});
  @override
  State<InstallBanner> createState() => _InstallBannerState();
}

class _InstallBannerState extends State<InstallBanner> {
  dynamic _deferredPrompt;
  bool _showBanner = kIsWeb;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      html.window.addEventListener('beforeinstallprompt', (event) {
        event.preventDefault();
        _deferredPrompt = event;
        _blockIframes(); // Iframes blocken
        setState(() => _showBanner = true);
      });
    }
  }

  void _blockIframes() {
    html.document
        .querySelectorAll('iframe')
        .forEach((el) => el.style.pointerEvents = 'none');
  }

  void _unblockIframes() {
    html.document
        .querySelectorAll('iframe')
        .forEach((el) => el.style.pointerEvents = 'auto');
  }

  Future<void> _install() async {
    if (_deferredPrompt != null) {
      await promiseToFuture(_deferredPrompt.callMethod('prompt'));
      await promiseToFuture(_deferredPrompt.callMethod('userChoice'));
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text(
            'Installation',
            style: TextStyle(color: AppColors.text),
          ),
          content: const Text(
            'Tippe im Chrome-Menü auf „Zum Startbildschirm“',
            style: TextStyle(color: AppColors.text),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    _unblockIframes(); // Iframes wieder freigeben
    setState(() => _showBanner = false);
    _deferredPrompt = null;
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb || !_showBanner) return const SizedBox.shrink();
    return Stack(
      children: [
        const ModalBarrier(color: Colors.black54, dismissible: false),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 8),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      'Ragtag Birds installieren?',
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _install,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.accent,
                    ),
                    child: const Text('Jetzt installieren'),
                  ),
                  TextButton(
                    onPressed: () {
                      _unblockIframes();
                      setState(() => _showBanner = false);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.fadedText,
                    ),
                    child: const Text('Abbrechen'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
