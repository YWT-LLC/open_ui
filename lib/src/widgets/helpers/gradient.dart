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

OutlinedBorder ezGradientButtonShape(EzCP config, Gradient gradient) => EzGradientOutlinedBorder(
      config,
      shape: config.buttonShape.shape,
      gradient: gradient,
    );

// Icons //

Widget ezGradientIcon(Widget icon, Gradient gradient) => ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => gradient.createShader(bounds),
      child: icon,
    );

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
LinearGradient ezGradientFromString(String value) {
  final List<String> parts = value.split(colorSplit);

  return LinearGradient(
    begin: alignLibrary[parts[0]] ?? Alignment.centerLeft,
    end: alignLibrary[parts[1]] ?? Alignment.centerRight,
    colors: parts.sublist(2).map((String color) => Color(int.parse(color))).toList(),
  );
}
