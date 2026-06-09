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
  /// EzConfig Provider
  final EzCP config;

  /// Current sub-page
  final EzSubSetting target;

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
  const EzTextSettings(
    this.config, {
    super.key,
    required this.target,
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
            create: (_) => EzDisplayStyleProvider(config.isDark),
          ),
          ChangeNotifierProvider<EzHeadlineStyleProvider>(
            create: (_) => EzHeadlineStyleProvider(config.isDark),
          ),
          ChangeNotifierProvider<EzTitleStyleProvider>(
            create: (_) => EzTitleStyleProvider(config.isDark),
          ),
          ChangeNotifierProvider<EzBodyStyleProvider>(
            create: (_) => EzBodyStyleProvider(config.isDark),
          ),
          ChangeNotifierProvider<EzLabelStyleProvider>(
            create: (_) => EzLabelStyleProvider(config.isDark),
          ),
        ],
        child: _TextSettings(config, target),
      );
}

class _TextSettings extends StatelessWidget {
  final EzCP config;
  final EzSubSetting target;

  const _TextSettings(this.config, this.target);

  @override
  Widget build(BuildContext context) => EzFauxCarousel(
        config,
        position: target.isFirst ? 0 : 1,
        delta: target.isFirst ? -1 : 1,
        animMod: 0.5,
        child: (target == EzSubSetting.qckText)
            ? QuickTextSettings(
                config,
                displayProvider: Provider.of<EzDisplayStyleProvider>(context),
                headlineProvider: Provider.of<EzHeadlineStyleProvider>(context),
                titleProvider: Provider.of<EzTitleStyleProvider>(context),
                bodyProvider: Provider.of<EzBodyStyleProvider>(context),
                labelProvider: Provider.of<EzLabelStyleProvider>(context),
              )
            : AdvancedTextSettings(
                config,
                displayProvider: Provider.of<EzDisplayStyleProvider>(context),
                headlineProvider: Provider.of<EzHeadlineStyleProvider>(context),
                titleProvider: Provider.of<EzTitleStyleProvider>(context),
                bodyProvider: Provider.of<EzBodyStyleProvider>(context),
                labelProvider: Provider.of<EzLabelStyleProvider>(context),
              ),
      );
}
