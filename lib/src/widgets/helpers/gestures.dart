/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzSwipeDetector extends GestureDetector {
  final void Function() rtl;
  final void Function() ltr;

  /// [GestureDetector] wrapper specifically for [onHorizontalDragEnd] for swiping [rtl] and [ltr]
  EzSwipeDetector({
    super.key,
    required this.rtl,
    required this.ltr,
    required super.child,
  }) : super(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity == null) return;
            if (details.primaryVelocity! < -ezSwipeV) rtl.call();
            if (details.primaryVelocity! > ezSwipeV) ltr.call();
          },
        );
}

class EzOpaqueGD extends GestureDetector {
  final bool absorb;
  final Widget kid;

  /// Simple [GestureDetector] whose [kid] is wrapped in an [AbsorbPointer] that listens to [absorb]
  EzOpaqueGD({
    super.key,
    super.onTap,
    super.onDoubleTap,
    super.onLongPress,
    super.behavior = HitTestBehavior.translucent,
    this.absorb = true,
    required this.kid,
  }) : super(
          child: AbsorbPointer(absorbing: absorb, child: kid),
        );
}
