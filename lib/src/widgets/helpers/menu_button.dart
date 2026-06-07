/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzMenuButton extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [MenuItemButton.onPressed] passthrough
  final void Function()? onPressed;

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

  /// [ElevatedButton.icon] wrapper that responds to [isLeftyKey]
  const EzMenuButton(
    this.config, {
    super.key,
    this.onPressed,
    this.semanticsLabel,
    this.icon,
    required this.label,
    this.textStyle,
    this.textAlign,
  });

  @override
  State<EzMenuButton> createState() => _EzMenuButtonState();
}

class _EzMenuButtonState extends State<EzMenuButton> {
  @override
  Widget build(BuildContext context) => MenuItemButton(
        onPressed: widget.onPressed,
        semanticsLabel: widget.semanticsLabel,
        leadingIcon: EzCM.isLefty ? widget.icon : null,
        trailingIcon: EzCM.isLefty ? null : widget.icon,
        child: Text(
          widget.label,
          style: (widget.textStyle ?? widget.config.bodyStyle)?.copyWith(
            decorationColor: widget.config.colors.primary,
          ),
          textAlign: widget.textAlign ?? (EzCM.isLefty ? TextAlign.start : TextAlign.end),
        ),
      );
}
