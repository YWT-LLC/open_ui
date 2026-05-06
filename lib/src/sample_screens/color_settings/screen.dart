/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './advanced_settings.dart';
import './quick_settings.dart';
import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzColorSettings extends StatelessWidget {
  /// Current sub-page
  final EzSubSetting target;

  /// Spacer above the [EzResetButton], on both sub-screens
  final Widget resetSpacer;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [darkColorKeys] are included by default
  final Set<String>? resetExtraDark;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [lightColorKeys] are included by default
  final Set<String>? resetExtraLight;

  /// [EzResetButton.resetSkip] passthrough
  /// Shared for both themes
  final Set<String>? resetSkip;

  /// [EzResetButton.saveSkip] passthrough
  /// Shared for both themes
  final Set<String>? saveSkip;

  /// Optional additional quick settings
  /// Will appear first, above the monochrome
  /// BYO spacers
  final List<Widget>? quickHeader;

  /// Optional additional quick settings
  /// Will appear last, just above above the [EzResetButton]
  /// BYO leading spacer, trailing is [resetSpacer]
  final List<Widget>? quickFooter;

  /// Extra dark theme color keys
  final List<String>? extraDark;

  /// Extra light theme color keys
  final List<String>? extraLight;

  /// Empathetech color settings
  /// Recommended to use as a [Scaffold.body]
  const EzColorSettings({
    // Shared
    super.key,
    required this.target,
    this.resetSpacer = const EzSeparator(),
    this.resetExtraDark,
    this.resetExtraLight,
    this.resetSkip,
    this.saveSkip,

    // Quick
    this.quickHeader,
    this.quickFooter,

    // Advanced
    this.extraDark,
    this.extraLight,
  });

  @override
  Widget build(BuildContext context) => EzFauxCarousel(
        position: target.isFirst ? 0 : 1,
        delta: target.isFirst ? -1 : 1,
        animMod: 0.5,
        child: (target == EzSubSetting.qckColor)
            ? QuickColorSettings(
                quickHeader: quickHeader,
                quickFooter: quickFooter,
                resetSpacer: resetSpacer,
                resetExtraDark: resetExtraDark,
                resetExtraLight: resetExtraLight,
                resetSkip: resetSkip,
                saveSkip: saveSkip,
              )
            : AdvancedColorSettings(
                extraDark: extraDark,
                extraLight: extraLight,
                resetSpacer: resetSpacer,
                resetSkip: resetSkip,
                saveSkip: saveSkip,
              ),
      );
}
