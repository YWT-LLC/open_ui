/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

// Widget(s) //

class EzGradientBorderSide extends BorderSide {
  final Gradient gradient;

  EzGradientBorderSide({
    required this.gradient,
    required super.width,
  }) : super(
          color: gradient.colors.first,
          style: (width <= 0) ? BorderStyle.none : BorderStyle.solid,
        );

  Paint toGradientPaint(Rect rect, {TextDirection? textDirection}) => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = width
    ..shader = gradient.createShader(rect, textDirection: textDirection);

  @override
  bool operator ==(Object other) =>
      other is EzGradientBorderSide && other.gradient == gradient && other.width == width;

  @override
  int get hashCode => Object.hash(gradient, width, style);
}

/// Paints [fill]'s gradient behind [child] (within [shape]), returns [child] as-is for solid fills
Widget ezGradientBox(
  EzSwitchColor fill, {
  ShapeBorder? shape,
  required Widget child,
}) =>
    (fill.gradient == null)
        ? child
        : DecoratedBox(
            decoration: (shape == null)
                ? BoxDecoration(gradient: fill.gradient)
                : ShapeDecoration(gradient: fill.gradient, shape: shape),
            child: child,
          );

class EzGradientBoxBorder extends BoxBorder {
  final Gradient gradient;
  final double width;

  const EzGradientBoxBorder({
    required this.gradient,
    required this.width,
  });

  @override
  BorderSide get top => EzGradientBorderSide(
        gradient: gradient,
        width: width,
      );

  @override
  BorderSide get bottom => EzGradientBorderSide(
        gradient: gradient,
        width: width,
      );

  @override
  bool get isUniform => true;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    if (width <= 0) return;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..shader = gradient.createShader(rect, textDirection: textDirection);

    final Rect inset = rect.deflate(width / 2);

    switch (shape) {
      case BoxShape.circle:
        canvas.drawCircle(inset.center, inset.shortestSide / 2, paint);
      case BoxShape.rectangle:
        (borderRadius == null || borderRadius == BorderRadius.zero)
            ? canvas.drawRect(inset, paint)
            : canvas.drawRRect(borderRadius.toRRect(rect).deflate(width / 2), paint);
    }
  }

  @override
  ShapeBorder scale(double t) => EzGradientBoxBorder(
        gradient: gradient.scale(t),
        width: width,
      );

  @override
  bool operator ==(Object other) => other is EzGradientBoxBorder && other.gradient == gradient;

  @override
  int get hashCode => Object.hash(gradient, width);
}

class EzGradientOutlinedBorder extends OutlinedBorder {
  final Gradient gradient;
  final double width;
  final OutlinedBorder shape;

  /// Paints [shape]'s outline with a [gradient] instead of a solid [BorderSide]
  const EzGradientOutlinedBorder({
    required this.gradient,
    required this.width,
    required this.shape,
  }) : super(side: BorderSide.none);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => shape.getOuterPath(
        rect,
        textDirection: textDirection,
      );

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => shape.getOuterPath(
        rect.deflate(width),
        textDirection: textDirection,
      );

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (width <= 0) return;

    canvas.drawPath(
      shape.getOuterPath(rect.deflate(width / 2), textDirection: textDirection),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..shader = gradient.createShader(rect, textDirection: textDirection),
    );
  }

  @override
  OutlinedBorder copyWith({BorderSide? side}) => this;

  @override
  ShapeBorder scale(double t) => EzGradientOutlinedBorder(
        gradient: gradient.scale(t),
        width: width,
        shape: shape.scale(t) as OutlinedBorder,
      );

  @override
  bool operator ==(Object other) =>
      other is EzGradientOutlinedBorder &&
      other.gradient == gradient &&
      other.width == width &&
      other.shape == shape;

  @override
  int get hashCode => Object.hash(gradient, width, shape);
}

// Storage //

final Map<String, AlignmentGeometry> alignLibrary = <String, AlignmentGeometry>{
  // Bottom
  Alignment.bottomLeft.toString(): Alignment.bottomLeft,
  Alignment.bottomCenter.toString(): Alignment.bottomCenter,
  Alignment.bottomRight.toString(): Alignment.bottomRight,

  // Center
  Alignment.centerLeft.toString(): Alignment.centerLeft,
  Alignment.center.toString(): Alignment.center,
  Alignment.centerRight.toString(): Alignment.centerRight,

  // Top
  Alignment.topLeft.toString(): Alignment.topLeft,
  Alignment.topCenter.toString(): Alignment.topCenter,
  Alignment.topRight.toString(): Alignment.topRight,
};

/// No checks, assumes a valid gradient entry's value is being sent
LinearGradient ezLGFromString(String value) {
  final List<String> parts = value.split(colorSplit);

  return LinearGradient(
    begin: alignLibrary[parts[0]] ?? Alignment.centerLeft,
    end: alignLibrary[parts[1]] ?? Alignment.centerRight,
    colors: parts.sublist(2).map((String color) => Color(int.parse(color))).toList(),
  );
}
