/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzAvatar extends StatelessWidget {
  final EzSwitchColor fill;
  final ImageProvider? backgroundImage;
  final ImageErrorListener? onBackgroundImageError;
  final Color? foregroundColor;
  final ImageProvider? foregroundImage;
  final ImageErrorListener? onForegroundImageError;
  final double? radius;
  final double? minRadius;
  final double? maxRadius;
  final Widget? child;

  /// [CircleAvatar] wrapper that supports [EzSwitchColor]
  const EzAvatar({
    super.key,
    required this.fill,
    this.backgroundImage,
    this.onBackgroundImageError,
    this.foregroundColor,
    this.foregroundImage,
    this.onForegroundImageError,
    this.radius,
    this.minRadius,
    this.maxRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final CircleAvatar avatar = CircleAvatar(
      backgroundColor: fill.color ?? Colors.transparent,
      backgroundImage: backgroundImage,
      onBackgroundImageError: onBackgroundImageError,
      foregroundColor: foregroundColor,
      foregroundImage: foregroundImage,
      onForegroundImageError: onForegroundImageError,
      radius: radius,
      minRadius: minRadius,
      maxRadius: maxRadius,
      child: child,
    );

    return (fill.gradient == null)
        ? avatar
        : DecoratedBox(
            decoration: BoxDecoration(gradient: fill.gradient, shape: BoxShape.circle),
            child: avatar,
          );
  }
}
