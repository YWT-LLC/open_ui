/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:material_ui/material_ui.dart';

class EzChalkboardConfig extends StatelessWidget {
  final EzProvider config;

  /// Like updateBoth, but smaller
  final bool autoConfirm;

  /// Optional extra changes
  final Future<void> Function(bool)? extra;

  /// Dark theme only config; sets [ThemeMode.dark], resets it, and...
  /// Sets a [ColorScheme] similar to [ezHighContrastDark], but with a [chalkboardGreen] surface and [ywtSand] accents
  /// Has mostly default design settings, but a [fingerPaint] based [TextTheme]
  const EzChalkboardConfig(
    this.config, {
    super.key,
    required this.autoConfirm,
    this.extra,
  });

  static Future<bool> onPressed(
    EzProvider config,
    bool autoConfirm, {
    required BuildContext context,
  }) async {
    if (!autoConfirm || config.themeMode != ThemeMode.dark) {
      final bool uSure = await _confirm(config, context: context) ?? false;
      if (!uSure) return false;
    }

    await _makeItSo();
    return true;
  }

  static Future<bool?> _confirm(EzProvider config, {required BuildContext context}) =>
      showDialog<bool>(
        context: context,
        builder: (BuildContext dCon) => EzAlertDialog(
          config,
          title: Text(config.ezL10n.gAttention, textAlign: TextAlign.center),
          content: Text(config.ezL10n.ssDarkOnly, textAlign: TextAlign.center),
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

    await EzManager.removeKeys(darkColorKeys.keys.toSet());
    await EzManager.removeKeys(darkDesignKeys.keys.toSet());
    await EzManager.removeKeys(darkTextKeys.keys.toSet());

    // Global settings //

    await EzManager.setBool(isDarkThemeKey, true);

    // Color settings //

    await loadColorScheme(
      const ColorScheme(
        // Surface
        surface: chalkboardGreen,
        surfaceDim: chalkboardGreen,
        surfaceContainer: chalkboardGreen,
        onSurface: Colors.white,

        // Big three
        primary: ywt.ywtSand,
        onPrimary: Colors.black,
        primaryContainer: chalkboardGreen,
        onPrimaryContainer: Colors.black,

        secondary: ywt.fadedWhite,
        onSecondary: Colors.black,
        secondaryContainer: chalkboardGreen,
        onSecondaryContainer: Colors.black,

        tertiary: ywt.ywtSand,
        onTertiary: Colors.black,
        tertiaryContainer: chalkboardGreen,
        onTertiaryContainer: Colors.black,

        // Misc
        error: hcError,
        onError: Colors.white,
        errorContainer: ywt.fadedWhite,
        onErrorContainer: Colors.black,

        outline: ywt.fadedWhite,
        outlineVariant: chalkboardGreen,
        surfaceTint: Colors.transparent,
        shadow: Colors.transparent,
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

    // Button
    await EzManager.setString(darkButtonShapeKey, EzButtonShape.rect.value);

    await EzManager.setBool(darkShowBackFABKey, false);
    await EzManager.setBool(darkShowScrollKey, false);

    // Page
    await EzManager.setInt(darkAnimationDurationKey, 450);

    await EzManager.setString(darkTransitionTypeKey, EzTransitionType.turnY.value);
    await EzManager.setBool(darkTransitionFadeKey, false);

    await EzManager.setString(darkBackgroundImageKey, chalkboardGreen.toARGB32().toString());

    // Text settings //

    await EzManager.setString(darkDisplayFontFamilyKey, fingerPaint);
    await EzManager.setBool(darkDisplayItalicizedKey, false);

    await EzManager.setString(darkHeadlineFontFamilyKey, fingerPaint);
    await EzManager.setBool(darkHeadlineItalicizedKey, false);

    await EzManager.setString(darkTitleFontFamilyKey, fingerPaint);
    await EzManager.setBool(darkTitleItalicizedKey, false);

    await EzManager.setString(darkBodyFontFamilyKey, fingerPaint);
    await EzManager.setBool(darkBodyItalicizedKey, false);

    await EzManager.setString(darkLabelFontFamilyKey, fingerPaint);
    await EzManager.setBool(darkLabelItalicizedKey, false);

    await EzManager.setDouble(darkTextBackgroundOpacityKey, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle localBody = fuseWithGFont(
      starter: const TextStyle(
        fontSize: ywt.defaultBodySize,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: Colors.white,
        height: ywt.defaultFontHeight,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: ywt.defaultLetterSpacing,
        wordSpacing: ywt.defaultWordSpacing,
      ),
      gFont: fingerPaint,
    );

    return EzElevatedButton(
      config,
      style: ElevatedButton.styleFrom(
        backgroundBuilder: ezSelfBuilder,
        backgroundColor: chalkboardGreen,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        overlayColor: ywt.ywtSand,
        side: BorderSide.none,
        shape: EzButtonShape.rect.shape,
        textStyle: localBody,
        padding: EdgeInsets.all(
            EzManager.onMobile ? ywt.defaultMobilePadding : ywt.defaultDesktopPadding),
      ),
      onPressed: () async {
        final bool uSure = autoConfirm ||
            (config.themeMode == ThemeMode.dark) ||
            (await _confirm(config, context: context) ?? false);

        if (uSure) {
          await config.rebuildUI(changes: () async {
            await _makeItSo();
            await extra?.call(autoConfirm);
          });
        }
      },
      text: config.ezL10n.ssChalkboard,
      textStyle: localBody,
    );
  }
}

// Local consts //

/// 0xFF264941
const Color chalkboardGreen = Color(0xFF264941);
