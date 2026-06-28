/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzMenuButton extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// iconAlignment: [EzCM.get] -> [isLeftyKey] ? [IconAlignment.start] : [IconAlignment.end]
  final Widget? icon;

  /// The text for the user
  final String label;

  /// [MenuItemButton.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text] passthrough
  final TextAlign? textAlign;

  /// [MenuItemButton.onPressed] passthrough
  final void Function()? onPressed;

  /// When false, disables [onPressed] and switches the color theme
  final bool enabled;

  /// [ElevatedButton.icon] wrapper that responds to [isLeftyKey]
  const EzMenuButton(
    this.config, {
    super.key,
    this.semanticsLabel,
    this.icon,
    required this.label,
    this.textStyle,
    this.textAlign,
    this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) => MenuItemButton(
        onPressed: enabled ? onPressed : doNothing,
        semanticsLabel: semanticsLabel,
        style: enabled ? null : MenuItemButton.styleFrom(foregroundColor: config.colors.outline),
        leadingIcon: config.isLefty ? icon : null,
        trailingIcon: config.isLefty ? null : icon,
        child: Text(
          label,
          style: (textStyle ?? config.bodyStyle)?.copyWith(
            decorationColor: config.colors.primary,
          ),
          textAlign: textAlign ?? (config.isLefty ? TextAlign.start : TextAlign.end),
        ),
      );
}
