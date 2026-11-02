/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

class _RipplePainter extends CustomPainter {
  final double radius;
  final EzSwitchColor fill;
  final double opacity;

  const _RipplePainter({
    required this.radius,
    required this.fill,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (radius <= 0) return;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = ywt.strokeWidth
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    if (fill.color == null) {
      paint
        ..shader = fill.gradient!.createShader(Rect.fromCircle(center: center, radius: radius))
        ..color = Color.fromRGBO(0, 0, 0, opacity);
    } else {
      paint.color = fill.color!.withValues(alpha: opacity);
    }

    canvas.drawCircle(center, radius - ywt.strokeWidth / 2, paint);
  }

  @override
  bool shouldRepaint(covariant _RipplePainter oldDelegate) =>
      oldDelegate.radius != radius ||
      oldDelegate.opacity != opacity ||
      oldDelegate.fill.color != fill.color ||
      oldDelegate.fill.gradient != fill.gradient;
}

OverlayEntry ezRipple({
  required AnimationController controller,
  required double width,
  required double height,
  required Offset position,
  required EzSwitchColor fill,
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
                fill: fill,
                radius: radius,
                opacity: ((1.0 + oMin) - controller.value).clamp(0.0, 1.0),
              ),
            ),
          );
        },
      ),
    );
