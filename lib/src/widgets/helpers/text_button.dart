/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzTextButton extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [TextButton.child] will be [Text] with [text], [textStyle], and [textAlign]
  final String text;

  /// [TextButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [TextButton.onLongPress] passthrough
  final void Function()? onLongPress;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// Optional [Text.semanticsLabel] passthrough
  final String? semantics;

  /// Includes [EdgeInsets.zero] in either [style] or the default [TextButton.styleFrom]
  final bool inline;

  /// [TextButton.style] passthrough
  final ButtonStyle? style;

  /// [TextButton] with custom styling
  const EzTextButton(
    this.config, {
    super.key,
    this.onPressed,
    this.onLongPress,
    required this.text,
    this.semantics,
    this.textStyle,
    this.textAlign,
    this.inline = false,
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
        style: widget.inline
            ? (widget.style == null
                ? TextButton.styleFrom(padding: EdgeInsets.zero)
                : widget.style!
                    .copyWith(padding: const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.zero)))
            : widget.style,
        child: Text(
          widget.text,
          semanticsLabel: widget.semantics,
          style: (widget.textStyle ?? widget.config.bodyStyle)?.copyWith(
            decorationColor: widget.config.colors.primary,
          ),
          textAlign: widget.textAlign,
        ),
      );
}

class EzTextIconButton extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [TextButton.icon] label will be [Text] with [label], [textStyle], and [textAlign]
  final String label;

  /// [TextButton.icon] passthrough
  /// iconAlignment: [EzCM.get] -> [isLeftyKey] ? [IconAlignment.start] : [IconAlignment.end]
  final Widget icon;

  /// [TextButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [TextButton.onLongPress] passthrough
  final void Function()? onLongPress;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// Optional [Text.semanticsLabel] passthrough for [label]
  final String? semantics;

  /// Dictates the padding
  final bool inline;

  /// [TextButton.style] passthrough
  final ButtonStyle? style;

  /// [TextButton.icon] with custom styling
  const EzTextIconButton(
    this.config, {
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.onLongPress,
    this.textStyle,
    this.textAlign,
    this.semantics,
    this.inline = false,
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
        style: widget.inline
            ? (widget.style == null
                ? TextButton.styleFrom(padding: EdgeInsets.zero)
                : widget.style!
                    .copyWith(padding: const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.zero)))
            : widget.style,
        icon: widget.icon,
        iconAlignment: widget.config.isLefty ? IconAlignment.start : IconAlignment.end,
        label: Text(
          widget.label,
          semanticsLabel: widget.semantics,
          style: (widget.textStyle ?? widget.config.bodyStyle)?.copyWith(
            decorationColor: widget.config.colors.primary,
          ),
          textAlign: widget.textAlign,
        ),
      );
}
