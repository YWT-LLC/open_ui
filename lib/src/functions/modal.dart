/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';

import 'package:flutter/material.dart';

/// [showModalBottomSheet] wrapper with custom defaults and uses [EzCP] based animations
Future<T?> ezModal<T>(
  EzCP config, {
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  BoxConstraints constraints = const BoxConstraints(minWidth: double.infinity),
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool enableDrag = true,
  bool? showDragHandle,
  bool useSafeArea = true,
  double animMod = 0.75,
  Offset? anchorPoint,
}) => showModalBottomSheet(
  context: context,
  builder: builder,
  backgroundColor: backgroundColor,
  constraints: constraints,
  isScrollControlled: isScrollControlled,
  isDismissible: isDismissible,
  enableDrag: enableDrag,
  showDragHandle: showDragHandle,
  useSafeArea: useSafeArea,
  anchorPoint: anchorPoint,
  sheetAnimationStyle: AnimationStyle(
    curve: config.animCurve,
    reverseCurve: config.animCurve,
    duration: ezDuration(config.animDur, mod: animMod),
    reverseDuration: ezDuration(config.animDur, mod: animMod),
  ),
);

Widget ezModalScroll(
  EzCP config, {
  ScrollController? controller,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  ScrollPhysics? physics,
  required List<Widget> children,
}) => Padding(
  padding: EdgeInsets.symmetric(horizontal: config.marginVal),
  child: EzScrollView(
    config,
    controller: controller,
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: crossAxisAlignment,
    physics: physics,
    children: children,
  ),
);
