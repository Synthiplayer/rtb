import 'package:flutter/material.dart';

/// Zeigt eine runde Fortschrittsanzeige über [child], wenn der Nutzer lange drückt.
/// Bei Erreichen des vollen Fortschritts (definiert durch [duration])
/// wird [onLongPressComplete] ausgeführt.
class LongPressProgress extends StatefulWidget {
  /// Das Kind-Widget, über dem die Progress-Anzeige liegt.
  final Widget child;

  /// Wird ausgeführt, wenn der Fortschritt komplett ist (langer Druck beendet).
  final VoidCallback onLongPressComplete;

  /// Größe des Fortschrittsindikators.
  final double size;

  /// Dauer, wie lange gedrückt werden muss.
  final Duration duration;

  const LongPressProgress({
    super.key,
    required this.child,
    required this.onLongPressComplete,
    this.size = 48,
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  State<LongPressProgress> createState() => _LongPressProgressState();
}

class _LongPressProgressState extends State<LongPressProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        // Startet Callback, sobald Animation/Progress abgeschlossen ist
        if (status == AnimationStatus.completed) {
          widget.onLongPressComplete();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.child,
          // Fortschrittsanzeige (sichtbar während des langen Drückens)
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => CircularProgressIndicator(
                value: _controller.value,
                strokeWidth: 2,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
