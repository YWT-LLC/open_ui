/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzCheckbox extends StatelessWidget {
  final EzCP config;

  /// Defaults to [EdgeInsets.all] with [EzCP.marginVal] when [ezIconRatio] > 1.1
  final EdgeInsetsGeometry? padding;

  final bool? value;

  final ValueChanged<bool?>? onChanged;

  /// Defaults to [ezIconRatio]
  final double _scale;

  final bool isError;

  final String? semanticLabel;

  /// [Checkbox] with custom styling and scaling
  EzCheckbox(
    this.config, {
    super.key,
    this.padding,
    this.value,
    this.onChanged,
    this.isError = false,
    this.semanticLabel,
  }) : _scale = ezIconRatio(config);

  @override
  Widget build(BuildContext context) => Padding(
        padding: _scale > 1.1 ? padding ?? EdgeInsets.all(config.marginVal) : EdgeInsets.zero,
        child: Transform.scale(
          scale: max(1.0, _scale),
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            isError: isError,
            semanticLabel: semanticLabel,
          ),
        ),
      );
}

class EzCheckboxPair extends StatelessWidget {
  final EzCP config;

  final bool reverseHands;

  final MainAxisSize mainAxisSize;

  final MainAxisAlignment mainAxisAlignment;

  final CrossAxisAlignment crossAxisAlignment;

  final String text;

  final TextStyle? style;

  final TextAlign? textAlign;

  final String? semanticsLabel;

  final Color? baseColor;

  final Color? backgroundColor;

  /// Defaults to [EdgeInsets.all] with [EzCP.marginVal] when scale > 1.1
  final EdgeInsetsGeometry? padding;

  final bool? value;

  final ValueChanged<bool?>? onChanged;

  final String? semanticLabel;

  const EzCheckboxPair(
    this.config, {
    super.key,
    // EzRow
    this.reverseHands = true,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,

    // EzText
    required this.text,
    this.style,
    this.textAlign,
    this.semanticsLabel,
    this.baseColor,
    this.backgroundColor,

    // EzCheckbox
    this.padding,
    this.value,
    this.onChanged,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) => EzRow(
        config,
        reverseHands: reverseHands,
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          Flexible(
            child: EzText(
              config,
              text: text,
              style: style,
              textAlign: textAlign,
              semanticsLabel: semanticsLabel,
              baseColor: baseColor,
              backgroundColor: backgroundColor,
            ),
          ),
          EzCheckbox(
            config,
            padding: padding,
            value: value,
            onChanged: onChanged,
            semanticLabel: semanticLabel,
          ),
        ],
      );
}
