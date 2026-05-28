/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'advanced_settings.dart';
import 'quick_settings.dart';
import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzTextSettings extends StatelessWidget {
  /// Current sub-page
  final EzSubSetting target;

  /// Spacer above the [EzResetButton] (shared by both tabs)
  final Widget resetSpacer;

  /// Optional additional reset keys for the dark theme
  /// [allTextKeys] and [darkOnSurfaceKey] are included by default
  final Set<String>? resetExtraDark;

  /// Optional additional reset keys for the light theme
  /// [allTextKeys] and [lightOnSurfaceKey] are included by default
  final Set<String>? resetExtraLight;

  /// [EzResetButton.resetSkip] passthrough
  /// Shared for both themes
  final Set<String>? resetSkip;

  /// [EzResetButton.saveSkip] passthrough
  /// Shared for both themes
  final Set<String>? saveSkip;

  /// Empathetech text settings
  /// Recommended to use as a [Scaffold.body]
  const EzTextSettings({
    super.key,
    required this.target,
    this.resetSpacer = const EzSeparator(),
    this.resetExtraDark,
    this.resetExtraLight,
    this.resetSkip,
    this.saveSkip,
  });

  // Set the page title //

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: <ChangeNotifierProvider<dynamic>>[
          ChangeNotifierProvider<EzDisplayStyleProvider>(
            create: (_) => EzDisplayStyleProvider(),
          ),
          ChangeNotifierProvider<EzHeadlineStyleProvider>(
            create: (_) => EzHeadlineStyleProvider(),
          ),
          ChangeNotifierProvider<EzTitleStyleProvider>(
            create: (_) => EzTitleStyleProvider(),
          ),
          ChangeNotifierProvider<EzBodyStyleProvider>(
            create: (_) => EzBodyStyleProvider(),
          ),
          ChangeNotifierProvider<EzLabelStyleProvider>(
            create: (_) => EzLabelStyleProvider(),
          ),
        ],
        child: _TextSettings(target),
      );
}

class _TextSettings extends StatelessWidget {
  final EzSubSetting target;

  const _TextSettings(this.target);

  @override
  Widget build(BuildContext context) => EzFauxCarousel(
        position: target.isFirst ? 0 : 1,
        delta: target.isFirst ? -1 : 1,
        animMod: 0.5,
        child: (target == EzSubSetting.qckText)
            ? QuickTextSettings(
                displayProvider: Provider.of<EzDisplayStyleProvider>(context),
                headlineProvider: Provider.of<EzHeadlineStyleProvider>(context),
                titleProvider: Provider.of<EzTitleStyleProvider>(context),
                bodyProvider: Provider.of<EzBodyStyleProvider>(context),
                labelProvider: Provider.of<EzLabelStyleProvider>(context),
              )
            : AdvancedTextSettings(
                displayProvider: Provider.of<EzDisplayStyleProvider>(context),
                headlineProvider: Provider.of<EzHeadlineStyleProvider>(context),
                titleProvider: Provider.of<EzTitleStyleProvider>(context),
                bodyProvider: Provider.of<EzBodyStyleProvider>(context),
                labelProvider: Provider.of<EzLabelStyleProvider>(context),
              ),
      );
}
