/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

class EzRichText extends StatelessWidget {
  final EzCP config;
  final List<InlineSpan> children;

  /// Whether a default [EzTextBackground] should be included
  final bool textBackground;

  final TextStyle? style;
  final TextAlign textAlign;
  final BorderRadiusGeometry? borderRadius;
  final EzSwitchColor? baseFill;
  final EzSwitchColor? replaceFill;

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
    this.baseFill,
    this.replaceFill,
  });

  String _semanticsLabel() {
    final StringBuffer label = StringBuffer();

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
        TextSpan(children: children),
        style: style,
        textAlign: textAlign,
        softWrap: true,
        overflow: TextOverflow.clip,
        textScaler: TextScaler.noScaling,
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
                baseFill: baseFill,
                replaceFill: replaceFill,
              )
            : _text(),
      );
}
