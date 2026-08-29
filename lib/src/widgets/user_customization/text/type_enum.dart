/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';

/// Enumerator for selecting which [TextStyle] is being updated
enum EzTextSettingType { display, headline, title, body, label }

extension EzTSTConfig on EzTextSettingType {
  String title(OUILang l10n) => switch (this) {
        EzTextSettingType.display => l10n.tsDisplay,
        EzTextSettingType.headline => l10n.tsHeadline,
        EzTextSettingType.title => l10n.tsTitle,
        EzTextSettingType.body => l10n.tsBody,
        EzTextSettingType.label => l10n.tsLabel,
      };

  String label(OUILang l10n) => title(l10n).toLowerCase();

  // Bold/weight //

  String boldKey(bool isDark) => switch (this) {
        EzTextSettingType.display => isDark ? darkDisplayBoldedKey : lightDisplayBoldedKey,
        EzTextSettingType.headline => isDark ? darkHeadlineBoldedKey : lightHeadlineBoldedKey,
        EzTextSettingType.title => isDark ? darkTitleBoldedKey : lightTitleBoldedKey,
        EzTextSettingType.body => isDark ? darkBodyBoldedKey : lightBodyBoldedKey,
        EzTextSettingType.label => isDark ? darkLabelBoldedKey : lightLabelBoldedKey,
      };

  String boldMirror(bool isDark) => switch (this) {
        EzTextSettingType.display => isDark ? lightDisplayBoldedKey : darkDisplayBoldedKey,
        EzTextSettingType.headline => isDark ? lightHeadlineBoldedKey : darkHeadlineBoldedKey,
        EzTextSettingType.title => isDark ? lightTitleBoldedKey : darkTitleBoldedKey,
        EzTextSettingType.body => isDark ? lightBodyBoldedKey : darkBodyBoldedKey,
        EzTextSettingType.label => isDark ? lightLabelBoldedKey : darkLabelBoldedKey,
      };

  // Font family //

  String fontKey(bool isDark) => switch (this) {
        EzTextSettingType.display => isDark ? darkDisplayFontFamilyKey : lightDisplayFontFamilyKey,
        EzTextSettingType.headline =>
          isDark ? darkHeadlineFontFamilyKey : lightHeadlineFontFamilyKey,
        EzTextSettingType.title => isDark ? darkTitleFontFamilyKey : lightTitleFontFamilyKey,
        EzTextSettingType.body => isDark ? darkBodyFontFamilyKey : lightBodyFontFamilyKey,
        EzTextSettingType.label => isDark ? darkLabelFontFamilyKey : lightLabelFontFamilyKey,
      };

  String fontMirror(bool isDark) => switch (this) {
        EzTextSettingType.display => isDark ? lightDisplayFontFamilyKey : darkDisplayFontFamilyKey,
        EzTextSettingType.headline =>
          isDark ? lightHeadlineFontFamilyKey : darkHeadlineFontFamilyKey,
        EzTextSettingType.title => isDark ? lightTitleFontFamilyKey : darkTitleFontFamilyKey,
        EzTextSettingType.body => isDark ? lightBodyFontFamilyKey : darkBodyFontFamilyKey,
        EzTextSettingType.label => isDark ? lightLabelFontFamilyKey : darkLabelFontFamilyKey,
      };

  // Italic/style //

  String italicKey(bool isDark) => switch (this) {
        EzTextSettingType.display => isDark ? darkDisplayItalicizedKey : lightDisplayItalicizedKey,
        EzTextSettingType.headline =>
          isDark ? darkHeadlineItalicizedKey : lightHeadlineItalicizedKey,
        EzTextSettingType.title => isDark ? darkTitleItalicizedKey : lightTitleItalicizedKey,
        EzTextSettingType.body => isDark ? darkBodyItalicizedKey : lightBodyItalicizedKey,
        EzTextSettingType.label => isDark ? darkLabelItalicizedKey : lightLabelItalicizedKey,
      };

  String italicMirror(bool isDark) => switch (this) {
        EzTextSettingType.display => isDark ? lightDisplayItalicizedKey : darkDisplayItalicizedKey,
        EzTextSettingType.headline =>
          isDark ? lightHeadlineItalicizedKey : darkHeadlineItalicizedKey,
        EzTextSettingType.title => isDark ? lightTitleItalicizedKey : darkTitleItalicizedKey,
        EzTextSettingType.body => isDark ? lightBodyItalicizedKey : darkBodyItalicizedKey,
        EzTextSettingType.label => isDark ? lightLabelItalicizedKey : darkLabelItalicizedKey,
      };

  // Underline/decoration //

  String underlineKey(bool isDark) => switch (this) {
        EzTextSettingType.display => isDark ? darkDisplayUnderlinedKey : lightDisplayUnderlinedKey,
        EzTextSettingType.headline =>
          isDark ? darkHeadlineUnderlinedKey : lightHeadlineUnderlinedKey,
        EzTextSettingType.title => isDark ? darkTitleUnderlinedKey : lightTitleUnderlinedKey,
        EzTextSettingType.body => isDark ? darkBodyUnderlinedKey : lightBodyUnderlinedKey,
        EzTextSettingType.label => isDark ? darkLabelUnderlinedKey : lightLabelUnderlinedKey,
      };

  String underlineMirror(bool isDark) => switch (this) {
        EzTextSettingType.display => isDark ? lightDisplayUnderlinedKey : darkDisplayUnderlinedKey,
        EzTextSettingType.headline =>
          isDark ? lightHeadlineUnderlinedKey : darkHeadlineUnderlinedKey,
        EzTextSettingType.title => isDark ? lightTitleUnderlinedKey : darkTitleUnderlinedKey,
        EzTextSettingType.body => isDark ? lightBodyUnderlinedKey : darkBodyUnderlinedKey,
        EzTextSettingType.label => isDark ? lightLabelUnderlinedKey : darkLabelUnderlinedKey,
      };
}
