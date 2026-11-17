/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'dart:math';
import 'package:material_ui/material_ui.dart';

class EzCountdownTimer extends StatefulWidget {
  final EzCP config;

  /// How long is the countdown
  final Duration duration;

  /// Defaults to a [SnackBar] appropriate value
  final double? radius;

  /// Defaults to [EzCP.secondaryFill]
  final EzSwitchColor? fill;

  /// An animated circle/pie countdown timer
  /// Default [radius] is for use in a [SnackBar]
  const EzCountdownTimer(this.config, {super.key, required this.duration, this.radius, this.fill});

  @override
  State<EzCountdownTimer> createState() => _EzCountdownTimerState();
}

class _EzCountdownTimerState extends State<EzCountdownTimer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.radius ?? widget.config.iconSize + widget.config.padding;

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => CustomPaint(
        size: Size(size, size),
        painter: EzCountdownPainter(
          _animation.value,
          widget.fill ?? widget.config.secondaryFill,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class EzCountdownPainter extends CustomPainter {
  final double progress;
  final EzSwitchColor fill;

  EzCountdownPainter(this.progress, this.fill);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    final Paint foregroundPaint = Paint()..style = PaintingStyle.fill;

    if (fill.gradient != null) {
      foregroundPaint.shader = fill.gradient!.createShader(rect);
    } else {
      foregroundPaint.color = fill.color!;
    }

    canvas.drawArc(
      rect,
      -pi / 2,
      2 * -pi * progress,
      true,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(EzCountdownPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.fill != fill;
}
