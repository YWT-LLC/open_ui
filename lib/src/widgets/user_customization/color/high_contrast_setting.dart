/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzHighContrastColorsSetting extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [ThemeData.colorScheme] for [Brightness.dark]
  final ColorScheme dark;

  /// [ThemeData.colorScheme] for [Brightness.light]
  final ColorScheme light;

  /// Easily store a custom mono chrome [ColorScheme] to [EzCM]
  /// [ezHighContrastDark] and [ezHighContrastLight] by default
  const EzHighContrastColorsSetting(
    this.config, {
    super.key,
    this.dark = ezHighContrastDark,
    this.light = ezHighContrastLight,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        config,
        style: config.isDark
            ? ElevatedButton.styleFrom(
                backgroundColor: darkSurfaceDim,
                foregroundColor: Colors.white,
                iconColor: hceGreen,
                shadowColor: Colors.transparent,
                overlayColor: hceGreen,
                side: config.borderSide(color: halfWhite),
                textStyle: config.bodyStyle?.copyWith(color: Colors.white),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                iconColor: hcePurple,
                shadowColor: Colors.transparent,
                overlayColor: hcePurple,
                side: config.borderSide(color: halfBlack),
                textStyle: config.bodyStyle?.copyWith(color: Colors.black),
              ),
        onPressed: () => config.rebuildUI(allEST, changes: () async {
          if (EzCM.updateBoth || config.isDark) {
            await loadColorScheme(dark, Brightness.dark);
          }
          if (EzCM.updateBoth || !config.isDark) {
            await loadColorScheme(light, Brightness.light);
          }
        }),
        icon: EzIcon(config, Icons.contrast),
        label: config.ezL10n.csHighContrast,
      );
}

/// 0xFF00FFB4
const Color hceGreen = Color(0xFF00FFB4);

/// 0xFFFFB400
const Color hceGold = Color(0xFFFFB400);

/// 0xFFB400FF
const Color hcePurple = Color(0xFFB400FF);

/// 0xFFFF6700
const Color hcError = Color(0xFFFF6700);

/// Custom [ColorScheme.highContrastDark]
const ColorScheme ezHighContrastDark = ColorScheme(
  // Backgrounds
  surface: darkSurfaceDim,
  surfaceDim: darkSurfaceContainer,
  surfaceContainer: Colors.black,

  // Text
  onSurface: Colors.white,
  outline: Colors.white,

  // Primary
  primary: hceGreen,
  onPrimary: Colors.black,
  primaryContainer: halfWhite,
  onPrimaryContainer: Colors.black,

  // Secondary
  secondary: hceGold,
  onSecondary: Colors.black,
  secondaryContainer: halfWhite,
  onSecondaryContainer: Colors.black,

  // Tertiary
  tertiary: hcePurple,
  onTertiary: Colors.white,
  tertiaryContainer: halfWhite,
  onTertiaryContainer: Colors.black,

  // Erriary
  error: hcError,
  onError: Colors.white,
  errorContainer: halfWhite,
  onErrorContainer: Colors.black,

  // Misc
  outlineVariant: halfWhite,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
  scrim: Colors.black,
  brightness: Brightness.dark,
);

/// Custom [ColorScheme.highContrastLight]
const ColorScheme ezHighContrastLight = ColorScheme(
  // Backgrounds
  surface: Colors.white,
  surfaceDim: lightSurfaceDim,
  surfaceContainer: lightSurfaceContainer,

  // Text
  onSurface: Colors.black,
  outline: Colors.black,

  // Primary
  primary: hcePurple,
  onPrimary: Colors.white,
  primaryContainer: halfBlack,
  onPrimaryContainer: Colors.white,

  // Secondary
  secondary: hceGold,
  onSecondary: Colors.black,
  secondaryContainer: halfBlack,
  onSecondaryContainer: Colors.white,

  // Tertiary
  tertiary: hceGreen,
  onTertiary: Colors.black,
  tertiaryContainer: halfBlack,
  onTertiaryContainer: Colors.white,

  // Error
  error: hcError,
  onError: Colors.white,
  errorContainer: halfBlack,
  onErrorContainer: Colors.white,

  // Misc
  outlineVariant: halfBlack,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
  scrim: Colors.white,
  brightness: Brightness.light,
);
