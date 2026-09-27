/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

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

class EzIconTouch extends StatelessWidget {
  final EzCP config;
  final IconData icon;
  final double? iconSize;
  final Color? color;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool enabled;
  final String tooltip;

  /// Functionally an icon button, but not an [IconButton]
  const EzIconTouch(
    this.config, {
    super.key,
    required this.icon,
    this.iconSize,
    this.color,
    this.onPressed,
    this.onLongPress,
    this.enabled = true,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) => enabled
      ? Tooltip(
          message: tooltip,
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: onPressed,
            onLongPress: onLongPress,
            child: Container(
              padding: EzInsets.wrap(config.padding),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: EzIcon(config, icon, color: color),
            ),
          ),
        )
      : Tooltip(
          message: tooltip,
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: doNothing,
            onLongPress: doNothing,
            child: Container(
              padding: EzInsets.wrap(config.padding),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: EzIcon(config, icon, color: config.colors.outline),
            ),
          ),
        );
}

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
