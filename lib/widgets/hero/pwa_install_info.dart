import 'package:flutter/material.dart';

class PwaInstallInfo extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool?> onChanged;

  const PwaInstallInfo({
    super.key,
    required this.checked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Speichere diese Seite wie eine App auf deinem Startbildschirm. '
            'So öffnest du sie künftig direkt ohne Umweg über den Browser.',
          ),
          const SizedBox(height: 16),
          const Text('• Android (Chrome):'),
          const Text('    1. Menü (⋮) öffnen'),
          const Text('    2. „Zum Startbildschirm hinzufügen“ wählen'),
          const Text('    3. Bestätigen'),
          const SizedBox(height: 12),
          const Text('• iPhone (Safari):'),
          const Text('    1. Teilen-Button (□↑) antippen'),
          const Text('    2. „Zum Home-Bildschirm“ auswählen'),
          const Text('    3. Hinzufügen'),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(value: checked, onChanged: onChanged),
              const Expanded(
                child: Text('Installationsanleitung nicht mehr anzeigen'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
