/* empathetech_flutter_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

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

class EzBox extends BoxConstraints {
  /// [BoxConstraints] with everything (min && max) set to [base]
  const EzBox.sym(double base)
      : super(minWidth: base, maxWidth: base, minHeight: base, maxHeight: base);

  /// [BoxConstraints] with [minWidth] && [maxWidth] set to [base]
  const EzBox.vertical(double base) : super(minHeight: base, maxHeight: base);

  /// [BoxConstraints] with [minHeight] && [maxHeight] set to [base]
  const EzBox.horizontal(double base) : super(minWidth: base, maxWidth: base);
}
