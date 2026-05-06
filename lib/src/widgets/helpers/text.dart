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

  /// Defaults to [EzInsets.wrap] with [EzConfig.marginVal]
  final EdgeInsets? padding;

  /// Defaults to [ezRoundEdge]
  /// moot if [buttonShape] is true
  final BorderRadiusGeometry? borderRadius;

  /// Match the current [EzConfig.buttonShape]
  /// Takes priority over [borderRadius]
  final bool buttonShape;

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
    this.borderRadius,
    this.buttonShape = false,
    this.baseColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: padding ?? EzInsets.wrap(EzConfig.marginVal),
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
                borderRadius: borderRadius ?? ezRoundEdge,
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

  /// [Text.strutStyle] passthrough
  final StrutStyle? strutStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// [Text.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [EzTextBackground.padding] passthrough
  final EdgeInsets? padding;

  /// [EzTextBackground.borderRadius] passthrough
  /// moot if [buttonShape] is true
  final BorderRadiusGeometry? borderRadius;

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
    this.strutStyle,
    this.textAlign,
    this.semanticsLabel,
    this.padding,
    this.borderRadius,
    this.buttonShape = false,
    this.baseColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => EzTextBackground(
        Text(
          data,
          style: style ?? EzConfig.styles.bodyLarge,
          strutStyle: strutStyle,
          textAlign: textAlign,
          semanticsLabel: semanticsLabel,
        ),
        padding: padding,
        borderRadius: borderRadius,
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
