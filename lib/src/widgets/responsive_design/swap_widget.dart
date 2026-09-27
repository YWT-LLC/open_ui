/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzSwapWidget extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Which [ScreenSize] the Widget should respond to
  final ScreenSize breakpoint;

  /// Displayed when the context's [ScreenSize] > [breakpoint]
  final Widget expanded;

  /// Displayed when the context's [ScreenSize] <= [breakpoint]
  final Widget restricted;

  /// Whether the [Widget] should be animated via [EzAnimSwitch]
  final bool animate;

  /// [EzAnimSwitch.mod] passthrough
  final double mod;

  /// [ScreenSize] > [breakpoint] => [expanded]
  /// [ScreenSize] <= [breakpoint] => [restricted]
  /// [ScreenSize] is not in the Widget tree => [restricted]
  const EzSwapWidget(
    this.config, {
    super.key,
    this.animate = false,
    this.mod = 1.0,
    this.breakpoint = ScreenSize.small,
    required this.restricted,
    required this.expanded,
  });

  Widget _core(ScreenSize? size) =>
      (size == null || size.order <= breakpoint.order) ? restricted : expanded;

  @override
  Widget build(BuildContext context) => animate
      ? EzAnimSwitch(config, mod: mod, child: _core(EzScreenSize.of(context)?.screenSize))
      : _core(EzScreenSize.of(context)?.screenSize);
}
