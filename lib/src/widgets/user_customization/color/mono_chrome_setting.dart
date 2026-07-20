/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzMonoChromeColorsSetting extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [ThemeData.colorScheme] for [Brightness.dark]
  final ColorScheme dark;

  /// [ThemeData.colorScheme] for [Brightness.light]
  final ColorScheme light;

  /// Easily store a custom mono chrome [ColorScheme] to [EzCM]
  /// [ezHighContrastDark] and [ezHighContrastLight] by default
  const EzMonoChromeColorsSetting(
    this.config, {
    super.key,
    this.dark = ezMonoChromeDark,
    this.light = ezMonoChromeLight,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
    config,
    style: config.isDark
        ? ElevatedButton.styleFrom(
            backgroundColor: darkSurface,
            foregroundColor: Colors.white,
            iconColor: Colors.white,
            shadowColor: Colors.transparent,
            overlayColor: Colors.white,
            side: config.borderSide(color: dimWhite),
            textStyle: config.bodyStyle?.copyWith(color: Colors.white),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: lightSurface,
            foregroundColor: Colors.black,
            iconColor: Colors.black,
            shadowColor: Colors.transparent,
            overlayColor: Colors.black,
            side: config.borderSide(color: dimBlack),
            textStyle: config.bodyStyle?.copyWith(color: Colors.black),
          ),
    onPressed: () => config.rebuildUI(
      allECT,
      changes: () async {
        if (EzCM.updateBoth || config.isDark) {
          await loadColorScheme(dark, Brightness.dark);
        }
        if (EzCM.updateBoth || !config.isDark) {
          await loadColorScheme(light, Brightness.light);
        }
      },
    ),
    icon: EzIcon(config, Icons.contrast),
    label: config.ezL10n.csMonoChrome,
  );
}

/// Custom [ColorScheme.highContrastDark]
const ColorScheme ezMonoChromeDark = ColorScheme.highContrastDark(
  // Backgrounds
  surface: darkSurface,
  surfaceDim: darkSurfaceDim,
  surfaceContainer: darkSurfaceContainer,

  // Text
  // onSurface: Colors.white,
  outline: halfWhite,

  // Primary
  primary: Colors.white,
  // onPrimary: Colors.black,
  primaryContainer: dimWhite,
  onPrimaryContainer: Colors.black,

  // Secondary
  secondary: Colors.white,
  // onSecondary: Colors.black,
  secondaryContainer: dimWhite,
  onSecondaryContainer: Colors.black,

  // Tertiary
  tertiary: Colors.white,
  onTertiary: Colors.black,
  tertiaryContainer: dimWhite,
  onTertiaryContainer: Colors.black,

  // Erriary
  error: Colors.red,
  onError: Colors.white,
  errorContainer: dimWhite,
  onErrorContainer: Colors.black,

  // Misc
  outlineVariant: dimWhite,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
  scrim: Colors.black,
);

/// Custom [ColorScheme.highContrastLight]
const ColorScheme ezMonoChromeLight = ColorScheme.highContrastLight(
  // Surface
  // surface: lightSurface,
  surfaceDim: lightSurfaceDim,
  surfaceContainer: lightSurfaceContainer,

  // Text
  // onSurface: Colors.black,
  outline: halfBlack,

  // Primary
  primary: Colors.black,
  // onPrimary: Colors.white,
  primaryContainer: dimBlack,
  onPrimaryContainer: Colors.white,

  // Secondary
  secondary: Colors.black,
  onSecondary: Colors.white,
  secondaryContainer: dimBlack,
  onSecondaryContainer: Colors.white,

  // Tertiary
  tertiary: Colors.black,
  onTertiary: Colors.white,
  tertiaryContainer: dimBlack,
  onTertiaryContainer: Colors.white,

  // Erriary
  error: Colors.red,
  // onError: Colors.white,
  errorContainer: dimBlack,
  onErrorContainer: Colors.white,

  // Misc
  outlineVariant: dimBlack,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
  scrim: Colors.white,
);
