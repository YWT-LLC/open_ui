/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzThemeModeSwitch extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Standardized tool for changing the [ThemeMode]
  const EzThemeModeSwitch(this.config, {super.key});

  @override
  Widget build(BuildContext context) => EzDropdownMenu<ThemeMode>(
        config,
        label: config.ezL10n.ssThemeMode,
        widthEntry: config.ezL10n.gSystem,
        dropdownMenuEntries: <DropdownMenuEntry<ThemeMode>>[
          DropdownMenuEntry<ThemeMode>(value: ThemeMode.system, label: config.ezL10n.gSystem),
          DropdownMenuEntry<ThemeMode>(value: ThemeMode.light, label: config.ezL10n.gLight),
          DropdownMenuEntry<ThemeMode>(value: ThemeMode.dark, label: config.ezL10n.gDark),
        ],
        enableSearch: false,
        initialSelection: config.themeMode,
        onSelected: (ThemeMode? choice) async {
          if (choice == null || choice == config.themeMode) return;

          switch (choice) {
            case ThemeMode.dark:
              await EzCM.setBool(isDarkThemeKey, true);
              break;
            case ThemeMode.light:
              await EzCM.setBool(isDarkThemeKey, false);
              break;
            case ThemeMode.system:
              await EzCM.remove(isDarkThemeKey);
              break;
          }
          await config.rebuildThemeMode();
        },
      );
}
