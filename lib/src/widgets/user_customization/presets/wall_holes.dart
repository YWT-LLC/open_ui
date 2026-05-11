/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzWallHolesConfig extends StatelessWidget {
  /// Optional extra changes
  final Future<void> Function()? extra;

  /// !Not Windows
  const EzWallHolesConfig(this.extra, {super.key});

  static Future<bool> onPressed(BuildContext context) async {
    // If the current theme is not light, show a warning dialog
    if (EzConfig.themeMode != ThemeMode.light) {
      final bool uSure = await _confirm(context) ?? false;
      if (!uSure) return false;
    }

    await _makeItSo();
    return true;
  }

  static Future<bool?> _confirm(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext dCon) => EzAlertDialog(
          title: Text(EzConfig.l10n.gAttention, textAlign: TextAlign.center),
          content: Text(
            EzConfig.l10n.ssLightOnly,
            textAlign: TextAlign.center,
          ),
          actions: ezActionPair(
            onConfirm: () => Navigator.of(dCon).pop(true),
            confirmIsDestructive: true,
            onDeny: () => Navigator.of(dCon).pop(false),
          ),
          needsClose: false,
        ),
      );

  static Future<void> _makeItSo() async {
    // Reset //

    await EzConfig.removeKeys(lightColorKeys.keys.toSet());
    await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
    await EzConfig.removeKeys(lightTextKeys.keys.toSet());

    // Global settings //

    await EzConfig.setBool(isDarkThemeKey, false);

    // Color settings //

    await loadColorScheme(
      const ColorScheme(
        // Backgrounds
        surface: lightSurface,
        surfaceDim: Color(0xFFDAE4F8),
        surfaceContainer: Color(0xFFDAE4F8),

        // Text
        onSurface: Colors.black,
        outline: halfBlack,

        // Primary
        primary: Color(0xFF3B77BC),
        onPrimary: Colors.white,
        primaryContainer: Colors.black,
        onPrimaryContainer: Colors.white,

        // Secondary
        secondary: Color(0xFFFCCF03),
        onSecondary: Colors.black,
        secondaryContainer: Colors.black,
        onSecondaryContainer: Colors.white,

        // Tertiary
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
        outlineVariant: dimBlack,
        shadow: Colors.transparent,
        surfaceTint: Colors.transparent,
        scrim: Colors.white,
        brightness: Brightness.light,
      ),
      Brightness.light,
    );

    // Design settings //

    await EzConfig.setString(lightButtonShapeKey, EzButtonShape.rect.value);
    await EzConfig.setDouble(lightBorderWidthKey, 2.0);

    await EzConfig.setBool(lightLineLinksKey, true);
    await EzConfig.setBool(lightShowBackFABKey, true);

    await EzConfig.setString(lightBackgroundImageKey, wallHolesPath);
    await EzConfig.setString('$lightBackgroundImageKey$bfs', BoxFit.cover.name);

    await EzConfig.setString(lightTransitionTypeKey, EzTransitionType.zoom.value);
    await EzConfig.setBool(lightTransitionFadeKey, false);

    await EzConfig.setInt(lightAnimationDurationKey, 500);

    await EzConfig.setBool(lightShowScrollKey, true);

    // Text settings //

    await EzConfig.setDouble(lightTextBackgroundOpacityKey, 0.65);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle localBody = ezDefaultBodyStyle(Colors.black);

    return EzElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFDAE4F8),
        foregroundColor: Colors.black,
        overlayColor: Colors.white,
        side: const BorderSide(color: Colors.black, width: 2.0),
        shape: EzButtonShape.rect.shape,
        textStyle: localBody,
        padding: EdgeInsets.all(EzConfig.onMobile ? defaultMobilePadding : defaultDesktopPadding),
      ),
      onPressed: () async {
        final bool uSure =
            (EzConfig.themeMode == ThemeMode.light) || (await _confirm(context) ?? false);
        if (uSure) {
          await EzConfig.rebuildUI(changes: () async {
            await _makeItSo();
            await extra?.call();
          });
        }
      },
      text: EzConfig.l10n.ssWallHoles,
      textStyle: localBody,
    );
  }
}
