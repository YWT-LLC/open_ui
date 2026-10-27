/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
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
}

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

// TODO: from key
