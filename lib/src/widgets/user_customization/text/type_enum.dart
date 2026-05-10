/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Enumerator for selecting which [TextStyle] is being updated
enum EzTextSettingType { display, headline, title, body, label }

extension EzTSTConfig on EzTextSettingType {
  String get title => switch (this) {
        EzTextSettingType.display => EzConfig.l10n.tsDisplay,
        EzTextSettingType.headline => EzConfig.l10n.tsHeadline,
        EzTextSettingType.title => EzConfig.l10n.tsTitle,
        EzTextSettingType.body => EzConfig.l10n.tsBody,
        EzTextSettingType.label => EzConfig.l10n.tsLabel,
      };

  String get label => title.toLowerCase();

  // Bold/weight //

  String get boldKey => switch (this) {
        EzTextSettingType.display => EzConfig.isDark ? darkDisplayBoldedKey : lightDisplayBoldedKey,
        EzTextSettingType.headline =>
          EzConfig.isDark ? darkHeadlineBoldedKey : lightHeadlineBoldedKey,
        EzTextSettingType.title => EzConfig.isDark ? darkTitleBoldedKey : lightTitleBoldedKey,
        EzTextSettingType.body => EzConfig.isDark ? darkBodyBoldedKey : lightBodyBoldedKey,
        EzTextSettingType.label => EzConfig.isDark ? darkLabelBoldedKey : lightLabelBoldedKey,
      };

  String get boldMirror => switch (this) {
        EzTextSettingType.display => EzConfig.isDark ? lightDisplayBoldedKey : darkDisplayBoldedKey,
        EzTextSettingType.headline =>
          EzConfig.isDark ? lightHeadlineBoldedKey : darkHeadlineBoldedKey,
        EzTextSettingType.title => EzConfig.isDark ? lightTitleBoldedKey : darkTitleBoldedKey,
        EzTextSettingType.body => EzConfig.isDark ? lightBodyBoldedKey : darkBodyBoldedKey,
        EzTextSettingType.label => EzConfig.isDark ? lightLabelBoldedKey : darkLabelBoldedKey,
      };

  // Font family //

  String get fontKey => switch (this) {
        EzTextSettingType.display =>
          EzConfig.isDark ? darkDisplayFontFamilyKey : lightDisplayFontFamilyKey,
        EzTextSettingType.headline =>
          EzConfig.isDark ? darkHeadlineFontFamilyKey : lightHeadlineFontFamilyKey,
        EzTextSettingType.title =>
          EzConfig.isDark ? darkTitleFontFamilyKey : lightTitleFontFamilyKey,
        EzTextSettingType.body => EzConfig.isDark ? darkBodyFontFamilyKey : lightBodyFontFamilyKey,
        EzTextSettingType.label =>
          EzConfig.isDark ? darkLabelFontFamilyKey : lightLabelFontFamilyKey,
      };

  String get fontMirror => switch (this) {
        EzTextSettingType.display =>
          EzConfig.isDark ? lightDisplayFontFamilyKey : darkDisplayFontFamilyKey,
        EzTextSettingType.headline =>
          EzConfig.isDark ? lightHeadlineFontFamilyKey : darkHeadlineFontFamilyKey,
        EzTextSettingType.title =>
          EzConfig.isDark ? lightTitleFontFamilyKey : darkTitleFontFamilyKey,
        EzTextSettingType.body => EzConfig.isDark ? lightBodyFontFamilyKey : darkBodyFontFamilyKey,
        EzTextSettingType.label =>
          EzConfig.isDark ? lightLabelFontFamilyKey : darkLabelFontFamilyKey,
      };

  // Italic/style //

  String get italicKey => switch (this) {
        EzTextSettingType.display =>
          EzConfig.isDark ? darkDisplayItalicizedKey : lightDisplayItalicizedKey,
        EzTextSettingType.headline =>
          EzConfig.isDark ? darkHeadlineItalicizedKey : lightHeadlineItalicizedKey,
        EzTextSettingType.title =>
          EzConfig.isDark ? darkTitleItalicizedKey : lightTitleItalicizedKey,
        EzTextSettingType.body => EzConfig.isDark ? darkBodyItalicizedKey : lightBodyItalicizedKey,
        EzTextSettingType.label =>
          EzConfig.isDark ? darkLabelItalicizedKey : lightLabelItalicizedKey,
      };

  String get italicMirror => switch (this) {
        EzTextSettingType.display =>
          EzConfig.isDark ? lightDisplayItalicizedKey : darkDisplayItalicizedKey,
        EzTextSettingType.headline =>
          EzConfig.isDark ? lightHeadlineItalicizedKey : darkHeadlineItalicizedKey,
        EzTextSettingType.title =>
          EzConfig.isDark ? lightTitleItalicizedKey : darkTitleItalicizedKey,
        EzTextSettingType.body => EzConfig.isDark ? lightBodyItalicizedKey : darkBodyItalicizedKey,
        EzTextSettingType.label =>
          EzConfig.isDark ? lightLabelItalicizedKey : darkLabelItalicizedKey,
      };

  // Underline/decoration //

  String get underlineKey => switch (this) {
        EzTextSettingType.display =>
          EzConfig.isDark ? darkDisplayUnderlinedKey : lightDisplayUnderlinedKey,
        EzTextSettingType.headline =>
          EzConfig.isDark ? darkHeadlineUnderlinedKey : lightHeadlineUnderlinedKey,
        EzTextSettingType.title =>
          EzConfig.isDark ? darkTitleUnderlinedKey : lightTitleUnderlinedKey,
        EzTextSettingType.body => EzConfig.isDark ? darkBodyUnderlinedKey : lightBodyUnderlinedKey,
        EzTextSettingType.label =>
          EzConfig.isDark ? darkLabelUnderlinedKey : lightLabelUnderlinedKey,
      };

  String get underlineMirror => switch (this) {
        EzTextSettingType.display =>
          EzConfig.isDark ? lightDisplayUnderlinedKey : darkDisplayUnderlinedKey,
        EzTextSettingType.headline =>
          EzConfig.isDark ? lightHeadlineUnderlinedKey : darkHeadlineUnderlinedKey,
        EzTextSettingType.title =>
          EzConfig.isDark ? lightTitleUnderlinedKey : darkTitleUnderlinedKey,
        EzTextSettingType.body => EzConfig.isDark ? lightBodyUnderlinedKey : darkBodyUnderlinedKey,
        EzTextSettingType.label =>
          EzConfig.isDark ? lightLabelUnderlinedKey : darkLabelUnderlinedKey,
      };
}
