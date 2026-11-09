/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:material_ui/material_ui.dart';

//* Setup *//

const Color hceGreen = Color(0xFF00FFB4);
const Color hceGold = Color(0xFFFFB400);
const Color hcePurple = Color(0xFFB400FF);
const Color hcError = Color(0xFFFF6700);

//* Make it so *//

class EzHighContrastColorsSetting extends StatelessWidget {
  final EzCP config;
  final ColorScheme dark;
  final ColorScheme light;

  /// Defaults to [ezHighContrastDark] and [ezHighContrastLight]
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
                backgroundColor: ywt.darkSurfaceDim,
                foregroundColor: Colors.white,
                iconColor: hceGreen,
                shadowColor: Colors.transparent,
                overlayColor: hceGreen,
                side: config.borderSide(const EzSwitchColor(color: ywt.fadedWhite)),
                textStyle: config.bodyStyle?.copyWith(color: Colors.white),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                iconColor: hcePurple,
                shadowColor: Colors.transparent,
                overlayColor: hcePurple,
                side: config.borderSide(const EzSwitchColor(color: ywt.fadedBlack)),
                textStyle: config.bodyStyle?.copyWith(color: Colors.black),
              ),
        onPressed: () => config.rebuildUI(changes: () async {
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

/// Custom [ColorScheme.highContrastDark]
const ColorScheme ezHighContrastDark = ColorScheme(
  brightness: Brightness.dark,

  // Surface
  surface: ywt.darkSurfaceDim,
  surfaceDim: ywt.darkSurfaceContainer,
  surfaceContainer: Colors.black,
  onSurface: Colors.white,

  // Big three
  primary: hceGreen,
  onPrimary: Colors.black,
  primaryContainer: ywt.fadedWhite,
  onPrimaryContainer: Colors.black,

  secondary: hceGold,
  onSecondary: Colors.black,
  secondaryContainer: ywt.fadedWhite,
  onSecondaryContainer: Colors.black,

  tertiary: hcePurple,
  onTertiary: Colors.white,
  tertiaryContainer: ywt.fadedWhite,
  onTertiaryContainer: Colors.black,

  // Misc
  error: hcError,
  onError: Colors.white,
  errorContainer: ywt.fadedWhite,
  onErrorContainer: Colors.black,

  outline: Colors.white,
  outlineVariant: ywt.fadedWhite,
  surfaceTint: Colors.transparent,
  shadow: Colors.transparent,
  scrim: Colors.black,
);

/// Custom [ColorScheme.highContrastLight]
const ColorScheme ezHighContrastLight = ColorScheme(
  brightness: Brightness.light,

  // Surface
  surface: Colors.white,
  surfaceDim: ywt.lightSurfaceDim,
  surfaceContainer: ywt.lightSurfaceContainer,
  onSurface: Colors.black,

  // Big three
  primary: hcePurple,
  onPrimary: Colors.white,
  primaryContainer: ywt.fadedBlack,
  onPrimaryContainer: Colors.white,

  secondary: hceGold,
  onSecondary: Colors.black,
  secondaryContainer: ywt.fadedBlack,
  onSecondaryContainer: Colors.white,

  tertiary: hceGreen,
  onTertiary: Colors.black,
  tertiaryContainer: ywt.fadedBlack,
  onTertiaryContainer: Colors.white,

  // Misc
  error: hcError,
  onError: Colors.white,
  errorContainer: ywt.fadedBlack,
  onErrorContainer: Colors.white,

  outline: Colors.black,
  outlineVariant: ywt.fadedBlack,
  surfaceTint: Colors.transparent,
  shadow: Colors.transparent,
  scrim: Colors.white,
);
