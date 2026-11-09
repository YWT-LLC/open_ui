/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:material_ui/material_ui.dart';

class EzMonoChromeColorsSetting extends StatelessWidget {
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
                backgroundColor: ywt.darkSurface,
                foregroundColor: Colors.white,
                iconColor: Colors.white,
                shadowColor: Colors.transparent,
                overlayColor: Colors.white,
                side: config.borderSide(const EzSwitchColor(color: ywt.dimWhite)),
                textStyle: config.bodyStyle?.copyWith(color: Colors.white),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: ywt.lightSurface,
                foregroundColor: Colors.black,
                iconColor: Colors.black,
                shadowColor: Colors.transparent,
                overlayColor: Colors.black,
                side: config.borderSide(const EzSwitchColor(color: ywt.dimBlack)),
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
        label: config.ezL10n.csMonoChrome,
      );
}

/// Custom [ColorScheme.highContrastDark]
const ColorScheme ezMonoChromeDark = ColorScheme.highContrastDark(
  // Backgrounds
  surface: ywt.darkSurface,
  surfaceDim: ywt.darkSurfaceDim,
  surfaceContainer: ywt.darkSurfaceContainer,

  // Big three
  primary: Colors.white,
  primaryContainer: ywt.dimWhite,
  onPrimaryContainer: Colors.black,

  secondary: Colors.white,
  secondaryContainer: ywt.dimWhite,
  onSecondaryContainer: Colors.black,

  tertiary: Colors.white,
  onTertiary: Colors.black,
  tertiaryContainer: ywt.dimWhite,
  onTertiaryContainer: Colors.black,

  // Misc
  error: Colors.red,
  onError: Colors.white,
  errorContainer: ywt.dimWhite,
  onErrorContainer: Colors.black,

  outline: ywt.fadedWhite,
  outlineVariant: ywt.dimWhite,
  surfaceTint: Colors.transparent,
  shadow: Colors.transparent,
  scrim: Colors.black,
);

/// Custom [ColorScheme.highContrastLight]
const ColorScheme ezMonoChromeLight = ColorScheme.highContrastLight(
  // Surface
  surfaceDim: ywt.lightSurfaceDim,
  surfaceContainer: ywt.lightSurfaceContainer,

  // Primary
  primary: Colors.black,
  primaryContainer: ywt.dimBlack,
  onPrimaryContainer: Colors.white,

  secondary: Colors.black,
  onSecondary: Colors.white,
  secondaryContainer: ywt.dimBlack,
  onSecondaryContainer: Colors.white,

  tertiary: Colors.black,
  onTertiary: Colors.white,
  tertiaryContainer: ywt.dimBlack,
  onTertiaryContainer: Colors.white,

  // Misc
  error: Colors.red,
  errorContainer: ywt.dimBlack,
  onErrorContainer: Colors.white,

  outline: ywt.fadedBlack,
  outlineVariant: ywt.dimBlack,
  surfaceTint: Colors.transparent,
  shadow: Colors.transparent,
  scrim: Colors.white,
);
