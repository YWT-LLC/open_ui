/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzMenuButton extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// When false, disables [onPressed] and switches the color theme
  final bool enabled;

  /// iconAlignment: [EzCM.get] -> [isLeftyKey] ? [IconAlignment.start] : [IconAlignment.end]
  final Widget? icon;

  /// [MenuItemButton.child] will be a [Text] Widget with [label]
  final String? label;

  /// [MenuItemButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [MenuItemButton.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [Text] passthrough
  final TextAlign? textAlign;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [ElevatedButton.icon] wrapper that responds to [isLeftyKey]
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
    style: enabled ? null : MenuItemButton.styleFrom(foregroundColor: config.colors.outline),
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
