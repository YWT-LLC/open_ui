/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextBackground extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// The [Widget] that needs a background
  /// Doesn't have to be [Text]
  final Widget text;

  /// Optional override
  /// Defaults to [EdgeInsets.all] w/ [config.marginVal]
  final EdgeInsets? padding;

  /// Match the current [config.buttonShape]
  final bool buttonShape;

  /// Optionally override [BoxDecoration.borderRadius]
  final BorderRadiusGeometry? borderRadius;

  /// Uses [config.textBackgroundOpacity]
  /// Defaults to [ColorScheme.surfaceContainer]
  final Color? baseColor;

  /// Full override
  final Color? backgroundColor;

  /// Create a [Container] for your [text] with a background color that automatically responds to [lightTextBackgroundOpacityKey]/[darkTextBackgroundOpacityKey]
  const EzTextBackground(
    this.config, {
    super.key,
    required this.text,
    this.padding,
    this.buttonShape = false,
    this.borderRadius,
    this.baseColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: (backgroundColor == null && config.textBackgroundOpacity < oneP)
            ? EdgeInsets.zero
            : padding ?? EdgeInsets.all(config.marginVal),
        decoration: buttonShape
            ? ShapeDecoration(
                color: backgroundColor ??
                    (baseColor ?? config.colors.surfaceContainer)
                        .withValues(alpha: config.textBackgroundOpacity),
                shape: config.buttonShape.shape,
              )
            : BoxDecoration(
                color: backgroundColor ??
                    (baseColor ?? config.colors.surfaceContainer)
                        .withValues(alpha: config.textBackgroundOpacity),
                borderRadius: borderRadius ?? config.textRadius,
              ),
        child: text,
      );
}

class EzText extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [Text.data] passthrough
  final String text;

  /// [Text.style] passthrough
  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// [Text.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [EzTextBackground.buttonShape] passthrough
  final bool buttonShape;

  /// [EzTextBackground.baseColor] passthrough
  final Color? baseColor;

  /// [EzTextBackground.backgroundColor] passthrough
  final Color? backgroundColor;

  /// Quick wrapper for creating [Text] with a default [EzTextBackground]
  /// [style] defaults to [TextTheme.bodyLarge]
  const EzText(
    this.config, {
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.semanticsLabel,
    this.buttonShape = false,
    this.baseColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => EzTextBackground(
        config,
        text: Text(
          text,
          style: style ?? config.bodyStyle,
          textAlign: textAlign,
          semanticsLabel: semanticsLabel,
        ),
        buttonShape: buttonShape,
        baseColor: baseColor,
        backgroundColor: backgroundColor,
      );
}

class EzNewLine extends StatelessWidget {
  /// [Text.style] passthrough
  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [Text.textAlign] passthrough
  /// Defaults to [TextAlign.start]
  final TextAlign? textAlign;

  /// Quick wrapper for creating a [TextStyle]d blank line
  const EzNewLine(this.style, {super.key, this.textAlign});

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: Text(
          '',
          style: style,
          textAlign: textAlign ?? TextAlign.start,
        ),
      );
}
