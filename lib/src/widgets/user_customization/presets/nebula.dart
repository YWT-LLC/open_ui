/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:material_ui/material_ui.dart';

class EzNebulaConfig extends StatelessWidget {
  final EzCP config;

  /// Like updateBoth, but smaller
  final bool autoConfirm;

  /// Optional extra changes
  final Future<void> Function(bool)? extra;

  /// Dark theme only config, will set [ThemeMode.dark]
  const EzNebulaConfig(this.config, {super.key, required this.autoConfirm, this.extra});

  /// When true, skips the "This is a dark theme only..." dialog
  static Future<bool> onPressed(
    EzCP config,
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

  static Future<bool?> _confirm(EzCP config, {required BuildContext context}) => showDialog(
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

    await EzCM.removeKeys(darkColorKeys.keys.toSet());
    await EzCM.removeKeys(darkDesignKeys.keys.toSet());
    await EzCM.removeKeys(darkTextKeys.keys.toSet());

    // Global settings //

    await EzCM.setBool(isDarkThemeKey, true);

    // Color settings //

    await loadColorScheme(
      ColorScheme(
        // Surface
        surface: ywt.ywtPurple.withValues(alpha: _nO),
        surfaceDim: _hintOPurple,
        surfaceContainer: _hintOPurple,

        // Text
        onSurface: Colors.white,
        outline: ywt.fadedWhite,

        // Primary
        primary: ywt.ywtSand,
        onPrimary: Colors.black,
        primaryContainer: ywt.ywtSand.withValues(alpha: 0.5),
        onPrimaryContainer: Colors.black,

        // Secondary
        secondary: ywt.ywtEucalyptus,
        onSecondary: Colors.black,
        secondaryContainer: ywt.ywtEucalyptus.withValues(alpha: 0.5),
        onSecondaryContainer: Colors.black,

        // Tertiary
        tertiary: ywt.ywtPurple,
        onTertiary: Colors.white,
        tertiaryContainer: ywt.ywtPurple.withValues(alpha: 0.5),
        onTertiaryContainer: Colors.white,

        // Error
        error: Colors.red,
        onError: Colors.white,
        errorContainer: Colors.red.withValues(alpha: _nO),
        onErrorContainer: Colors.white,

        // Misc
        outlineVariant: ywt.dimWhite,
        shadow: ywt.ywtPurple.withValues(alpha: _nO),
        surfaceTint: Colors.transparent,
        scrim: Colors.black,
        brightness: Brightness.dark,
      ),
      Brightness.dark,
    );

    // Design settings //

    await EzCM.setString(darkButtonShapeKey, EzButtonShape.jewel.value);
    await EzCM.setDouble(darkBorderWidthKey, 1.0);

    // PRESENTS PLACEHOLDER
    await EzCM.setString(darkBackgroundFitKey, BoxFit.cover.name);
    await EzCM.setString(darkBackgroundSourceKey, 'https://www.pexels.com/@jmueller/');

    // Text settings //

    // Font
    await EzCM.setString(darkDisplayFontFamilyKey, sourceCodePro);
    await EzCM.setString(darkHeadlineFontFamilyKey, sourceCodePro);
    await EzCM.setString(darkTitleFontFamilyKey, sourceCodePro);
    await EzCM.setString(darkBodyFontFamilyKey, sourceCodePro);
    await EzCM.setString(darkLabelFontFamilyKey, sourceCodePro);

    // Background opacity
    await EzCM.setDouble(darkTextBackgroundOpacityKey, 0.333);
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
      gFont: sourceCodePro,
    );

    return Container(
      decoration: ShapeDecoration(color: _hintOPurple, shape: EzButtonShape.jewel.shape),
      child: EzElevatedButton(
        config,
        style: ElevatedButton.styleFrom(
          backgroundColor: ywt.ywtPurple.withValues(alpha: _nO),
          foregroundColor: Colors.white,
          shadowColor: ywt.ywtPurple.withValues(alpha: _nO),
          overlayColor: ywt.ywtSand,
          side: BorderSide(color: ywt.ywtSand.withValues(alpha: 0.5)),
          shape: EzButtonShape.jewel.shape,
          textStyle: localBody,
          padding:
              EdgeInsets.all(EzCM.onMobile ? ywt.defaultMobilePadding : ywt.defaultDesktopPadding),
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
        text: config.ezL10n.ssNebula,
        textStyle: localBody,
      ),
    );
  }
}

/// Nebula Opacity
/// 0.20
const double _nO = 0.20;

/// 0xFF100010
const Color _hintOPurple = Color(0xFF100010);
