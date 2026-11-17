/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:material_ui/material_ui.dart';

class EzOverlayEntry extends OverlayEntry {
  final double? bottom;
  final double? top;
  final double? left;
  final double? right;

  /// Optionally wrap [child] in an [IgnorePointer]
  final bool ignore;

  final Widget child;

  EzOverlayEntry({
    this.bottom,
    this.top,
    this.left,
    this.right,
    this.ignore = true,
    required this.child,
  }) : super(
          builder: (_) => Positioned(
            bottom: bottom,
            top: top,
            left: left,
            right: right,
            child: Material(
              type: MaterialType.transparency,
              child: ignore ? IgnorePointer(child: child) : child,
            ),
          ),
        );
}
