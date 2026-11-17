/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'dart:math';
import 'package:material_ui/material_ui.dart';

class EzRadio<T> extends StatelessWidget {
  final EzCP config;

  /// Defaults to [EdgeInsets.all] with [EzCP.marginVal] when [ezIconRatio] > 1.1
  final EdgeInsetsGeometry? padding;

  final T value;
  final bool toggleable;
  final double _scale;

  /// [Radio] with custom styling and scaling
  EzRadio(this.config, {super.key, this.padding, required this.value, this.toggleable = false})
      : _scale = ezIconRatio(config);

  @override
  Widget build(BuildContext context) => Container(
        padding: _scale > 1.1 ? padding ?? EdgeInsets.all(config.marginVal) : EdgeInsets.zero,
        decoration: config.boxDeco(
          border: config.boxBorder(),
          shape: BoxShape.circle,
        ),
        child: Transform.scale(
          scale: max(1.0, _scale),
          child: Radio<T>(value: value, toggleable: toggleable),
        ),
      );
}
