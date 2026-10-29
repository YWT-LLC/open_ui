/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'advanced_settings.dart';
import 'quick_settings.dart';
import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzAudioSettings extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Current sub-page
  final EzSubSetting target;

  /// Ez to use color settings
  /// Recommended to use as a [Scaffold.body]
  const EzAudioSettings(
    // Shared
    this.config, {
    super.key,
    required this.target,

    // Quick

    // Advanced
  });

  @override
  Widget build(BuildContext context) => EzFauxCarousel(
        config,
        position: target.isFirst ? 0 : 1,
        delta: target.isFirst ? -1 : 1,
        animMod: 0.5,
        child: (target == EzSubSetting.qckColor)
            ? QuickAudioSettings(config)
            : AdvancedAudioSettings(config),
      );
}
