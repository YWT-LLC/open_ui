/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:material_ui/material_ui.dart';

class EzHighVisibilityConfig extends StatelessWidget {
  final EzProvider config;

  /// Whether both themes should be updated
  final bool updateBoth;

  /// Optional extra changes
  final Future<void> Function(bool)? extra;

  /// Resets the current config and applies the [ezHighContrastLight] | [ezHighContrastDark] color scheme
  /// With text theme built with [atkinsonHyperlegible] and is slightly larger than the default
  /// Spacing is also increased, but not as much as [EzBigButtonsConfig]
  const EzHighVisibilityConfig(
    this.config, {
    super.key,
    required this.updateBoth,
    this.extra,
  });

  static Future<void> onPressed(EzProvider config, bool updateBoth,
      {bool monoChrome = false}) async {
    if (updateBoth || config.isDark) {
      // Reset //

      await EzManager.removeKeys(darkColorKeys.keys.toSet());
      await EzManager.removeKeys(darkDesignKeys.keys.toSet());
      await EzManager.removeKeys(darkTextKeys.keys.toSet());

      // Color settings //

      await loadColorScheme(monoChrome ? ezMonoChromeDark : ezHighContrastDark, Brightness.dark);

      // Design settings //

      // Button
      await EzManager.setBool(darkLineLinksKey, true);
      await EzManager.setBool(darkShowBackFABKey, false);
      await EzManager.setBool(darkShowScrollKey, false);

      // Page
      await EzManager.setDouble(darkSpacingKey, EzManager.onMobile ? 27.5 : 33.0);

      await EzManager.setString(darkTransitionTypeKey, EzTransitionType.system.value);
      await EzManager.setBool(darkTransitionFadeKey, false);

      // Text settings //

      // Display
      await EzManager.setString(darkDisplayFontFamilyKey, atkinsonHyperlegible);
      await EzManager.setDouble(darkDisplayFontSizeKey, 50);
      await EzManager.setBool(darkDisplayBoldedKey, false);
      await EzManager.setBool(darkDisplayItalicizedKey, false);
      await EzManager.setBool(darkDisplayUnderlinedKey, false);
      await EzManager.setDouble(darkDisplayFontHeightKey, 1.5);
      await EzManager.setDouble(darkDisplayLetterSpacingKey, 0.30);
      await EzManager.setDouble(darkDisplayWordSpacingKey, 1.25);

      // Headline
      await EzManager.setString(darkHeadlineFontFamilyKey, atkinsonHyperlegible);
      await EzManager.setDouble(darkHeadlineFontSizeKey, 38);
      await EzManager.setBool(darkHeadlineBoldedKey, false);
      await EzManager.setBool(darkHeadlineItalicizedKey, false);
      await EzManager.setBool(darkHeadlineUnderlinedKey, false);
      await EzManager.setDouble(darkHeadlineFontHeightKey, 1.625);
      await EzManager.setDouble(darkHeadlineLetterSpacingKey, 0.30);
      await EzManager.setDouble(darkHeadlineWordSpacingKey, 1.25);

      // Title
      await EzManager.setString(darkTitleFontFamilyKey, atkinsonHyperlegible);
      await EzManager.setDouble(darkTitleFontSizeKey, 26);
      await EzManager.setBool(darkTitleBoldedKey, false);
      await EzManager.setBool(darkTitleItalicizedKey, false);
      await EzManager.setBool(darkTitleUnderlinedKey, true);
      await EzManager.setDouble(darkTitleFontHeightKey, 1.75);
      await EzManager.setDouble(darkTitleLetterSpacingKey, 0.30);
      await EzManager.setDouble(darkTitleWordSpacingKey, 1.25);

      // Body
      await EzManager.setString(darkBodyFontFamilyKey, atkinsonHyperlegible);
      await EzManager.setDouble(darkBodyFontSizeKey, 20);
      await EzManager.setBool(darkBodyBoldedKey, false);
      await EzManager.setBool(darkBodyItalicizedKey, false);
      await EzManager.setBool(darkBodyUnderlinedKey, false);
      await EzManager.setDouble(darkBodyFontHeightKey, 1.75);
      await EzManager.setDouble(darkBodyLetterSpacingKey, 0.30);
      await EzManager.setDouble(darkBodyWordSpacingKey, 1.25);

      // Label
      await EzManager.setString(darkLabelFontFamilyKey, atkinsonHyperlegible);
      await EzManager.setDouble(darkLabelFontSizeKey, 16);
      await EzManager.setBool(darkLabelBoldedKey, false);
      await EzManager.setBool(darkLabelItalicizedKey, false);
      await EzManager.setBool(darkLabelUnderlinedKey, false);
      await EzManager.setDouble(darkLabelFontHeightKey, 1.75);
      await EzManager.setDouble(darkLabelLetterSpacingKey, 0.30);
      await EzManager.setDouble(darkLabelWordSpacingKey, 1.25);

      // etc
      await EzManager.setDouble(darkIconSizeKey, 22.0);
    }

    if (updateBoth || !config.isDark) {
      // Reset //

      await EzManager.removeKeys(lightColorKeys.keys.toSet());
      await EzManager.removeKeys(lightDesignKeys.keys.toSet());
      await EzManager.removeKeys(lightTextKeys.keys.toSet());

      // Color settings //

      await loadColorScheme(monoChrome ? ezMonoChromeLight : ezHighContrastLight, Brightness.light);

      // Design settings //

      // Button
      await EzManager.setBool(lightLineLinksKey, true);
      await EzManager.setBool(lightShowBackFABKey, false);
      await EzManager.setBool(lightShowScrollKey, false);

      // Page
      await EzManager.setDouble(lightSpacingKey, EzManager.onMobile ? 27.5 : 33.0);

      await EzManager.setString(lightTransitionTypeKey, EzTransitionType.system.value);
      await EzManager.setBool(lightTransitionFadeKey, false);

      // Text settings //

      // Display
      await EzManager.setString(lightDisplayFontFamilyKey, atkinsonHyperlegible);
      await EzManager.setDouble(lightDisplayFontSizeKey, 50);
      await EzManager.setBool(lightDisplayBoldedKey, false);
      await EzManager.setBool(lightDisplayItalicizedKey, false);
      await EzManager.setBool(lightDisplayUnderlinedKey, false);
      await EzManager.setDouble(lightDisplayFontHeightKey, 1.5);
      await EzManager.setDouble(lightDisplayLetterSpacingKey, 0.30);
      await EzManager.setDouble(lightDisplayWordSpacingKey, 1.25);

      // Headline
      await EzManager.setString(lightHeadlineFontFamilyKey, atkinsonHyperlegible);
      await EzManager.setDouble(lightHeadlineFontSizeKey, 38);
      await EzManager.setBool(lightHeadlineBoldedKey, false);
      await EzManager.setBool(lightHeadlineItalicizedKey, false);
      await EzManager.setBool(lightHeadlineUnderlinedKey, false);
      await EzManager.setDouble(lightHeadlineFontHeightKey, 1.625);
      await EzManager.setDouble(lightHeadlineLetterSpacingKey, 0.30);
      await EzManager.setDouble(lightHeadlineWordSpacingKey, 1.25);

      // Title
      await EzManager.setString(lightTitleFontFamilyKey, atkinsonHyperlegible);
      await EzManager.setDouble(lightTitleFontSizeKey, 26);
      await EzManager.setBool(lightTitleBoldedKey, false);
      await EzManager.setBool(lightTitleItalicizedKey, false);
      await EzManager.setBool(lightTitleUnderlinedKey, true);
      await EzManager.setDouble(lightTitleFontHeightKey, 1.75);
      await EzManager.setDouble(lightTitleLetterSpacingKey, 0.30);
      await EzManager.setDouble(lightTitleWordSpacingKey, 1.25);

      // Body
      await EzManager.setString(lightBodyFontFamilyKey, atkinsonHyperlegible);
      await EzManager.setDouble(lightBodyFontSizeKey, 20);
      await EzManager.setBool(lightBodyBoldedKey, false);
      await EzManager.setBool(lightBodyItalicizedKey, false);
      await EzManager.setBool(lightBodyUnderlinedKey, false);
      await EzManager.setDouble(lightBodyFontHeightKey, 1.75);
      await EzManager.setDouble(lightBodyLetterSpacingKey, 0.30);
      await EzManager.setDouble(lightBodyWordSpacingKey, 1.25);

      // Label
      await EzManager.setString(lightLabelFontFamilyKey, atkinsonHyperlegible);
      await EzManager.setDouble(lightLabelFontSizeKey, 16);
      await EzManager.setBool(lightLabelBoldedKey, false);
      await EzManager.setBool(lightLabelItalicizedKey, false);
      await EzManager.setBool(lightLabelUnderlinedKey, false);
      await EzManager.setDouble(lightLabelFontHeightKey, 1.75);
      await EzManager.setDouble(lightLabelLetterSpacingKey, 0.30);
      await EzManager.setDouble(lightLabelWordSpacingKey, 1.25);

      // etc
      await EzManager.setDouble(lightIconSizeKey, 22.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle localBody = fuseWithGFont(
      starter: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        color: config.isDark ? Colors.white : Colors.black,
        height: 1.75,
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: 0.30,
        wordSpacing: 1.25,
      ),
      gFont: atkinsonHyperlegible,
    );

    return EzElevatedButton(
      config,
      style: config.isDark
          ? ElevatedButton.styleFrom(
              backgroundBuilder: ezSelfBuilder,
              backgroundColor: ywt.darkSurface,
              foregroundColor: Colors.white,
              overlayColor: Colors.white,
              padding: EdgeInsets.all(
                  EzManager.onMobile ? ywt.defaultMobilePadding : ywt.defaultDesktopPadding),
              shadowColor: Colors.transparent,
              shape: EzButtonShape.pill.shape,
              side: const BorderSide(color: ywt.fadedWhite, width: ywt.defaultBorderWidth),
              textStyle: localBody,
            )
          : ElevatedButton.styleFrom(
              backgroundBuilder: ezSelfBuilder,
              backgroundColor: ywt.lightSurface,
              foregroundColor: Colors.black,
              overlayColor: Colors.black,
              padding: EdgeInsets.all(
                  EzManager.onMobile ? ywt.defaultMobilePadding : ywt.defaultDesktopPadding),
              shadowColor: Colors.transparent,
              shape: EzButtonShape.pill.shape,
              side: const BorderSide(color: ywt.fadedBlack, width: ywt.defaultBorderWidth),
              textStyle: localBody,
            ),
      onPressed: () => config.rebuildUI(changes: () async {
        await onPressed(config, updateBoth);
        await extra?.call(updateBoth);
      }),
      text: config.ezL10n.ssHighVisibility,
      textStyle: localBody,
    );
  }
}
