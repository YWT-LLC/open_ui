/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

class EzIcon extends StatelessWidget {
  final EzCP config;
  final IconData? icon;
  final double? size;

  /// Defaults to [EzCP.primaryFill]
  final EzSwitchColor? fill;

  final double? iconFill;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final List<Shadow>? shadows;
  final String? semanticLabel;
  final TextDirection? textDirection;
  final bool? applyTextScaling;
  final BlendMode? blendMode;

  /// [Icon] wrapper that responds to [EzCP.iconSize] and supports [Gradient]s
  const EzIcon(
    this.config,
    this.icon, {
    super.key,
    this.size,
    this.fill,
    this.iconFill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.shadows,
    this.semanticLabel,
    this.textDirection,
    this.applyTextScaling,
    this.blendMode,
  });

  @override
  Widget build(BuildContext context) {
    final Icon toReturn = Icon(
      icon,
      size: size ?? config.iconSize,
      fill: iconFill,
      weight: weight,
      grade: grade,
      opticalSize: opticalSize,
      color: fill?.color,
      shadows: shadows,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
      applyTextScaling: applyTextScaling,
      blendMode: blendMode,
    );
    final Gradient? gradient = (fill ?? config.primaryFill).gradient;

    return (gradient == null)
        ? toReturn
        : ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => gradient.createShader(bounds),
            child: toReturn,
          );
  }
}

class EzIconTouch extends StatelessWidget {
  final EzCP config;
  final IconData icon;
  final double? iconSize;
  final EzSwitchColor? iconFill;
  final EzSwitchColor? backgroundFill;
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
    this.iconFill,
    this.backgroundFill,
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
              decoration: config.boxDecoration(
                fill: backgroundFill ?? config.surfaceFill,
                shape: BoxShape.circle,
              ),
              child: EzIcon(config, icon, fill: iconFill),
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
              decoration: config.boxDecoration(
                fill: backgroundFill ?? config.surfaceFill,
                shape: BoxShape.circle,
              ),
              child: EzIcon(config, icon, fill: config.outlineFiller),
            ),
          ),
        );
}

class EzIconButton extends StatelessWidget {
  final EzCP config;
  final Widget icon;
  final double? iconSize;

  /// Optional override, defaults to [EzCP.surfaceFill]
  final EzSwitchColor? backgroundFill;

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String tooltip;

  /// Uses disabled styling and sets [onPressed] and [onLongPress] to [doNothing] when false
  final bool enabled;

  /// Switches to disabled styling when true
  /// [onPressed] is unchanged
  final bool fauxDisabled;

  /// Clobbers [enabled], [fauxDisabled], and [backgroundFill] style changes (style only)
  final ButtonStyle? style;

  /// [IconButton] wrapper with custom styling and [Gradient] support
  const EzIconButton(
    this.config, {
    super.key,
    required this.icon,
    this.iconSize,
    this.backgroundFill,
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
                    backgroundColor: config.surfaceFill.color,
                    foregroundColor: config.outline,
                    side: config.borderSide(config.outlineVariantFill),
                    overlayColor: config.outline,
                    shadowColor: Colors.transparent,
                    iconSize: iconSize ?? config.iconSize,
                  ).copyWith(
                    backgroundBuilder: config.buttonLayer(backgroundFill ?? config.surfaceFill),
                  )
                : IconButton.styleFrom(
                    backgroundColor: config.surfaceFill.color,
                    foregroundColor: config.onSurface,
                    iconSize: iconSize ?? config.iconSize,
                  ).copyWith(
                    backgroundBuilder: config.buttonLayer(backgroundFill ?? config.surfaceFill),
                  )),
        icon: icon,
        iconSize: iconSize ?? config.iconSize,
      );
}
