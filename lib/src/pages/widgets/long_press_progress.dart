import 'dart:async';

import 'package:flutter/material.dart';

/// Zeigt eine runde Fortschritts­anzeige über [child] beim langen Drücken.
/// Wenn der Fortschritt (dauerSeconds) erreicht ist, wird [onLongPressComplete] getriggert.
class LongPressProgress extends StatefulWidget {
  final Widget child;
  final VoidCallback onLongPressComplete;
  final double size;
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
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onLongPressComplete();
        }
      });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    _controller.forward();
  }

  void _onTapUp(_) {
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
          // the progress indicator
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
