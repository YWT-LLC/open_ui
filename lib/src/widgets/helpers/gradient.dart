/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

// Text //

class EzFabText extends GradientText {
  const EzFabText(
    super.text, {
    super.key,
    required super.colors,
    super.gradientDirection = GradientDirection.ltr,
    super.textAlign,
    super.style,
  }) : super();
} // TODO: from key

EzFabText ezRainbowText(
  String text, {
  TextStyle? style,
  TextAlign textAlign = TextAlign.start,
}) =>
    EzFabText(
      text,
      style: style,
      textAlign: textAlign,
      colors: <Color>[
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.indigo,
        Colors.purple,
      ],
    );

// Icons //

Widget ezGradientIcon(Widget icon, Gradient gradient) => ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => gradient.createShader(bounds),
      child: icon,
    );

// Borders //

BoxBorder ezGradientBorder(EzCP config, Gradient gradient) => GradientBoxBorder(
      gradient: gradient,
      width: config.borderWidth,
    );

InputBorder ezGradientInputBorder(EzCP config, Gradient gradient) => GradientOutlineInputBorder(
      gradient: gradient,
      width: config.borderWidth,
      borderRadius: config.textFieldRadius,
    );

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
