/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:flutter/material.dart';

class EzWallHolesConfig extends StatelessWidget {
  final EzCP config;

  /// Like updateBoth, but smaller
  final bool autoConfirm;

  /// Optional extra changes
  final Future<void> Function(bool)? extra;

  /// !Not Windows
  const EzWallHolesConfig(
    this.config, {
    super.key,
    required this.autoConfirm,
    this.extra,
  });

  static Future<bool> onPressed(
    EzCP config,
    bool autoConfirm, {
    required BuildContext context,
  }) async {
    // If the current theme is not light, show a warning dialog
    if (!autoConfirm || config.themeMode != ThemeMode.light) {
      final bool uSure = await _confirm(config, context: context) ?? false;
      if (!uSure) return false;
    }

    await _makeItSo();
    return true;
  }

  static Future<bool?> _confirm(EzCP config, {required BuildContext context}) => showDialog(
        context: context,
        builder: (BuildContext dCon) => EzAlertDialog(
          config,
          title: Text(config.ezL10n.gAttention, textAlign: TextAlign.center),
          content: Text(config.ezL10n.ssLightOnly, textAlign: TextAlign.center),
          actions: ezActionPair(
            config,
            onConfirm: () => Navigator.of(dCon).pop(true),
            confirmIsDestructive: true,
            onDeny: () => Navigator.of(dCon).pop(false),
          ),
          needsClose: false,
        ),
      );

  static Future<void> _makeItSo() async {
    // Reset //

    await EzCM.removeKeys(lightColorKeys.keys.toSet());
    await EzCM.removeKeys(lightDesignKeys.keys.toSet());
    await EzCM.removeKeys(lightTextKeys.keys.toSet());

    // Global settings //

    await EzCM.setBool(isDarkThemeKey, false);

    // Color settings //

    await loadColorScheme(
      const ColorScheme(
        brightness: Brightness.light,

        // Surface
        surface: ywt.lightSurface,
        surfaceDim: Color(0xFFDAE4F8),
        surfaceContainer: Color(0xFFDAE4F8),
        onSurface: Colors.black,

        // Big three
        primary: Color(0xFF3B77BC),
        onPrimary: Colors.white,
        primaryContainer: Colors.black,
        onPrimaryContainer: Colors.white,

        secondary: Color(0xFFFCCF03),
        onSecondary: Colors.black,
        secondaryContainer: Colors.black,
        onSecondaryContainer: Colors.white,

        tertiary: Color(0xFF81C046),
        onTertiary: Colors.black,
        tertiaryContainer: Colors.black,
        onTertiaryContainer: Colors.white,

        // Error
        error: Color(0xFFDE482B),
        onError: Colors.white,
        errorContainer: Colors.black,
        onErrorContainer: Colors.white,

        // Misc
        outline: ywt.halfBlack,
        outlineVariant: ywt.dimBlack,
        surfaceTint: Colors.transparent,
        shadow: Colors.transparent,
        scrim: Colors.white,
      ),
      Brightness.light,
    );

    // Design settings //

    await EzCM.setString(lightButtonShapeKey, EzButtonShape.rect.value);
    await EzCM.setDouble(lightBorderWidthKey, 2.0);

    await EzCM.setBool(lightLineLinksKey, true);
    await EzCM.setBool(lightShowBackFABKey, true);

    // PRESENTS PLACEHOLDER
    await EzCM.setString(lightBackgroundFitKey, BoxFit.cover.name);
    await EzCM.setString(lightBackgroundSourceKey, 'https://www.pexels.com/@carl-wyatt-654792/');

    await EzCM.setString(lightTransitionTypeKey, EzTransitionType.zoom.value);
    await EzCM.setBool(lightTransitionFadeKey, false);

    await EzCM.setInt(lightAnimationDurationKey, 500);

    await EzCM.setBool(lightShowScrollKey, true);

    // Text settings //

    await EzCM.setDouble(lightTextBackgroundOpacityKey, 0.80);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle localBody = ezDefaultBodyStyle(Colors.black, isDark: config.isDark);

    return EzElevatedButton(
      config,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFDAE4F8),
        foregroundColor: Colors.black,
        overlayColor: Colors.white,
        side: const BorderSide(width: 2.0),
        shape: EzButtonShape.rect.shape,
        textStyle: localBody,
        padding:
            EdgeInsets.all(EzCM.onMobile ? ywt.defaultMobilePadding : ywt.defaultDesktopPadding),
      ),
      onPressed: () async {
        final bool uSure = autoConfirm ||
            (config.themeMode == ThemeMode.light) ||
            (await _confirm(config, context: context) ?? false);

        if (uSure) {
          await config.rebuildUI(changes: () async {
            await _makeItSo();
            await extra?.call(autoConfirm);
          });
        }
      },
      text: config.ezL10n.ssWallHoles,
      textStyle: localBody,
    );
  }
}
