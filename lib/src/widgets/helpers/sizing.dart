/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';
import 'package:flutter/material.dart';

class EzInsets extends EdgeInsets {
  /// [EdgeInsets].symmetric(horizontal: [d2] ? [base] : 0, vertical: [base] / 2)
  const EzInsets.col(double base, {bool d2 = false})
      : super.symmetric(horizontal: d2 ? base : 0, vertical: base / 2);

  /// [EdgeInsets].symmetric(horizontal: [base] / 2, vertical: [d2] ? [base] : 0)
  const EzInsets.row(double base, {bool d2 = false})
      : super.symmetric(horizontal: base / 2, vertical: d2 ? base : 0);

  /// [EdgeInsets].all([base] / 2)
  const EzInsets.wrap(double base) : super.all(base / 2);
}

/// Ezly add (override-able) [EzInsets.wrap] padding to [child]
Widget ezWrap(
  EzCP config, {
  Key? key,
  required Widget child,
  EdgeInsets? padding,
}) =>
    Padding(
      key: key,
      padding: padding ?? EzInsets.wrap(config.spacing),
      child: child,
    );
