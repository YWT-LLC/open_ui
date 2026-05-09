/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzHighContrastColorsSetting extends StatelessWidget {
  /// [ThemeData.colorScheme] for [Brightness.dark]
  final ColorScheme dark;

  /// [ThemeData.colorScheme] for [Brightness.light]
  final ColorScheme light;

  /// Easily store a custom mono chrome [ColorScheme] to [EzConfig]
  /// [ezHighContrastDark] and [ezHighContrastLight] by default
  const EzHighContrastColorsSetting({
    super.key,
    this.dark = ezHighContrastDark,
    this.light = ezHighContrastLight,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        style: EzConfig.isDark
            ? ElevatedButton.styleFrom(
                backgroundColor: darkSurfaceDim,
                foregroundColor: Colors.white,
                iconColor: hceGreen,
                shadowColor: Colors.transparent,
                overlayColor: hceGreen,
                side: EzConfig.borderSide(color: halfWhite),
                textStyle: EzConfig.styles.bodyLarge?.copyWith(color: Colors.white),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                iconColor: hcePurple,
                shadowColor: Colors.transparent,
                overlayColor: hcePurple,
                side: EzConfig.borderSide(color: halfBlack),
                textStyle: EzConfig.styles.bodyLarge?.copyWith(color: Colors.black),
              ),
        onPressed: () => EzConfig.rebuildUI(changes: () async {
          if (EzConfig.updateBoth || EzConfig.isDark) {
            await loadColorScheme(dark, Brightness.dark);
          }
          if (EzConfig.updateBoth || !EzConfig.isDark) {
            await loadColorScheme(light, Brightness.light);
          }
        }),
        icon: const Icon(Icons.contrast),
        label: EzConfig.l10n.csHighContrast,
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
