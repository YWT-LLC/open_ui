/* empathetech_flutter_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzGlobalSettings extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Optionally remove the locale setting
  final bool excludeLocaleSetting;

  /// [EzLocaleSetting.inDistress] passthrough
  final Set<String> inDistress;

  /// Locales to skip in the [EzLocaleSetting]
  /// Defaults to {[arabic], [english], [chinese]} to avoid dupes
  final Set<Locale>? skipLocales;

  /// [Widget]s to be added below the [EzLocaleSetting]
  /// BYO leading spacer, see [quickConfigSpacer] for trailing spacer
  final List<Widget>? additionalSettings;

  /// [EzCM.saveConfig] passthrough
  final Set<String>? saveSkip;

  /// Defaults to [EzCP.separator]
  final Widget? quickConfigSpacer;

  /// [EzBigButtonsConfig.extra] passthrough
  final Future<void> Function(bool)? extraBig;

  /// [EzBigButtonsConfig.extra] passthrough
  final Future<void> Function(bool)? extraVis;

  /// [EzBigButtonsConfig.extra] passthrough
  final Future<void> Function(bool)? extraChalk;

  /// [EzBigButtonsConfig.extra] passthrough
  final Future<void> Function(bool)? extraNebula;

  /// [EzBigButtonsConfig.extra] passthrough
  final Future<void> Function(bool)? extraWall;

  /// [EzResetButton.resetSkip] passthrough
  final Set<String>? resetSkip;

  /// [EzResetButton.dynamicTitle] passthrough
  final String Function()? resetTitle;

  /// Empathetech settings landing page
  /// Contains global settings and [EzElevatedIconButton]s that lead to the rest of the settings pages
  /// Recommended to use as a [Scaffold.body]
  const EzGlobalSettings(
    this.config, {
    super.key,
    this.excludeLocaleSetting = false,
    this.skipLocales,
    this.inDistress = const <String>{'US'},
    this.additionalSettings,
    this.saveSkip,
    this.quickConfigSpacer,
    this.extraBig,
    this.extraVis,
    this.extraChalk,
    this.extraNebula,
    this.extraWall,
    this.resetSkip,
    this.resetTitle,
  });

  @override
  Widget build(BuildContext context) => EzCol(children: <Widget>[
        config.spacer,
        EzDominantHandSwitch(config),
        config.spacer,
        EzThemeModeSwitch(config),
        if (!excludeLocaleSetting) ...<Widget>[
          config.spacer,
          EzLocaleSetting(
            config,
            skip: skipLocales ?? <Locale>{arabic, english, chinese},
            inDistress: inDistress,
          ),
        ],
        if (additionalSettings != null) ...additionalSettings!,
        quickConfigSpacer ?? config.separator,
        EzQuickConfig(
          config,
          extraBig: extraBig,
          extraVis: extraVis,
          extraChalk: extraChalk,
          extraNebula: extraNebula,
          extraWall: extraWall,
        ),
        config.spacer,
        EzConfigRandomizer(config, saveSkip: saveSkip),
        config.separator,
        EzResetButton(
          config,
          resetSkip: resetSkip,
          saveSkip: saveSkip,
          dynamicTitle: resetTitle,
        ),
      ]);
}
