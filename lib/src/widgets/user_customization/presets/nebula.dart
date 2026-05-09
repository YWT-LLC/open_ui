/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzNebulaConfig extends StatelessWidget {
  /// Optional extra changes
  final Future<void> Function()? extra;

  /// Dark theme only config, will set [ThemeMode.dark]
  const EzNebulaConfig(this.extra, {super.key});

  /// When true, skips the "This is a dark theme only..." dialog
  static Future<bool> onPressed(BuildContext context) async {
    if (EzConfig.themeMode != ThemeMode.dark) {
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
        // Surface
        surface: _empathPurpleDimmer,
        surfaceDim: _hintOPurple,
        surfaceContainer: _hintOPurple,

        // Text
        onSurface: Colors.white,
        outline: halfWhite,

        // Primary
        primary: empathSand,
        onPrimary: Colors.black,
        primaryContainer: _halfSand,
        onPrimaryContainer: Colors.black,

        // Secondary
        secondary: empathEucalyptus,
        onSecondary: Colors.black,
        secondaryContainer: _halfEucalyptus,
        onSecondaryContainer: Colors.black,

        // Tertiary
        tertiary: empathPurple,
        onTertiary: Colors.white,
        tertiaryContainer: _halfPurple,
        onTertiaryContainer: Colors.white,

        // Error
        error: Colors.red,
        onError: Colors.white,
        errorContainer: _dimRed,
        onErrorContainer: Colors.white,

        // Misc
        outlineVariant: dimWhite,
        shadow: _empathPurpleDimmer,
        surfaceTint: Colors.transparent,
        scrim: Colors.black,
        brightness: Brightness.dark,
      ),
      Brightness.dark,
    );

    // Design settings //

    await EzConfig.setString(darkButtonShapeKey, EzButtonShape.jewel.value);
    await EzConfig.setDouble(darkBorderWidthKey, 1.0);

    await EzConfig.setString(darkBackgroundImageKey, nebulaPath);
    await EzConfig.setString('$darkBackgroundImageKey$boxFitSuffix', BoxFit.cover.name);

    // Text settings //

    // Font
    await EzConfig.setString(darkDisplayFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkHeadlineFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkTitleFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkBodyFontFamilyKey, sourceCodePro);
    await EzConfig.setString(darkLabelFontFamilyKey, sourceCodePro);

    // Background opacity
    await EzConfig.setDouble(darkTextBackgroundOpacityKey, 0.333);
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
      gFont: sourceCodePro,
    );

    return Container(
      decoration: ShapeDecoration(
        color: _hintOPurple,
        shape: EzButtonShape.jewel.shape,
      ),
      child: EzElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _empathPurpleDimmer,
          foregroundColor: Colors.white,
          shadowColor: _empathPurpleDimmer,
          overlayColor: empathSand,
          side: const BorderSide(color: _halfSand, width: 1.0),
          shape: EzButtonShape.jewel.shape,
          textStyle: localBody,
          padding: EdgeInsets.all(EzConfig.onMobile ? defaultMobilePadding : defaultDesktopPadding),
        ),
        onPressed: () async {
          final bool uSure =
              (EzConfig.themeMode != ThemeMode.dark) || (await _confirm(context) ?? false);
          if (uSure) {
            await EzConfig.rebuildUI(changes: () async {
              await _makeItSo();
              await extra?.call();
            });
          }
        },
        text: EzConfig.l10n.ssNebula,
        textStyle: localBody,
      ),
    );
  }
}

/// 0x80DAA520
const Color _halfSand = Color(0x80DAA520);

/// 0x8020DAA5
const Color _halfEucalyptus = Color(0x8020DAA5);

/// 0x80A520DA
const Color _halfPurple = Color(0x80A520DA);

/// 0x33FF0000
const Color _dimRed = Color(0x33FF0000);

/// 0x19A520DA
const Color _empathPurpleDimmer = Color(0x19A520DA);

/// 0xFF100010
const Color _hintOPurple = Color(0xFF100010);
