/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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

BoxBorder ezGradientBorder(EzCP config, Gradient gradient) => GradientBoxBorder(
      gradient: gradient,
      width: config.borderWidth,
    );

InputBorder ezGradientInputBorder(EzCP config, Gradient gradient) => GradientOutlineInputBorder(
      gradient: gradient,
      width: config.borderWidth,
      borderRadius: config.textFieldRadius,
    );
