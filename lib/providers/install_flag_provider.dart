import 'package:web/web.dart' as web;
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _keyHide = 'hideInstallGuide';

final hideInstallGuideProvider =
    NotifierProvider<HideInstallGuideNotifier, bool>(
      HideInstallGuideNotifier.new,
    );

class HideInstallGuideNotifier extends Notifier<bool> {
  @override
  bool build() {
    final stored = web.window.localStorage.getItem(_keyHide);
    return stored == 'true';
  }

  void set(bool value) {
    state = value;
    web.window.localStorage.setItem(_keyHide, value.toString());
  }
}
