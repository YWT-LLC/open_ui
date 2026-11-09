/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart';

const Map<String, double> fontSizeDefaults = <String, double>{
  darkDisplayFontSizeKey: defaultDisplaySize,
  lightDisplayFontSizeKey: defaultDisplaySize,
  darkHeadlineFontSizeKey: defaultHeadlineSize,
  lightHeadlineFontSizeKey: defaultHeadlineSize,
  darkTitleFontSizeKey: defaultTitleSize,
  lightTitleFontSizeKey: defaultTitleSize,
  darkBodyFontSizeKey: defaultBodySize,
  lightBodyFontSizeKey: defaultBodySize,
  darkLabelFontSizeKey: defaultLabelSize,
  lightLabelFontSizeKey: defaultLabelSize,
};

const Map<String, double> fontSizeMins = <String, double>{
  darkDisplayFontSizeKey: minDisplay,
  lightDisplayFontSizeKey: minDisplay,
  darkHeadlineFontSizeKey: minHeadline,
  lightHeadlineFontSizeKey: minHeadline,
  darkTitleFontSizeKey: minTitle,
  lightTitleFontSizeKey: minTitle,
  darkBodyFontSizeKey: minBody,
  lightBodyFontSizeKey: minBody,
  darkLabelFontSizeKey: minLabel,
  lightLabelFontSizeKey: minLabel,
};

const Map<String, double> fontSizeMaxes = <String, double>{
  darkDisplayFontSizeKey: maxDisplay,
  lightDisplayFontSizeKey: maxDisplay,
  darkHeadlineFontSizeKey: maxHeadline,
  lightHeadlineFontSizeKey: maxHeadline,
  darkTitleFontSizeKey: maxTitle,
  lightTitleFontSizeKey: maxTitle,
  darkBodyFontSizeKey: maxBody,
  lightBodyFontSizeKey: maxBody,
  darkLabelFontSizeKey: maxLabel,
  lightLabelFontSizeKey: maxLabel,
};

/// You do NOT have permission to use this config in your app
/// Reminder: YWT is trademarked
/// Don't make us regret our transparency :)
final Map<String, Object> baseYWTConfig = <String, Object>{
  // Global settings //

  isLeftyKey: false,
  hubPositionKey: 0,
  updateBothKey: false,

  // Color settings //

  advancedColorsKey: false,

  // Dark surface
  darkColorSchemeImageKey: noImageValue,
  darkSurfaceKey: darkSurfaceHex,
  darkSurfaceDimKey: darkSurfaceDimHex,
  darkSurfaceContainerKey: darkSurfaceContainerHex,
  darkOnSurfaceKey: whiteHex,

  // Dark big three
  darkPrimaryKey: ywtEucalyptusHex,
  darkOnPrimaryKey: blackHex,
  darkPrimaryContainerKey: ywtEucalyptusDimHex,
  darkOnPrimaryContainerKey: blackHex,

  darkSecondaryKey: ywtSandHex,
  darkOnSecondaryKey: blackHex,
  darkSecondaryContainerKey: ywtSandDimHex,
  darkOnSecondaryContainerKey: blackHex,

  darkTertiaryKey: ywtPurpleHex,
  darkOnTertiaryKey: whiteHex,
  darkTertiaryContainerKey: ywtPurpleDimHex,
  darkOnTertiaryContainerKey: whiteHex,

  // Dark misc
  darkErrorKey: redHex,
  darkOnErrorKey: whiteHex,
  darkErrorContainerKey: halfRedHex,
  darkOnErrorContainerKey: whiteHex,

  darkOutlineKey: fadedWhiteHex,
  darkOutlineVariantKey: dimWhiteHex,
  darkSurfaceTintKey: transparentHex,
  darkScrimKey: blackHex,

  // Light surface
  lightColorSchemeImageKey: noImageValue,
  lightSurfaceKey: lightSurfaceHex,
  lightSurfaceDimKey: lightSurfaceDimHex,
  lightSurfaceContainerKey: lightSurfaceContainerHex,
  lightOnSurfaceKey: blackHex,

  // Light big three
  lightPrimaryKey: ywtPurpleHex,
  lightOnPrimaryKey: whiteHex,
  lightPrimaryContainerKey: ywtPurpleDimHex,
  lightOnPrimaryContainerKey: whiteHex,

  lightSecondaryKey: ywtSandHex,
  lightOnSecondaryKey: blackHex,
  lightSecondaryContainerKey: ywtSandDimHex,
  lightOnSecondaryContainerKey: blackHex,

  lightTertiaryKey: ywtEucalyptusHex,
  lightOnTertiaryKey: blackHex,
  lightTertiaryContainerKey: ywtEucalyptusDimHex,
  lightOnTertiaryContainerKey: blackHex,

  // Light misc
  lightErrorKey: redHex,
  lightOnErrorKey: whiteHex,
  lightErrorContainerKey: halfRedHex,
  lightOnErrorContainerKey: whiteHex,

  lightOutlineKey: fadedBlackHex,
  lightOutlineVariantKey: dimBlackHex,
  lightSurfaceTintKey: transparentHex,
  lightScrimKey: whiteHex,

  // Design settings //

  pageTabKey: false,

  // Dark button
  darkButtonShapeKey: EzButtonShape.pill.value,
  darkBorderWidthKey: defaultBorderWidth,

  darkLineLinksKey: false,

  // Dark page
  darkBackgroundImageKey: noImageValue,

  darkAnimationDurationKey: defaultAnimationDuration,
  darkTransitionFadeKey: true,

  // Light button
  lightButtonShapeKey: EzButtonShape.pill.value,
  lightBorderWidthKey: defaultBorderWidth,

  lightLineLinksKey: false,

  // Light page
  lightBackgroundImageKey: noImageValue,

  lightAnimationDurationKey: defaultAnimationDuration,
  lightTransitionFadeKey: true,

  // Text settings //

  advancedTextKey: false,

  // Dark
  darkDisplayFontFamilyKey: roboto,
  darkDisplayFontSizeKey: defaultDisplaySize,
  darkDisplayBoldedKey: false,
  darkDisplayItalicizedKey: false,
  darkDisplayUnderlinedKey: false,
  darkDisplayFontHeightKey: defaultFontHeight,
  darkDisplayLetterSpacingKey: defaultLetterSpacing,
  darkDisplayWordSpacingKey: defaultWordSpacing,

  darkHeadlineFontFamilyKey: roboto,
  darkHeadlineFontSizeKey: defaultHeadlineSize,
  darkHeadlineBoldedKey: false,
  darkHeadlineItalicizedKey: false,
  darkHeadlineUnderlinedKey: false,
  darkHeadlineFontHeightKey: defaultFontHeight,
  darkHeadlineLetterSpacingKey: defaultLetterSpacing,
  darkHeadlineWordSpacingKey: defaultWordSpacing,

  darkTitleFontFamilyKey: roboto,
  darkTitleFontSizeKey: defaultTitleSize,
  darkTitleBoldedKey: true,
  darkTitleItalicizedKey: false,
  darkTitleUnderlinedKey: false,
  darkTitleFontHeightKey: defaultFontHeight,
  darkTitleLetterSpacingKey: defaultLetterSpacing,
  darkTitleWordSpacingKey: defaultWordSpacing,

  darkBodyFontFamilyKey: roboto,
  darkBodyFontSizeKey: defaultBodySize,
  darkBodyBoldedKey: false,
  darkBodyItalicizedKey: false,
  darkBodyUnderlinedKey: false,
  darkBodyFontHeightKey: defaultFontHeight,
  darkBodyLetterSpacingKey: defaultLetterSpacing,
  darkBodyWordSpacingKey: defaultWordSpacing,

  darkLabelFontFamilyKey: roboto,
  darkLabelFontSizeKey: defaultLabelSize,
  darkLabelBoldedKey: false,
  darkLabelItalicizedKey: false,
  darkLabelUnderlinedKey: false,
  darkLabelFontHeightKey: defaultFontHeight,
  darkLabelLetterSpacingKey: defaultLetterSpacing,
  darkLabelWordSpacingKey: defaultWordSpacing,

  darkTextBackgroundOpacityKey: defaultTextOpacity,
  darkIconSizeKey: defaultIconSize,

  // Light
  lightDisplayFontFamilyKey: roboto,
  lightDisplayFontSizeKey: defaultDisplaySize,
  lightDisplayBoldedKey: false,
  lightDisplayItalicizedKey: false,
  lightDisplayUnderlinedKey: false,
  lightDisplayFontHeightKey: defaultFontHeight,
  lightDisplayLetterSpacingKey: defaultLetterSpacing,
  lightDisplayWordSpacingKey: defaultWordSpacing,

  lightHeadlineFontFamilyKey: roboto,
  lightHeadlineFontSizeKey: defaultHeadlineSize,
  lightHeadlineBoldedKey: false,
  lightHeadlineItalicizedKey: false,
  lightHeadlineUnderlinedKey: false,
  lightHeadlineFontHeightKey: defaultFontHeight,
  lightHeadlineLetterSpacingKey: defaultLetterSpacing,
  lightHeadlineWordSpacingKey: defaultWordSpacing,

  lightTitleFontFamilyKey: roboto,
  lightTitleFontSizeKey: defaultTitleSize,
  lightTitleBoldedKey: true,
  lightTitleItalicizedKey: false,
  lightTitleUnderlinedKey: false,
  lightTitleFontHeightKey: defaultFontHeight,
  lightTitleLetterSpacingKey: defaultLetterSpacing,
  lightTitleWordSpacingKey: defaultWordSpacing,

  lightBodyFontFamilyKey: roboto,
  lightBodyFontSizeKey: defaultBodySize,
  lightBodyBoldedKey: false,
  lightBodyItalicizedKey: false,
  lightBodyUnderlinedKey: false,
  lightBodyFontHeightKey: defaultFontHeight,
  lightBodyLetterSpacingKey: defaultLetterSpacing,
  lightBodyWordSpacingKey: defaultWordSpacing,

  lightLabelFontFamilyKey: roboto,
  lightLabelFontSizeKey: defaultLabelSize,
  lightLabelBoldedKey: false,
  lightLabelItalicizedKey: false,
  lightLabelUnderlinedKey: false,
  lightLabelFontHeightKey: defaultFontHeight,
  lightLabelLetterSpacingKey: defaultLetterSpacing,
  lightLabelWordSpacingKey: defaultWordSpacing,

  lightTextBackgroundOpacityKey: defaultTextOpacity,
  lightIconSizeKey: defaultIconSize,
};

/// You do NOT have permission to use this config in your app
/// Reminder: YWT is trademarked
/// Don't make us regret our transparency :)
final Map<String, Object> ywtMobileConfig = <String, Object>{
  ...baseYWTConfig,

  // Design //

  // Dark button
  darkPaddingKey: defaultMobilePadding,

  darkShowBackFABKey: false,
  darkShowScrollKey: false,

  // Dark page
  darkMarginKey: defaultMobileMargin,
  darkSpacingKey: defaultMobileSpacing,

  // Light button
  lightPaddingKey: defaultMobilePadding,

  lightShowBackFABKey: false,
  lightShowScrollKey: false,

  // Light page
  lightMarginKey: defaultMobileMargin,
  lightSpacingKey: defaultMobileSpacing,
};

/// You do NOT have permission to use this config in your app
/// Reminder: YWT is trademarked
/// Don't make us regret our transparency :)
final Map<String, Object> ywtDesktopConfig = <String, Object>{
  ...baseYWTConfig,

  // Design //

  // Dark button
  darkPaddingKey: defaultDesktopPadding,

  darkShowBackFABKey: false,
  darkShowScrollKey: false,

  // Dark page
  darkMarginKey: defaultDesktopMargin,
  darkSpacingKey: defaultDesktopSpacing,

  // Light button
  lightPaddingKey: defaultDesktopPadding,

  lightShowBackFABKey: false,
  lightShowScrollKey: false,

  // Light page
  lightMarginKey: defaultDesktopMargin,
  lightSpacingKey: defaultDesktopSpacing,
};
