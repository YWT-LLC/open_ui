/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzHighVisibilityConfig extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Whether both themes should be updated
  final bool updateBoth;

  /// Optional extra changes
  final Future<void> Function(bool)? extra;

  /// Resets the current config and applies the [ezHighContrastLight] | [ezHighContrastDark] color scheme
  /// With text theme built with [atkinsonHyperlegible] and is slightly larger than the default
  /// Spacing is also increased, but not as much as [EzBigButtonsConfig]
  const EzHighVisibilityConfig(this.config, {super.key, required this.updateBoth, this.extra});

  static Future<void> onPressed(EzCP config, bool updateBoth, {bool monoChrome = false}) async {
    if (updateBoth || config.isDark) {
      // Reset //

      await EzCM.removeKeys(darkColorKeys.keys.toSet());
      await EzCM.removeKeys(darkDesignKeys.keys.toSet());
      await EzCM.removeKeys(darkTextKeys.keys.toSet());

      // Default global settings //

      // Color settings //

      await loadColorScheme(monoChrome ? ezMonoChromeDark : ezHighContrastDark, Brightness.dark);

      // Design settings //

      // Default padding

      // Default button shape && border width

      await EzCM.setBool(darkLineLinksKey, true);
      await EzCM.setBool(darkShowBackFABKey, false);

      // Default margin
      await EzCM.setDouble(darkSpacingKey, EzCM.onMobile ? 27.5 : 33.0);

      // Default anim duration and page fade
      await EzCM.setString(darkTransitionTypeKey, EzTransitionType.system.value);
      await EzCM.setBool(darkTransitionFadeKey, false);

      await EzCM.setBool(darkShowScrollKey, false);

      // Text settings //

      // Display
      await EzCM.setString(darkDisplayFontFamilyKey, atkinsonHyperlegible);
      await EzCM.setDouble(darkDisplayFontSizeKey, 50);
      await EzCM.setBool(darkDisplayBoldedKey, false);
      await EzCM.setBool(darkDisplayItalicizedKey, false);
      await EzCM.setBool(darkDisplayUnderlinedKey, false);
      await EzCM.setDouble(darkDisplayFontHeightKey, 1.5);
      await EzCM.setDouble(darkDisplayLetterSpacingKey, 0.30);
      await EzCM.setDouble(darkDisplayWordSpacingKey, 1.25);

      // Headline
      await EzCM.setString(darkHeadlineFontFamilyKey, atkinsonHyperlegible);
      await EzCM.setDouble(darkHeadlineFontSizeKey, 38);
      await EzCM.setBool(darkHeadlineBoldedKey, false);
      await EzCM.setBool(darkHeadlineItalicizedKey, false);
      await EzCM.setBool(darkHeadlineUnderlinedKey, false);
      await EzCM.setDouble(darkHeadlineFontHeightKey, 1.625);
      await EzCM.setDouble(darkHeadlineLetterSpacingKey, 0.30);
      await EzCM.setDouble(darkHeadlineWordSpacingKey, 1.25);

      // Title
      await EzCM.setString(darkTitleFontFamilyKey, atkinsonHyperlegible);
      await EzCM.setDouble(darkTitleFontSizeKey, 26);
      await EzCM.setBool(darkTitleBoldedKey, false);
      await EzCM.setBool(darkTitleItalicizedKey, false);
      await EzCM.setBool(darkTitleUnderlinedKey, true);
      await EzCM.setDouble(darkTitleFontHeightKey, 1.75);
      await EzCM.setDouble(darkTitleLetterSpacingKey, 0.30);
      await EzCM.setDouble(darkTitleWordSpacingKey, 1.25);

      // Body
      await EzCM.setString(darkBodyFontFamilyKey, atkinsonHyperlegible);
      await EzCM.setDouble(darkBodyFontSizeKey, 20);
      await EzCM.setBool(darkBodyBoldedKey, false);
      await EzCM.setBool(darkBodyItalicizedKey, false);
      await EzCM.setBool(darkBodyUnderlinedKey, false);
      await EzCM.setDouble(darkBodyFontHeightKey, 1.75);
      await EzCM.setDouble(darkBodyLetterSpacingKey, 0.30);
      await EzCM.setDouble(darkBodyWordSpacingKey, 1.25);

      // Label
      await EzCM.setString(darkLabelFontFamilyKey, atkinsonHyperlegible);
      await EzCM.setDouble(darkLabelFontSizeKey, 16);
      await EzCM.setBool(darkLabelBoldedKey, false);
      await EzCM.setBool(darkLabelItalicizedKey, false);
      await EzCM.setBool(darkLabelUnderlinedKey, false);
      await EzCM.setDouble(darkLabelFontHeightKey, 1.75);
      await EzCM.setDouble(darkLabelLetterSpacingKey, 0.30);
      await EzCM.setDouble(darkLabelWordSpacingKey, 1.25);

      // etc
      // Default text backgrounds
      await EzCM.setDouble(darkIconSizeKey, 22.0);
    }

    if (updateBoth || !config.isDark) {
      // Reset //

      await EzCM.removeKeys(lightColorKeys.keys.toSet());
      await EzCM.removeKeys(lightDesignKeys.keys.toSet());
      await EzCM.removeKeys(lightTextKeys.keys.toSet());

      // Default global settings //

      // Color settings //

      await loadColorScheme(monoChrome ? ezMonoChromeLight : ezHighContrastLight, Brightness.light);

      // Design settings //

      // Default padding

      // Default button shape && border width

      await EzCM.setBool(lightLineLinksKey, true);
      await EzCM.setBool(lightShowBackFABKey, false);

      // Default margin
      await EzCM.setDouble(lightSpacingKey, EzCM.onMobile ? 27.5 : 33.0);

      // Default anim duration and page fade
      await EzCM.setString(lightTransitionTypeKey, EzTransitionType.system.value);
      await EzCM.setBool(lightTransitionFadeKey, false);

      await EzCM.setBool(lightShowScrollKey, false);

      // Text settings //

      // Display
      await EzCM.setString(lightDisplayFontFamilyKey, atkinsonHyperlegible);
      await EzCM.setDouble(lightDisplayFontSizeKey, 50);
      await EzCM.setBool(lightDisplayBoldedKey, false);
      await EzCM.setBool(lightDisplayItalicizedKey, false);
      await EzCM.setBool(lightDisplayUnderlinedKey, false);
      await EzCM.setDouble(lightDisplayFontHeightKey, 1.5);
      await EzCM.setDouble(lightDisplayLetterSpacingKey, 0.30);
      await EzCM.setDouble(lightDisplayWordSpacingKey, 1.25);

      // Headline
      await EzCM.setString(lightHeadlineFontFamilyKey, atkinsonHyperlegible);
      await EzCM.setDouble(lightHeadlineFontSizeKey, 38);
      await EzCM.setBool(lightHeadlineBoldedKey, false);
      await EzCM.setBool(lightHeadlineItalicizedKey, false);
      await EzCM.setBool(lightHeadlineUnderlinedKey, false);
      await EzCM.setDouble(lightHeadlineFontHeightKey, 1.625);
      await EzCM.setDouble(lightHeadlineLetterSpacingKey, 0.30);
      await EzCM.setDouble(lightHeadlineWordSpacingKey, 1.25);

      // Title
      await EzCM.setString(lightTitleFontFamilyKey, atkinsonHyperlegible);
      await EzCM.setDouble(lightTitleFontSizeKey, 26);
      await EzCM.setBool(lightTitleBoldedKey, false);
      await EzCM.setBool(lightTitleItalicizedKey, false);
      await EzCM.setBool(lightTitleUnderlinedKey, true);
      await EzCM.setDouble(lightTitleFontHeightKey, 1.75);
      await EzCM.setDouble(lightTitleLetterSpacingKey, 0.30);
      await EzCM.setDouble(lightTitleWordSpacingKey, 1.25);

      // Body
      await EzCM.setString(lightBodyFontFamilyKey, atkinsonHyperlegible);
      await EzCM.setDouble(lightBodyFontSizeKey, 20);
      await EzCM.setBool(lightBodyBoldedKey, false);
      await EzCM.setBool(lightBodyItalicizedKey, false);
      await EzCM.setBool(lightBodyUnderlinedKey, false);
      await EzCM.setDouble(lightBodyFontHeightKey, 1.75);
      await EzCM.setDouble(lightBodyLetterSpacingKey, 0.30);
      await EzCM.setDouble(lightBodyWordSpacingKey, 1.25);

      // Label
      await EzCM.setString(lightLabelFontFamilyKey, atkinsonHyperlegible);
      await EzCM.setDouble(lightLabelFontSizeKey, 16);
      await EzCM.setBool(lightLabelBoldedKey, false);
      await EzCM.setBool(lightLabelItalicizedKey, false);
      await EzCM.setBool(lightLabelUnderlinedKey, false);
      await EzCM.setDouble(lightLabelFontHeightKey, 1.75);
      await EzCM.setDouble(lightLabelLetterSpacingKey, 0.30);
      await EzCM.setDouble(lightLabelWordSpacingKey, 1.25);

      // etc
      // Default text backgrounds
      await EzCM.setDouble(lightIconSizeKey, 22.0);
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
              backgroundColor: darkSurface,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              overlayColor: Colors.white,
              side: const BorderSide(color: halfWhite, width: defaultBorderWidth),
              shape: EzButtonShape.pill.shape,
              textStyle: localBody,
              padding: EdgeInsets.all(EzCM.onMobile ? defaultMobilePadding : defaultDesktopPadding),
            )
          : ElevatedButton.styleFrom(
              backgroundColor: lightSurface,
              foregroundColor: Colors.black,
              shadowColor: Colors.transparent,
              overlayColor: Colors.black,
              side: const BorderSide(color: halfBlack, width: defaultBorderWidth),
              shape: EzButtonShape.pill.shape,
              textStyle: localBody,
              padding: EdgeInsets.all(EzCM.onMobile ? defaultMobilePadding : defaultDesktopPadding),
            ),
      onPressed: () => config.rebuildUI(
        allECT,
        changes: () async {
          await onPressed(config, updateBoth);
          await extra?.call(updateBoth);
        },
      ),
      text: config.ezL10n.ssHighVisibility,
      textStyle: localBody,
    );
  }
}
