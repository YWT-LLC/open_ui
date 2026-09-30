/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class HybridAction {
  final String label;
  final IconData icon;
  final void Function()? onPressed;
  final MenuController? menuController;
  final List<Widget>? menuChildren;

  const HybridAction({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.menuController,
    this.menuChildren,
  }) : assert(
          (menuController == null) == (menuChildren == null),
          'If MenuController is provided, MenuChildren must be. Y vice versa.',
        );
}
