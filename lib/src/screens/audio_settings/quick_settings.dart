/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class QuickAudioSettings extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  const QuickAudioSettings(
    this.config, {
    super.key,
  });

  @override
  Widget build(BuildContext context) => const EzCol();
}
