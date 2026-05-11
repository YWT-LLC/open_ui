/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzIcon extends Icon {
  /// [Icon] wrapper that responds to [EzConfig.iconSize]
  /// [ThemeData.iconTheme] does not seem to be consumed properly at time of writing
  /// Jan 2025
  EzIcon(
    // TODO: test removing this - after finishing smush!!! don't do too much at once <3
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
  }) : super(size: EzConfig.iconSize);
}

class EzIconButton extends StatelessWidget {
  /// [IconButton.icon] passthrough
  final Widget icon;

  /// Optional [IconButton.iconSize] passthrough
  final double? iconSize;

  /// [IconButton.onPressed] passthrough
  final VoidCallback? onPressed;

  /// [IconButton.onLongPress] passthrough
  final VoidCallback? onLongPress;

  /// [IconButton.tooltip] passthrough
  final String? tooltip;

  /// Uses disabled styling and sets [onPressed] and [onLongPress] to [doNothing] when false
  final bool enabled;

  /// Switches to disabled styling when true
  /// [onPressed] is unchanged
  final bool fauxDisabled;

  /// Optional [IconButton.style] passthrough
  /// Clobbers [enabled] and [fauxDisabled] style changes (style only)
  final ButtonStyle? style;

  /// [IconButton] wrapper with custom styling
  const EzIconButton({
    super.key,
    required this.icon,
    this.iconSize,
    this.onPressed,
    this.onLongPress,
    this.tooltip,
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
                    foregroundColor: EzConfig.colors.outline,
                    side: EzConfig.borderSide(color: EzConfig.colors.outlineVariant),
                    overlayColor: EzConfig.colors.outline,
                    shadowColor: Colors.transparent,
                    iconSize: iconSize ?? EzConfig.iconSize)
                : null),
        icon: icon,
        iconSize: iconSize ?? EzConfig.iconSize,
      );
}
