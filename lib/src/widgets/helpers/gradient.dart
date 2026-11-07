/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

// Border(s) //

class EzGradientOutlinedBorder extends OutlinedBorder {
  final EzCP config;
  final OutlinedBorder shape;
  final Gradient gradient;

  /// Paints [shape]'s outline with a [gradient] instead of a solid [BorderSide]
  const EzGradientOutlinedBorder(
    this.config, {
    required this.shape,
    required this.gradient,
  }) : super(side: BorderSide.none);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(config.borderWidth);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => shape.getOuterPath(
        rect,
        textDirection: textDirection,
      );

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => shape.getOuterPath(
        rect.deflate(config.borderWidth),
        textDirection: textDirection,
      );

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (config.borderWidth <= 0) return;

    canvas.drawPath(
      shape.getOuterPath(rect.deflate(config.borderWidth / 2), textDirection: textDirection),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = config.borderWidth
        ..shader = gradient.createShader(rect, textDirection: textDirection),
    );
  }

  @override
  OutlinedBorder copyWith({BorderSide? side}) => this;

  @override
  ShapeBorder scale(double t) => EzGradientOutlinedBorder(
        config,
        shape: shape.scale(t) as OutlinedBorder,
        gradient: gradient.scale(t),
      );

  @override
  bool operator ==(Object other) =>
      other is EzGradientOutlinedBorder && other.shape == shape && other.gradient == gradient;

  @override
  int get hashCode => Object.hash(
        shape,
        gradient,
        config.borderWidth,
      );
}

class EzGradientBoxBorder extends BoxBorder {
  final EzCP config;
  final Gradient gradient;

  const EzGradientBoxBorder(
    this.config, {
    required this.gradient,
  });

  @override
  BorderSide get top => EzGradientBorderSide(
        width: config.borderWidth,
        gradient: gradient,
      );

  @override
  BorderSide get bottom => EzGradientBorderSide(
        width: config.borderWidth,
        gradient: gradient,
      );

  @override
  bool get isUniform => true;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(config.borderWidth);

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    final double width = config.borderWidth;
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
  ShapeBorder scale(double t) => EzGradientBoxBorder(config, gradient: gradient.scale(t));

  @override
  bool operator ==(Object other) => other is EzGradientBoxBorder && other.gradient == gradient;

  @override
  int get hashCode => Object.hash(gradient, config.borderWidth);
}

class EzGradientBorderSide extends BorderSide {
  final Gradient gradient;

  EzGradientBorderSide({
    required super.width,
    required this.gradient,
  }) : super(
          color: gradient.colors.first,
          style: (width <= 0) ? BorderStyle.none : BorderStyle.solid,
        );

  /// Stroke [Paint] with [gradient] mapped onto [rect]
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

// Widget(s) //

class EzAvatar extends StatelessWidget {
  final EzSwitchColor fill;
  final ImageProvider? backgroundImage;
  final ImageErrorListener? onBackgroundImageError;
  final Color? foregroundColor;
  final ImageProvider? foregroundImage;
  final ImageErrorListener? onForegroundImageError;
  final double? radius;
  final double? minRadius;
  final double? maxRadius;
  final Widget? child;

  /// [CircleAvatar] wrapper that supports [EzSwitchColor]
  const EzAvatar({
    super.key,
    required this.fill,
    this.backgroundImage,
    this.onBackgroundImageError,
    this.foregroundColor,
    this.foregroundImage,
    this.onForegroundImageError,
    this.radius,
    this.minRadius,
    this.maxRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final CircleAvatar avatar = CircleAvatar(
      backgroundColor: fill.color ?? Colors.transparent,
      backgroundImage: backgroundImage,
      onBackgroundImageError: onBackgroundImageError,
      foregroundColor: foregroundColor,
      foregroundImage: foregroundImage,
      onForegroundImageError: onForegroundImageError,
      radius: radius,
      minRadius: minRadius,
      maxRadius: maxRadius,
      child: child,
    );

    return (fill.gradient == null)
        ? avatar
        : DecoratedBox(
            decoration: BoxDecoration(gradient: fill.gradient, shape: BoxShape.circle),
            child: avatar,
          );
  }
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
