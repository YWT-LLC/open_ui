/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzGlobalSettings extends StatelessWidget {
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

  /// [EzConfig.saveConfig] passthrough
  final Set<String>? saveSkip;

  /// Spacer before the [EzQuickConfig]
  /// If null, [EzQuickConfig] will not be included
  final Widget quickConfigSpacer;

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
  const EzGlobalSettings({
    super.key,
    this.excludeLocaleSetting = false,
    this.skipLocales,
    this.inDistress = const <String>{'US'},
    this.additionalSettings,
    this.saveSkip,
    this.quickConfigSpacer = const EzSeparator(),
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
        EzConfig.spacer,
        const EzDominantHandSwitch(),
        EzConfig.spacer,
        const EzThemeModeSwitch(),
        if (!excludeLocaleSetting) ...<Widget>[
          EzConfig.spacer,
          EzLocaleSetting(
            skip: skipLocales ?? <Locale>{arabic, english, chinese},
            inDistress: inDistress,
          ),
        ],
        if (additionalSettings != null) ...additionalSettings!,
        quickConfigSpacer,
        EzQuickConfig(
          extraBig: extraBig,
          extraVis: extraVis,
          extraChalk: extraChalk,
          extraNebula: extraNebula,
          extraWall: extraWall,
        ),
        EzConfig.spacer,
        EzConfigRandomizer(saveSkip: saveSkip),
        EzConfig.separator,
        EzResetButton(
          resetSkip: resetSkip,
          saveSkip: saveSkip,
          dynamicTitle: resetTitle,
        ),
      ]);
}
