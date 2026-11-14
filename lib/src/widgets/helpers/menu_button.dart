/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

class EzMenuButton extends StatelessWidget {
  final EzCP config;

  /// When false, disables [onPressed] and switches the color theme
  final bool enabled;

  /// iconAlignment: [EzCM.get] -> [isLeftyKey] ? [IconAlignment.start] : [IconAlignment.end]
  final Widget? icon;

  /// [MenuItemButton.child] will be a [Text] Widget with [label]
  final String? label;

  final void Function()? onPressed;
  final String? semanticsLabel;
  final TextAlign? textAlign;

  /// Defaults to [EzCP.bodyStyle]
  final TextStyle? textStyle;

  const EzMenuButton(
    this.config, {
    super.key,
    this.enabled = true,
    this.icon,
    this.label,
    this.onPressed,
    this.semanticsLabel,
    this.textAlign,
    this.textStyle,
  }) : assert(!((icon == null) && (label == null)), 'Icon or label (or both) must be provided');

  @override
  Widget build(BuildContext context) => MenuItemButton(
        style: enabled
            ? MenuItemButton.styleFrom(
                backgroundColor: config.surfaceFill.color,
              ).copyWith(
                backgroundBuilder: config.smartLayer(
                  borderRadius: config.buttonShape.textRadius,
                ),
              )
            : MenuItemButton.styleFrom(
                backgroundColor: config.surfaceFill.color,
                foregroundColor: config.outline,
              ).copyWith(
                backgroundBuilder: config.smartLayer(
                  borderRadius: config.buttonShape.textRadius,
                ),
              ),
        onPressed: enabled ? onPressed : doNothing,
        leadingIcon: label == null ? null : (config.isLefty ? icon : null),
        trailingIcon: label == null ? null : (config.isLefty ? null : icon),
        semanticsLabel: semanticsLabel,
        child: (label == null)
            ? icon
            : Text(
                label!,
                style: textStyle ?? config.bodyStyle,
                textAlign: textAlign ?? (config.isLefty ? TextAlign.start : TextAlign.end),
              ),
      );
}
