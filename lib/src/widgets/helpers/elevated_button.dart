/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzElevatedButton extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Easily disable the button
  /// Useful if the functionality is async
  final bool enabled;

  /// [ElevatedButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [ElevatedButton.onLongPress] passthrough
  final void Function()? onLongPress;

  /// [ElevatedButton.style] passthrough
  final ButtonStyle? style;

  /// [ElevatedButton.child] will be [Text] with [text], [textStyle], and [textAlign]
  final String text;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// [ElevatedButton] with custom styling and an off switch
  const EzElevatedButton(
    this.config, {
    super.key,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.style,
    required this.text,
    this.textStyle,
    this.textAlign,
  });

  @override
  State<EzElevatedButton> createState() => _EzElevatedButtonState();
}

class _EzElevatedButtonState extends State<EzElevatedButton> {
  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: widget.enabled ? widget.onPressed : doNothing,
    onLongPress: widget.enabled ? widget.onLongPress : doNothing,
    style: widget.enabled
        ? widget.style
        : (widget.style ?? widget.config.theme.elevatedButtonTheme.style)?.copyWith(
            overlayColor: WidgetStateProperty.all(widget.config.colors.outline),
            shadowColor: WidgetStateProperty.all(Colors.transparent),
          ),
    child: Text(
      widget.text,
      style: (widget.textStyle ?? widget.config.bodyStyle)?.copyWith(
        decorationColor: widget.enabled
            ? widget.config.colors.primary
            : widget.config.colors.outline,
      ),
      textAlign: widget.textAlign,
    ),
  );
}

class EzElevatedIconButton extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Easily disable the button
  /// Useful if the functionality is async
  final bool enabled;

  /// [ElevatedButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [ElevatedButton.onLongPress] passthrough
  final void Function()? onLongPress;

  /// [ElevatedButton.style] passthrough
  final ButtonStyle? style;

  /// [ElevatedButton.icon] passthrough
  final Widget icon;

  /// [ElevatedButton.icon]'s label will be [Text] with [label], [textStyle], and [textAlign]
  final String label;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// [ElevatedButton.icon] wrapper that responds to [isLeftyKey]
  const EzElevatedIconButton(
    this.config, {
    super.key,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.style,
    required this.icon,
    required this.label,
    this.textStyle,
    this.textAlign,
  });

  @override
  State<EzElevatedIconButton> createState() => _EzElevatedIconButtonState();
}

class _EzElevatedIconButtonState extends State<EzElevatedIconButton> {
  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
    onPressed: widget.enabled ? widget.onPressed : doNothing,
    onLongPress: widget.enabled ? widget.onLongPress : doNothing,
    style: widget.enabled
        ? widget.style
        : (widget.style ?? widget.config.theme.elevatedButtonTheme.style)?.copyWith(
            overlayColor: WidgetStateProperty.all(widget.config.colors.outline),
            shadowColor: WidgetStateProperty.all(Colors.transparent),
          ),
    icon: widget.icon,
    iconAlignment: widget.config.isLefty ? IconAlignment.start : IconAlignment.end,
    label: Text(
      widget.label,
      style: (widget.textStyle ?? widget.config.bodyStyle)?.copyWith(
        decorationColor: widget.enabled
            ? widget.config.colors.primary
            : widget.config.colors.outline,
      ),
      textAlign: widget.textAlign,
    ),
  );
}
