/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

class EzElevatedButton extends StatelessWidget {
  final EzCP config;

  /// Easily disable the button
  /// Useful if the functionality is async
  final bool enabled;

  /// Switches to disabled styling when true
  /// [onPressed] is unchanged
  final bool fauxDisabled;

  final void Function()? onPressed;
  final void Function()? onLongPress;
  final ButtonStyle? style;

  /// [ElevatedButton.child] will be [Text] with [text], [textStyle], and [textAlign]
  final String text;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  final TextAlign? textAlign;

  /// [ElevatedButton] with custom styling and an off switch
  const EzElevatedButton(
    this.config, {
    super.key,
    this.enabled = true,
    this.fauxDisabled = false,
    this.onPressed,
    this.onLongPress,
    this.style,
    required this.text,
    this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: enabled ? onPressed : doNothing,
        onLongPress: enabled ? onLongPress : doNothing,
        style: (!enabled || fauxDisabled)
            ? (style ?? config.theme.elevatedButtonTheme.style)?.copyWith(
                overlayColor: WidgetStateProperty.all(config.outline),
                shadowColor: WidgetStateProperty.all(Colors.transparent),
              )
            : style,
        child: Text(
          text,
          style: (textStyle ?? config.bodyStyle)?.copyWith(
            decorationColor:
                (!enabled || fauxDisabled) ? config.outline : config.primaryFill.asColor,
          ),
          textAlign: textAlign,
        ),
      );
}

class EzElevatedIconButton extends StatelessWidget {
  final EzCP config;

  /// Easily disable the button
  /// Useful if the functionality is async
  final bool enabled;

  /// Switches to disabled styling when true
  /// [onPressed] is unchanged
  final bool fauxDisabled;

  final void Function()? onPressed;

  final void Function()? onLongPress;

  final ButtonStyle? style;

  final Widget icon;

  /// [ElevatedButton.icon]'s label will be [Text] with [label], [textStyle], and [textAlign]
  final String label;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  final TextAlign? textAlign;

  /// [ElevatedButton.icon] wrapper that responds to [isLeftyKey]
  const EzElevatedIconButton(
    this.config, {
    super.key,
    this.enabled = true,
    this.fauxDisabled = false,
    this.onPressed,
    this.onLongPress,
    this.style,
    required this.icon,
    required this.label,
    this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
        onPressed: enabled ? onPressed : doNothing,
        onLongPress: enabled ? onLongPress : doNothing,
        style: (enabled || fauxDisabled)
            ? style
            : (style ?? config.theme.elevatedButtonTheme.style)?.copyWith(
                overlayColor: WidgetStateProperty.all(config.outline),
                shadowColor: WidgetStateProperty.all(Colors.transparent),
              ),
        icon: icon,
        iconAlignment: config.isLefty ? IconAlignment.start : IconAlignment.end,
        label: Text(
          label,
          style: (textStyle ?? config.bodyStyle)?.copyWith(
            decorationColor:
                (enabled || fauxDisabled) ? config.primaryFill.asColor : config.outline,
          ),
          textAlign: textAlign,
        ),
      );
}
