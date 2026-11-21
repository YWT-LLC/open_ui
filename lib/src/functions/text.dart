/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:material_ui/material_ui.dart';

// Helpers //

/// 404 [OUILang.gError]
String ez404() => ezRootIsMounted
    ? '404 ${Provider.of<EzProvider>(ezRootContext, listen: false).ezL10n.gError}'
    : '404';

/// Custom '==' for two [TextStyle]s
bool ezFitCheck(TextStyle? a, TextStyle? b) {
  if (a == null && b == null) return true;
  if ((a == null) != (b == null)) return false;

  return a!.fontFamily == b!.fontFamily &&
      a.fontSize == b.fontSize &&
      a.fontWeight == b.fontWeight &&
      a.fontStyle == b.fontStyle &&
      a.decoration == b.decoration &&
      // Allow one color to be null, standard check when both are present
      (((a.color == null) != (b.color == null)) || a.color == b.color) &&
      a.letterSpacing == b.letterSpacing &&
      a.wordSpacing == b.wordSpacing &&
      a.height == b.height;
}

/// Only call in [EzTextSettings] context
/// Or another [context] where the [EzTextStyleProvider]s are in present
bool ezTextRebuildCheck(EzProvider config, {required BuildContext context}) {
  return !(ezFitCheck(
        config.displayStyle,
        Provider.of<EzDisplayStyleProvider>(context, listen: false).value,
      ) &&
      ezFitCheck(
        config.headlineStyle,
        Provider.of<EzHeadlineStyleProvider>(context, listen: false).value,
      ) &&
      ezFitCheck(
        config.titleStyle,
        Provider.of<EzTitleStyleProvider>(context, listen: false).value,
      ) &&
      ezFitCheck(
        config.bodyStyle,
        Provider.of<EzBodyStyleProvider>(context, listen: false).value,
      ) &&
      ezFitCheck(
        config.labelStyle,
        Provider.of<EzLabelStyleProvider>(context, listen: false).value,
      ));
}

/// Returns the soon-to-be rendered [Size] of [text] via a [TextPainter]
Size ezTextSize(
  EzProvider config, {
  required String text,
  required TextStyle? style,
  required TextScaler textScaler,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textScaler: textScaler,
    textDirection: config.isLTR ? TextDirection.ltr : TextDirection.rtl,
  )..layout();

  return textPainter.size;
}

/// [SystemChrome.setApplicationSwitcherDescription] wrapper
/// Sets the title of the tab on web and the title of the window on desktop
void ezWindowNamer(String title) => SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: title,
        primaryColor: ezRootIsMounted
            ? Provider.of<EzProvider>(ezRootContext, listen: false).primaryFill.asColor.toARGB32()
            : ywt.ywtPurpleHex,
      ),
    );

/// Returns whether the passed [text] follows a URL pattern
bool ezUrlCheck(String text) => Uri.parse(text).host.isNotEmpty;

/// Splits the string on '_' and/or ' ' and returns the first word
String ezFirstWord(String text) => text.split(RegExp(r'[_\s]+')).first;

// Converters //

/// snake_case -> camelCase
String ezSnakeToCamel(String name) =>
    name.replaceAllMapped(RegExp(r'_(\w)'), (Match match) => match.group(1)!.toUpperCase());

// snake_case -> ClassCase
String ezSnakeToClass(String name) =>
    ezSnakeToCamel(name).replaceRange(0, 1, name[0].toUpperCase());

/// snake_case -> Title Case
String ezSnakeToTitle(String name) => name
    .replaceAllMapped(RegExp(r'_(\w)'), (Match match) => ' ${match.group(1)!.toUpperCase()}')
    .replaceRange(0, 1, name[0].toUpperCase());

/// camelCase -> snake_case
String ezCamelToSnake(String name) =>
    name.replaceAllMapped(RegExp(r'[A-Z]'), (Match match) => '_${match.group(0)!.toLowerCase()}');

/// camelCase -> ClassCase
String ezCamelToClass(String name) => name.replaceRange(0, 1, name[0].toUpperCase());

/// camelCase -> Title Case
String ezCamelToTitle(String name) => name
    .replaceAllMapped(RegExp(r'[A-Z]'), (Match match) => ' ${match.group(0)!}')
    .replaceRange(0, 1, name[0].toUpperCase());

/// ClassCase -> snake_case
String ezClassToSnake(String name) => name
    .replaceRange(0, 1, name[0].toLowerCase())
    .replaceAllMapped(RegExp(r'[A-Z]'), (Match match) => '_${match.group(0)!.toLowerCase()}');

/// ClassCase -> camelCase
String ezClassToCamel(String name) => name.replaceRange(0, 1, name[0].toLowerCase());

/// ClassCase -> Title Case
String ezClassToTitle(String name) =>
    name.replaceAllMapped(RegExp(r'[A-Z]'), (Match match) => ' ${match.group(0)!}').trim();

/// Title Case -> snake_case
String ezTitleToSnake(String name) => name
    .replaceAllMapped(RegExp(r'\s(\w)'), (Match match) => '_${match.group(1)!.toLowerCase()}')
    .replaceRange(0, 1, name[0].toLowerCase());

/// Title Case -> camelCase
String ezTitleToCamel(String name) =>
    ezTitleToClass(name).replaceRange(0, 1, name[0].toLowerCase());

/// Title Case -> ClassCase
String ezTitleToClass(String name) => name.replaceAll(RegExp(r'\s'), '');

// Setters //

/// Creates a [TextTheme] with sizes inspired by...
/// https://m3.material.io/styles/typography/type-scale-tokens
/// Each variant triplet (large, medium, small) are identical
/// 15 different options would be overload for users... 5 makes much more sense
TextTheme ezTextTheme(Color? color, {required bool isDark}) {
  final TextStyle display = ezDisplayStyle(color, isDark: isDark);
  final TextStyle headline = ezHeadlineStyle(color, isDark: isDark);
  final TextStyle title = ezTitleStyle(color, isDark: isDark);
  final TextStyle body = ezBodyStyle(color, isDark: isDark);
  final TextStyle label = ezLabelStyle(color, isDark: isDark);

  return TextTheme(
    displayLarge: display,
    displayMedium: display,
    displaySmall: display,
    headlineLarge: headline,
    headlineMedium: headline,
    headlineSmall: headline,
    titleLarge: title,
    titleMedium: title,
    titleSmall: title,
    bodyLarge: body,
    bodyMedium: body,
    bodySmall: body,
    labelLarge: label,
    labelMedium: label,
    labelSmall: label,
  );
}

/// Builds [TextTheme.displayLarge] w/ values from [EzProvider]
TextStyle ezDisplayStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzManager.get(darkDisplayFontSizeKey),
          fontWeight:
              EzManager.get(darkDisplayBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzManager.get(darkDisplayItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzManager.get(darkDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.get(darkDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.get(darkDisplayLetterSpacingKey),
          wordSpacing: EzManager.get(darkDisplayWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzManager.get(lightDisplayFontSizeKey),
          fontWeight:
              EzManager.get(lightDisplayBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzManager.get(lightDisplayItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.get(lightDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.get(lightDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.get(lightDisplayLetterSpacingKey),
          wordSpacing: EzManager.get(lightDisplayWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzManager.get(useDark ? darkDisplayFontFamilyKey : lightDisplayFontFamilyKey),
  );
}

/// Builds [TextTheme.displayLarge] w/ values from [EzProvider]
TextStyle ezDefaultDisplayStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzManager.getDefault(darkDisplayFontSizeKey),
          fontWeight: EzManager.getDefault(darkDisplayBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzManager.getDefault(darkDisplayItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.getDefault(darkDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.getDefault(darkDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.getDefault(darkDisplayLetterSpacingKey),
          wordSpacing: EzManager.getDefault(darkDisplayWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzManager.getDefault(lightDisplayFontSizeKey),
          fontWeight: EzManager.getDefault(lightDisplayBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzManager.getDefault(lightDisplayItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.getDefault(lightDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.getDefault(lightDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.getDefault(lightDisplayLetterSpacingKey),
          wordSpacing: EzManager.getDefault(lightDisplayWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzManager.getDefault(useDark ? darkDisplayFontFamilyKey : lightDisplayFontFamilyKey),
  );
}

/// Builds [TextTheme.headlineLarge] w/ values from [EzProvider]
TextStyle ezHeadlineStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzManager.get(darkHeadlineFontSizeKey),
          fontWeight:
              EzManager.get(darkHeadlineBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzManager.get(darkHeadlineItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.get(darkHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.get(darkHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.get(darkHeadlineLetterSpacingKey),
          wordSpacing: EzManager.get(darkHeadlineWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzManager.get(lightHeadlineFontSizeKey),
          fontWeight:
              EzManager.get(lightHeadlineBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzManager.get(lightHeadlineItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.get(lightHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.get(lightHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.get(lightHeadlineLetterSpacingKey),
          wordSpacing: EzManager.get(lightHeadlineWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzManager.get(useDark ? darkHeadlineFontFamilyKey : lightHeadlineFontFamilyKey),
  );
}

/// Builds [TextTheme.headlineLarge] w/ values from [EzConfig.defaults]
TextStyle ezDefaultHeadlineStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzManager.getDefault(darkHeadlineFontSizeKey),
          fontWeight: EzManager.getDefault(darkHeadlineBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzManager.getDefault(darkHeadlineItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.getDefault(darkHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.getDefault(darkHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.getDefault(darkHeadlineLetterSpacingKey),
          wordSpacing: EzManager.getDefault(darkHeadlineWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzManager.getDefault(lightHeadlineFontSizeKey),
          fontWeight: EzManager.getDefault(lightHeadlineBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzManager.getDefault(lightHeadlineItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.getDefault(lightHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.getDefault(lightHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.getDefault(lightHeadlineLetterSpacingKey),
          wordSpacing: EzManager.getDefault(lightHeadlineWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzManager.getDefault(useDark ? darkHeadlineFontFamilyKey : lightHeadlineFontFamilyKey),
  );
}

/// Builds [TextTheme.titleLarge] w/ values from [EzProvider]
TextStyle ezTitleStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzManager.get(darkTitleFontSizeKey),
          fontWeight:
              EzManager.get(darkTitleBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzManager.get(darkTitleItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzManager.get(darkTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.get(darkTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.get(darkTitleLetterSpacingKey),
          wordSpacing: EzManager.get(darkTitleWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzManager.get(lightTitleFontSizeKey),
          fontWeight:
              EzManager.get(lightTitleBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzManager.get(lightTitleItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzManager.get(lightTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.get(lightTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.get(lightTitleLetterSpacingKey),
          wordSpacing: EzManager.get(lightTitleWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzManager.get(useDark ? darkTitleFontFamilyKey : lightTitleFontFamilyKey),
  );
}

/// Builds [TextTheme.titleLarge] w/ values from [EzConfig.defaults]
TextStyle ezDefaultTitleStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzManager.getDefault(darkTitleFontSizeKey),
          fontWeight: EzManager.getDefault(darkTitleBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzManager.getDefault(darkTitleItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.getDefault(darkTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.getDefault(darkTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.getDefault(darkTitleLetterSpacingKey),
          wordSpacing: EzManager.getDefault(darkTitleWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzManager.getDefault(lightTitleFontSizeKey),
          fontWeight: EzManager.getDefault(lightTitleBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzManager.getDefault(lightTitleItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.getDefault(lightTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.getDefault(lightTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.getDefault(lightTitleLetterSpacingKey),
          wordSpacing: EzManager.getDefault(lightTitleWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzManager.getDefault(useDark ? darkTitleFontFamilyKey : lightTitleFontFamilyKey),
  );
}

/// Builds [TextTheme.bodyLarge] w/ values from [EzProvider]
TextStyle ezBodyStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzManager.get(darkBodyFontSizeKey),
          fontWeight:
              EzManager.get(darkBodyBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzManager.get(darkBodyItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzManager.get(darkBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.get(darkBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.get(darkBodyLetterSpacingKey),
          wordSpacing: EzManager.get(darkBodyWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzManager.get(lightBodyFontSizeKey),
          fontWeight:
              EzManager.get(lightBodyBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzManager.get(lightBodyItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzManager.get(lightBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.get(lightBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.get(lightBodyLetterSpacingKey),
          wordSpacing: EzManager.get(lightBodyWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzManager.get(useDark ? darkBodyFontFamilyKey : lightBodyFontFamilyKey),
  );
}

/// Builds [TextTheme.bodyLarge] w/ values from [EzConfig.defaults]
TextStyle ezDefaultBodyStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzManager.getDefault(darkBodyFontSizeKey),
          fontWeight:
              EzManager.getDefault(darkBodyBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzManager.getDefault(darkBodyItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.getDefault(darkBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.getDefault(darkBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.getDefault(darkBodyLetterSpacingKey),
          wordSpacing: EzManager.getDefault(darkBodyWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzManager.getDefault(lightBodyFontSizeKey),
          fontWeight: EzManager.getDefault(lightBodyBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzManager.getDefault(lightBodyItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.getDefault(lightBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.getDefault(lightBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.getDefault(lightBodyLetterSpacingKey),
          wordSpacing: EzManager.getDefault(lightBodyWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzManager.getDefault(useDark ? darkBodyFontFamilyKey : lightBodyFontFamilyKey),
  );
}

/// Builds [TextTheme.labelLarge] w/ values from [EzProvider]
TextStyle ezLabelStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzManager.get(darkLabelFontSizeKey),
          fontWeight:
              EzManager.get(darkLabelBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzManager.get(darkLabelItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzManager.get(darkLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.get(darkLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.get(darkLabelLetterSpacingKey),
          wordSpacing: EzManager.get(darkLabelWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzManager.get(lightLabelFontSizeKey),
          fontWeight:
              EzManager.get(lightLabelBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzManager.get(lightLabelItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzManager.get(lightLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.get(lightLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.get(lightLabelLetterSpacingKey),
          wordSpacing: EzManager.get(lightLabelWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzManager.get(useDark ? darkLabelFontFamilyKey : lightLabelFontFamilyKey),
  );
}

/// Builds [TextTheme.labelLarge] w/ values from [EzConfig.defaults]
TextStyle ezDefaultLabelStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzManager.getDefault(darkLabelFontSizeKey),
          fontWeight: EzManager.getDefault(darkLabelBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzManager.getDefault(darkLabelItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.getDefault(darkLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.getDefault(darkLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.getDefault(darkLabelLetterSpacingKey),
          wordSpacing: EzManager.getDefault(darkLabelWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzManager.getDefault(lightLabelFontSizeKey),
          fontWeight: EzManager.getDefault(lightLabelBoldedKey) == true
              ? FontWeight.bold
              : FontWeight.normal,
          fontStyle: EzManager.getDefault(lightLabelItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzManager.getDefault(lightLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzManager.getDefault(lightLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzManager.getDefault(lightLabelLetterSpacingKey),
          wordSpacing: EzManager.getDefault(lightLabelWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzManager.getDefault(useDark ? darkLabelFontFamilyKey : lightLabelFontFamilyKey),
  );
}
