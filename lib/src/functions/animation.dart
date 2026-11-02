/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:flutter/material.dart';

class _RipplePainter extends CustomPainter {
  final Color color;
  final double radius;

  _RipplePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    if (radius <= 0) return;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius - ywt.strokeWidth / 2,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = ywt.strokeWidth
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0),
    );
  }

  @override
  bool shouldRepaint(covariant _RipplePainter oldDelegate) =>
      oldDelegate.radius != radius || oldDelegate.color != color;
}

OverlayEntry ezRipple({
  required AnimationController controller,
  required double width,
  required double height,
  required Offset position,
  required Color color,
  required double oMin,
}) =>
    OverlayEntry(
      builder: (_) => AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          late final double radius;
          if (width > height) {
            if (position.dx > width / 2) {
              radius = controller.value * position.dx;
            } else {
              radius = controller.value * (width - position.dx);
            }
          } else {
            if (position.dy > height / 2) {
              radius = controller.value * position.dy;
            } else {
              radius = controller.value * (height - position.dy);
            }
          }

          return Positioned(
            left: position.dx - radius,
            top: position.dy - radius,
            width: radius * 2,
            height: radius * 2,
            child: CustomPaint(
              painter: _RipplePainter(
                radius: radius,
                color: color.withValues(alpha: (1.0 + oMin) - controller.value),
              ),
            ),
          );
        },
      ),
    );
