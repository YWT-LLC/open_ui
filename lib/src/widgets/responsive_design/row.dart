/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzRow extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [Row.mainAxisAlignment] passthrough
  final MainAxisAlignment mainAxisAlignment;

  /// [Row.mainAxisSize] passthrough
  final MainAxisSize mainAxisSize;

  /// [Row.crossAxisAlignment] passthrough
  final CrossAxisAlignment crossAxisAlignment;

  /// Whether this should respond to [isLeftyKey]'s status
  /// If true, [children] will be reversed
  final bool reverseHands;

  /// [Row.children] passthrough
  final List<Widget> children;

  /// [Row] wrapper that optionally reverses [children] based on [isLeftyKey]'s status
  const EzRow(
    this.config, {
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.reverseHands = true,
    required this.children,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: mainAxisAlignment,
    mainAxisSize: mainAxisSize,
    crossAxisAlignment: crossAxisAlignment,
    children: (reverseHands && config.isLefty == true) ? children.reversed.toList() : children,
  );
}
