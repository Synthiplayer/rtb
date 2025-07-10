import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtb/widgets/hero/pwa_install_info.dart';

class InstallGuideDialog extends StatefulWidget {
  const InstallGuideDialog({super.key});

  @override
  State<InstallGuideDialog> createState() => _InstallGuideDialogState();
}

class _InstallGuideDialogState extends State<InstallGuideDialog> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // 👉 explizit Roboto
      title: Text(
        'Als App hinzufügen',
        style: GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.titleLarge,
          fontWeight: FontWeight.w600, // falls du’s etwas fetter willst
        ),
      ),
      content: PwaInstallInfo(
        checked: _checked,
        onChanged: (val) => setState(() => _checked = val ?? false),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(_checked),
          child: const Text('Alles klar'),
        ),
      ],
    );
  }
}
