/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzRichText extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [Text.rich] passthrough
  final List<InlineSpan> children;

  /// Whether a default [EzTextBackground] should be included
  final bool textBackground;

  /// [Text.rich] passthrough
  final TextStyle? style;

  /// [Text.rich] passthrough
  final TextAlign textAlign;

  /// Optional [EzTextBackground.borderRadius] passthrough
  final BorderRadiusGeometry? borderRadius;

  /// Optional [EzTextBackground.baseColor] passthrough
  final Color? baseColor;

  /// Optional [EzTextBackground.backgroundColor] passthrough
  final Color? backgroundColor;

  /// [Text.rich] wrapper with custom [Semantics] behavior
  /// Recommended to pair with [EzPlainText] and [EzInlineLink] rather than [TextSpan]s
  const EzRichText(
    this.config, {
    required this.children,
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
    this.textBackground = true,
    this.borderRadius,
    this.baseColor,
    this.backgroundColor,
  });

  String _semanticsLabel() {
    final StringBuffer label = StringBuffer('');

    for (final InlineSpan child in children) {
      switch (child.runtimeType) {
        case const (TextSpan):
          final TextSpan ogSpan = child as TextSpan;
          label.write(ogSpan.semanticsLabel ?? ogSpan.text!);
          break;
        case const (EzPlainText):
          final EzPlainText plainSpan = child as EzPlainText;
          label.write(plainSpan.semanticsLabel ?? plainSpan.text!);
          break;
        case const (EzInlineLink):
          final EzInlineLink linkSpan = child as EzInlineLink;
          label.write(linkSpan.richLabel ?? linkSpan.text);
          break;
        default:
          break;
      }
    }

    return label.toString();
  }

  Text _text() => Text.rich(
        TextSpan(children: children, semanticsLabel: null),
        style: style,
        textAlign: textAlign,
        softWrap: true,
        overflow: TextOverflow.clip,
        textScaler: TextScaler.noScaling,
        semanticsLabel: null,
        textWidthBasis: TextWidthBasis.parent,
      );

  @override
  Widget build(BuildContext context) => Semantics(
        label: _semanticsLabel(),
        container: true,
        explicitChildNodes: true,
        child: textBackground
            ? EzTextBackground(
                config,
                text: _text(),
                borderRadius: borderRadius,
                baseColor: baseColor,
                backgroundColor: backgroundColor,
              )
            : _text(),
      );
}
