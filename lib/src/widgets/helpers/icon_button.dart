/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzIconButton extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [IconButton.icon] passthrough
  final Widget icon;

  /// Optional [IconButton.iconSize] passthrough
  final double? iconSize;

  /// [IconButton.onPressed] passthrough
  final VoidCallback? onPressed;

  /// [IconButton.onLongPress] passthrough
  final VoidCallback? onLongPress;

  /// [IconButton.tooltip] passthrough
  final String tooltip;

  /// Uses disabled styling and sets [onPressed] and [onLongPress] to [doNothing] when false
  final bool enabled;

  /// Switches to disabled styling when true
  /// [onPressed] is unchanged
  final bool fauxDisabled;

  /// Optional [IconButton.style] passthrough
  /// Clobbers [enabled] and [fauxDisabled] style changes (style only)
  final ButtonStyle? style;

  /// [IconButton] wrapper with custom styling
  const EzIconButton(
    this.config, {
    super.key,
    required this.icon,
    this.iconSize,
    this.onPressed,
    this.onLongPress,
    required this.tooltip,
    this.enabled = true,
    this.fauxDisabled = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: enabled ? onPressed : doNothing,
        onLongPress: enabled ? onLongPress : doNothing,
        tooltip: tooltip,
        style: style ??
            ((!enabled || fauxDisabled)
                ? IconButton.styleFrom(
                    foregroundColor: config.colors.outline,
                    side: config.borderSide(color: config.colors.outlineVariant),
                    overlayColor: config.colors.outline,
                    shadowColor: Colors.transparent,
                    iconSize: iconSize ?? config.iconSize,
                  )
                : null),
        icon: icon,
        iconSize: iconSize ?? config.iconSize,
      );
}

class EzIcon extends Icon {
  /// EzConfig Provider
  final EzCP config;

  /// [Icon] wrapper that responds to [EzCP.iconSize]
  /// [ThemeData.iconTheme] does not seem to be consumed properly
  EzIcon(
    this.config,
    super.icon, {
    super.key,
    super.fill,
    super.weight,
    super.grade,
    super.opticalSize,
    super.color,
    super.shadows,
    super.semanticLabel,
    super.textDirection,
    super.applyTextScaling,
    super.blendMode,
  }) : super(size: config.iconSize);
}
