/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextBackground extends StatelessWidget {
  /// The [Widget] that needs a background
  /// Doesn't have to be [Text]
  final Widget text;

  /// Optional override
  /// Defaults to [EdgeInsets.all] w/ [EzConfig.marginVal]
  final EdgeInsets? padding;

  /// Match the current [EzConfig.buttonShape]
  final bool buttonShape;

  /// Optionally override [BoxDecoration.borderRadius]
  final BorderRadiusGeometry? borderRadius;

  /// Uses [EzConfig.textBackgroundOpacity]
  /// Defaults to [ColorScheme.surfaceContainer]
  final Color? baseColor;

  /// Full override
  final Color? backgroundColor;

  /// Create a [Container] for your [text] with a background color that automatically responds to [lightTextBackgroundOpacityKey]/[darkTextBackgroundOpacityKey]
  const EzTextBackground(
    this.text, {
    super.key,
    this.padding,
    this.buttonShape = false,
    this.borderRadius,
    this.baseColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: (backgroundColor == null && EzConfig.textBackgroundOpacity < 0.01)
            ? EdgeInsets.zero
            : padding ?? EdgeInsets.all(EzConfig.marginVal),
        decoration: buttonShape
            ? ShapeDecoration(
                color: backgroundColor ??
                    (baseColor ?? EzConfig.colors.surfaceContainer)
                        .withValues(alpha: EzConfig.textBackgroundOpacity),
                shape: EzConfig.buttonShape.shape,
              )
            : BoxDecoration(
                color: backgroundColor ??
                    (baseColor ?? EzConfig.colors.surfaceContainer)
                        .withValues(alpha: EzConfig.textBackgroundOpacity),
                borderRadius: borderRadius ?? EzConfig.textRadius,
              ),
        child: text,
      );
}

class EzText extends StatelessWidget {
  /// [Text.data] passthrough
  final String data;

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
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.semanticsLabel,
    this.buttonShape = false,
    this.baseColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => EzTextBackground(
        Text(
          data,
          style: style ?? EzConfig.styles.bodyLarge,
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
  const EzNewLine({super.key, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: Text(
          '',
          style: style ?? EzConfig.styles.bodyLarge,
          textAlign: textAlign ?? TextAlign.start,
        ),
      );
}
