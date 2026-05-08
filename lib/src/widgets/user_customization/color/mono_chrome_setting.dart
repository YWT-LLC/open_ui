/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzMonoChromeColorsSetting extends StatelessWidget {
  /// [ThemeData.colorScheme] for [Brightness.dark]
  final ColorScheme dark;

  /// [ThemeData.colorScheme] for [Brightness.light]
  final ColorScheme light;

  /// Easily store a custom mono chrome [ColorScheme] to [EzConfig]
  /// [ezHighContrastDark] and [ezHighContrastLight] by default
  const EzMonoChromeColorsSetting({
    super.key,
    this.dark = ezMonoChromeDark,
    this.light = ezMonoChromeLight,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        style: EzConfig.isDark
            ? ElevatedButton.styleFrom(
                backgroundColor: darkSurface,
                foregroundColor: Colors.white,
                iconColor: Colors.white,
                shadowColor: Colors.transparent,
                overlayColor: Colors.white,
                side: EzConfig.borderSide(color: dimWhite),
                textStyle: EzConfig.styles.bodyLarge?.copyWith(color: Colors.white),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: lightSurface,
                foregroundColor: Colors.black,
                iconColor: Colors.black,
                shadowColor: Colors.transparent,
                overlayColor: Colors.black,
                side: EzConfig.borderSide(color: dimBlack),
                textStyle: EzConfig.styles.bodyLarge?.copyWith(color: Colors.black),
              ),
        onPressed: () async {
          if (EzConfig.updateBoth || EzConfig.isDark) {
            await loadColorScheme(dark, Brightness.dark);
          }
          if (EzConfig.updateBoth || !EzConfig.isDark) {
            await loadColorScheme(light, Brightness.light);
          }

          await EzConfig.rebuildUI();
        },
        icon: const Icon(Icons.contrast),
        label: EzConfig.l10n.csMonoChrome,
      );
}

/// 0x33FFFFFF
const Color dimWhite = Color(0x33FFFFFF);

/// 0x33FFFFFF
const Color dimBlack = Color(0x33000000);

/// Custom [ColorScheme.highContrastDark]
const ColorScheme ezMonoChromeDark = ColorScheme.highContrastDark(
  // Primary
  primary: Colors.white,
  onPrimary: Colors.black,
  primaryContainer: dimWhite,
  onPrimaryContainer: Colors.black,

  // Secondary
  secondary: Colors.white,
  onSecondary: Colors.black,
  secondaryContainer: dimWhite,
  onSecondaryContainer: Colors.black,

  // Tertiary
  tertiary: Colors.white,
  onTertiary: Colors.black,
  tertiaryContainer: dimWhite,
  onTertiaryContainer: Colors.black,

  // Error
  error: Colors.red,
  onError: Colors.white,
  errorContainer: dimWhite,
  onErrorContainer: Colors.black,

  // Surface
  surfaceContainer: darkSurfaceContainer,
  surfaceDim: darkSurfaceDim,
  surface: darkSurface,
  onSurface: Colors.white,

  // Misc
  outline: halfWhite,
  outlineVariant: dimWhite,
  scrim: Colors.black,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
);

/// Custom [ColorScheme.highContrastLight]
const ColorScheme ezMonoChromeLight = ColorScheme.highContrastLight(
  // Primary
  primary: Colors.black,
  onPrimary: Colors.white,
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

  // Error
  error: Colors.red,
  onError: Colors.white,
  errorContainer: dimBlack,
  onErrorContainer: Colors.white,

  // Surface
  surfaceContainer: lightSurfaceContainer,
  surfaceDim: lightSurfaceDim,
  surface: lightSurface,
  onSurface: Colors.black,

  // Misc
  outline: halfBlack,
  outlineVariant: dimBlack,
  scrim: Colors.white,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
);
