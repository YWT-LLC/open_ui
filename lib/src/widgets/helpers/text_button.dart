/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextButton extends StatefulWidget {
  /// [TextButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [TextButton.onLongPress] passthrough
  final void Function()? onLongPress;

  /// [TextButton.child] will be [Text] with [text], [textStyle], and [textAlign]
  final String text;

  /// Optional [Text.semanticsLabel] passthrough
  final String? semantics;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// Enable [EzInsets.wrap] => [EzConfig.marginVal]
  final bool wrapPadding;

  /// [TextButton.style] passthrough
  final ButtonStyle? style;

  /// [TextButton] with custom styling
  /// Crucially: automatically underlines its text [onHover] and [onFocusChange]
  const EzTextButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    required this.text,
    this.semantics,
    this.textStyle,
    this.textAlign,
    this.wrapPadding = false,
    this.style,
  });

  @override
  State<EzTextButton> createState() => _EzTextButtonState();
}

class _EzTextButtonState extends State<EzTextButton> {
  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: widget.onPressed,
        onLongPress: widget.onLongPress,
        style: widget.wrapPadding
            ? (widget.style ?? EzConfig.theme.textButtonTheme.style!).copyWith(
                padding:
                    WidgetStatePropertyAll<EdgeInsetsGeometry>(EzInsets.wrap(EzConfig.marginVal)),
              )
            : widget.style,
        child: Text(
          widget.text,
          semanticsLabel: widget.semantics,
          style: (widget.textStyle ?? EzConfig.styles.bodyLarge)
              ?.copyWith(decorationColor: EzConfig.colors.primary),
          textAlign: widget.textAlign,
        ),
      );
}

class EzTextIconButton extends StatefulWidget {
  /// [TextButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [TextButton.onLongPress] passthrough
  final void Function()? onLongPress;

  /// [TextButton.icon] passthrough
  /// iconAlignment: [EzConfig.get] -> [isLeftyKey] ? [IconAlignment.start] : [IconAlignment.end]
  final Widget icon;

  /// [TextButton.icon] label will be [Text] with [label], [textStyle], and [textAlign]
  final String label;

  /// Optional [Text.semanticsLabel] passthrough for [label]
  final String? semantics;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// Enable [EzInsets.wrap] => [EzConfig.marginVal]
  final bool wrapPadding;

  /// [TextButton.style] passthrough
  final ButtonStyle? style;

  /// [TextButton.icon] with styling like an [EzTextButton] and the [icon] responds to [isLeftyKey]
  const EzTextIconButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    required this.icon,
    required this.label,
    this.semantics,
    this.textStyle,
    this.textAlign,
    this.wrapPadding = false,
    this.style,
  });

  @override
  State<EzTextIconButton> createState() => _EzTextIconButtonState();
}

class _EzTextIconButtonState extends State<EzTextIconButton> {
  @override
  Widget build(BuildContext context) => TextButton.icon(
        onPressed: widget.onPressed,
        onLongPress: widget.onLongPress,
        style: widget.wrapPadding
            ? (widget.style ?? EzConfig.theme.textButtonTheme.style!).copyWith(
                padding:
                    WidgetStatePropertyAll<EdgeInsetsGeometry>(EzInsets.wrap(EzConfig.marginVal)),
              )
            : widget.style,
        icon: widget.icon,
        iconAlignment: EzConfig.isLefty ? IconAlignment.start : IconAlignment.end,
        label: Text(
          widget.label,
          semanticsLabel: widget.semantics,
          style: (widget.textStyle ?? EzConfig.styles.bodyLarge)
              ?.copyWith(decorationColor: EzConfig.colors.primary),
          textAlign: widget.textAlign,
        ),
      );
}
