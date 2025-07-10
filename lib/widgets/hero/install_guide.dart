import 'package:flutter/material.dart';
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
      // Thema-Textstyle nutzen, z.B. titleLarge
      title: Text(
        'Als App hinzufügen',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600, // falls etwas fetter gewünscht
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
