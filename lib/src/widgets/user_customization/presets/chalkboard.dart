/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzChalkboardConfig extends StatelessWidget {
  /// Optional extra changes
  final Future<void> Function()? extra;

  /// Dark theme only config; sets [ThemeMode.dark], resets it, and...
  /// Sets a [ColorScheme] similar to [ezHighContrastDark], but with a [chalkboardGreen] surface and [empathSand] accents
  /// Has mostly default design settings, but a [fingerPaint] based [TextTheme]
  const EzChalkboardConfig(this.extra, {super.key});

  static Future<bool> onPressed(BuildContext context) async {
    if (EzConfig.themeMode != ThemeMode.dark) {
      final bool uSure = await _confirm(context) ?? false;
      if (!uSure) return false;
    }

    await _makeItSo();
    return true;
  }

  static Future<bool?> _confirm(BuildContext context) => showDialog<bool>(
        context: context,
        builder: (BuildContext dCon) => EzAlertDialog(
          title: Text(EzConfig.l10n.gAttention, textAlign: TextAlign.center),
          content: Text(
            EzConfig.l10n.ssDarkOnly,
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

    await EzConfig.removeKeys(darkColorKeys.keys.toSet());
    await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
    await EzConfig.removeKeys(darkTextKeys.keys.toSet());

    // Global settings //

    await EzConfig.setBool(isDarkThemeKey, true);

    // Color settings //

    await loadColorScheme(
      const ColorScheme(
        // Backgrounds
        surface: chalkboardGreen,
        surfaceDim: chalkboardGreen,
        surfaceContainer: chalkboardGreen,

        // Text
        onSurface: Colors.white,
        outline: halfWhite,

        // Primary
        primary: empathSand,
        onPrimary: Colors.black,
        primaryContainer: chalkboardGreen,
        onPrimaryContainer: Colors.black,

        // Secondary
        secondary: halfWhite,
        onSecondary: Colors.black,
        secondaryContainer: chalkboardGreen,
        onSecondaryContainer: Colors.black,

        // Tertiary
        tertiary: empathSand,
        onTertiary: Colors.black,
        tertiaryContainer: chalkboardGreen,
        onTertiaryContainer: Colors.black,

        // Error
        error: hcError,
        onError: Colors.white,
        errorContainer: halfWhite,
        onErrorContainer: Colors.black,

        // Misc
        outlineVariant: chalkboardGreen,
        shadow: Colors.transparent,
        surfaceTint: Colors.transparent,
        scrim: Colors.black,

        // Extra
        brightness: Brightness.dark,
        surfaceContainerLowest: chalkboardGreen,
        surfaceContainerLow: chalkboardGreen,
        surfaceContainerHigh: chalkboardGreen,
        surfaceContainerHighest: chalkboardGreen,
        surfaceBright: chalkboardGreen,
      ),
      Brightness.dark,
    );

    // Design settings //

    await EzConfig.setInt(darkAnimationDurationKey, 450);

    await EzConfig.setString(darkTransitionTypeKey, EzTransitionType.turnY.value);
    await EzConfig.setBool(darkTransitionFadeKey, false);

    await EzConfig.setString(darkButtonShapeKey, EzButtonShape.rect.value);

    await EzConfig.setString(darkBackgroundImageKey, chalkboardGreen.toARGB32().toString());

    await EzConfig.setBool(darkShowBackFABKey, false);
    await EzConfig.setBool(darkShowScrollKey, false);

    // Text settings //

    await EzConfig.setString(darkDisplayFontFamilyKey, fingerPaint);
    await EzConfig.setBool(darkDisplayItalicizedKey, false);

    await EzConfig.setString(darkHeadlineFontFamilyKey, fingerPaint);
    await EzConfig.setBool(darkHeadlineItalicizedKey, false);

    await EzConfig.setString(darkTitleFontFamilyKey, fingerPaint);
    await EzConfig.setBool(darkTitleItalicizedKey, false);

    await EzConfig.setString(darkBodyFontFamilyKey, fingerPaint);
    await EzConfig.setBool(darkBodyItalicizedKey, false);

    await EzConfig.setString(darkLabelFontFamilyKey, fingerPaint);
    await EzConfig.setBool(darkLabelItalicizedKey, false);

    await EzConfig.setDouble(darkTextBackgroundOpacityKey, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle localBody = fuseWithGFont(
      starter: const TextStyle(
        fontSize: defaultBodySize,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Colors.white,
        height: defaultFontHeight,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: defaultLetterSpacing,
        wordSpacing: defaultWordSpacing,
      ),
      gFont: fingerPaint,
    );

    return EzElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: chalkboardGreen,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        overlayColor: empathSand,
        side: BorderSide.none,
        shape: EzButtonShape.rect.shape,
        textStyle: localBody,
        padding: EdgeInsets.all(
          EzConfig.onMobile ? defaultMobilePadding : defaultDesktopPadding,
        ),
      ),
      onPressed: () async {
        final bool uSure =
            (EzConfig.themeMode == ThemeMode.dark) || (await _confirm(context) ?? false);
        if (uSure) {
          await EzConfig.rebuildUI(changes: () async {
            await _makeItSo();
            await extra?.call();
          });
        }
      },
      text: EzConfig.l10n.ssChalkboard,
      textStyle: localBody,
    );
  }
}

// Local consts //

/// 0xFF264941
const Color chalkboardGreen = Color(0xFF264941);
