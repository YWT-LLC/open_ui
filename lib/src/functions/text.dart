/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Helpers //

/// 404 [OUILang.gError]
String ez404() => ezRootIsMounted
    ? '404 ${Provider.of<EzCP>(ezRootContext, listen: false).ezL10n.gError}'
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
bool ezTextRebuildCheck(EzCP config, {required BuildContext context}) {
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
  EzCP config, {
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
            ? Provider.of<EzCP>(ezRootContext, listen: false).colors.primary.toARGB32()
            : ywtPurpleHex,
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

// Getters //

/// [TextTheme.headlineLarge] w/ the [TextStyle.fontSize] of [TextTheme.titleLarge]
TextStyle? ezSubHeadingStyle(TextTheme styles) =>
    styles.headlineLarge?.copyWith(fontSize: styles.titleLarge?.fontSize);

/// [TextTheme.bodyLarge] w/ the [TextStyle.fontSize] of [TextTheme.titleLarge]
TextStyle? ezSubTitleStyle(TextTheme styles) =>
    styles.bodyLarge?.copyWith(fontSize: styles.titleLarge?.fontSize);

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

/// Builds [TextTheme.displayLarge] w/ values from [EzCP]
TextStyle ezDisplayStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzCM.get(darkDisplayFontSizeKey),
          fontWeight: EzCM.get(darkDisplayBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzCM.get(darkDisplayItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.get(darkDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.get(darkDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.get(darkDisplayLetterSpacingKey),
          wordSpacing: EzCM.get(darkDisplayWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzCM.get(lightDisplayFontSizeKey),
          fontWeight: EzCM.get(lightDisplayBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzCM.get(lightDisplayItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.get(lightDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.get(lightDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.get(lightDisplayLetterSpacingKey),
          wordSpacing: EzCM.get(lightDisplayWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzCM.get(useDark ? darkDisplayFontFamilyKey : lightDisplayFontFamilyKey),
  );
}

/// Builds [TextTheme.displayLarge] w/ values from [EzCP]
TextStyle ezDefaultDisplayStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzCM.getDefault(darkDisplayFontSizeKey),
          fontWeight:
              EzCM.getDefault(darkDisplayBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzCM.getDefault(darkDisplayItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzCM.getDefault(darkDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.getDefault(darkDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.getDefault(darkDisplayLetterSpacingKey),
          wordSpacing: EzCM.getDefault(darkDisplayWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzCM.getDefault(lightDisplayFontSizeKey),
          fontWeight:
              EzCM.getDefault(lightDisplayBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzCM.getDefault(lightDisplayItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzCM.getDefault(lightDisplayUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.getDefault(lightDisplayFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.getDefault(lightDisplayLetterSpacingKey),
          wordSpacing: EzCM.getDefault(lightDisplayWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzCM.getDefault(useDark ? darkDisplayFontFamilyKey : lightDisplayFontFamilyKey),
  );
}

/// Builds [TextTheme.headlineLarge] w/ values from [EzCP]
TextStyle ezHeadlineStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzCM.get(darkHeadlineFontSizeKey),
          fontWeight: EzCM.get(darkHeadlineBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzCM.get(darkHeadlineItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.get(darkHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.get(darkHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.get(darkHeadlineLetterSpacingKey),
          wordSpacing: EzCM.get(darkHeadlineWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzCM.get(lightHeadlineFontSizeKey),
          fontWeight:
              EzCM.get(lightHeadlineBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzCM.get(lightHeadlineItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.get(lightHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.get(lightHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.get(lightHeadlineLetterSpacingKey),
          wordSpacing: EzCM.get(lightHeadlineWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzCM.get(useDark ? darkHeadlineFontFamilyKey : lightHeadlineFontFamilyKey),
  );
}

/// Builds [TextTheme.headlineLarge] w/ values from [EzConfig.defaults]
TextStyle ezDefaultHeadlineStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzCM.getDefault(darkHeadlineFontSizeKey),
          fontWeight:
              EzCM.getDefault(darkHeadlineBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzCM.getDefault(darkHeadlineItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzCM.getDefault(darkHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.getDefault(darkHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.getDefault(darkHeadlineLetterSpacingKey),
          wordSpacing: EzCM.getDefault(darkHeadlineWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzCM.getDefault(lightHeadlineFontSizeKey),
          fontWeight:
              EzCM.getDefault(lightHeadlineBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzCM.getDefault(lightHeadlineItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzCM.getDefault(lightHeadlineUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.getDefault(lightHeadlineFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.getDefault(lightHeadlineLetterSpacingKey),
          wordSpacing: EzCM.getDefault(lightHeadlineWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzCM.getDefault(useDark ? darkHeadlineFontFamilyKey : lightHeadlineFontFamilyKey),
  );
}

/// Builds [TextTheme.titleLarge] w/ values from [EzCP]
TextStyle ezTitleStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzCM.get(darkTitleFontSizeKey),
          fontWeight: EzCM.get(darkTitleBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzCM.get(darkTitleItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.get(darkTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.get(darkTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.get(darkTitleLetterSpacingKey),
          wordSpacing: EzCM.get(darkTitleWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzCM.get(lightTitleFontSizeKey),
          fontWeight: EzCM.get(lightTitleBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzCM.get(lightTitleItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.get(lightTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.get(lightTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.get(lightTitleLetterSpacingKey),
          wordSpacing: EzCM.get(lightTitleWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzCM.get(useDark ? darkTitleFontFamilyKey : lightTitleFontFamilyKey),
  );
}

/// Builds [TextTheme.titleLarge] w/ values from [EzConfig.defaults]
TextStyle ezDefaultTitleStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzCM.getDefault(darkTitleFontSizeKey),
          fontWeight:
              EzCM.getDefault(darkTitleBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzCM.getDefault(darkTitleItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.getDefault(darkTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.getDefault(darkTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.getDefault(darkTitleLetterSpacingKey),
          wordSpacing: EzCM.getDefault(darkTitleWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzCM.getDefault(lightTitleFontSizeKey),
          fontWeight:
              EzCM.getDefault(lightTitleBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzCM.getDefault(lightTitleItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzCM.getDefault(lightTitleUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.getDefault(lightTitleFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.getDefault(lightTitleLetterSpacingKey),
          wordSpacing: EzCM.getDefault(lightTitleWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzCM.getDefault(useDark ? darkTitleFontFamilyKey : lightTitleFontFamilyKey),
  );
}

/// Builds [TextTheme.bodyLarge] w/ values from [EzCP]
TextStyle ezBodyStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzCM.get(darkBodyFontSizeKey),
          fontWeight: EzCM.get(darkBodyBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzCM.get(darkBodyItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.get(darkBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.get(darkBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.get(darkBodyLetterSpacingKey),
          wordSpacing: EzCM.get(darkBodyWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzCM.get(lightBodyFontSizeKey),
          fontWeight: EzCM.get(lightBodyBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzCM.get(lightBodyItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.get(lightBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.get(lightBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.get(lightBodyLetterSpacingKey),
          wordSpacing: EzCM.get(lightBodyWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzCM.get(useDark ? darkBodyFontFamilyKey : lightBodyFontFamilyKey),
  );
}

/// Builds [TextTheme.bodyLarge] w/ values from [EzConfig.defaults]
TextStyle ezDefaultBodyStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzCM.getDefault(darkBodyFontSizeKey),
          fontWeight:
              EzCM.getDefault(darkBodyBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzCM.getDefault(darkBodyItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.getDefault(darkBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.getDefault(darkBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.getDefault(darkBodyLetterSpacingKey),
          wordSpacing: EzCM.getDefault(darkBodyWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzCM.getDefault(lightBodyFontSizeKey),
          fontWeight:
              EzCM.getDefault(lightBodyBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzCM.getDefault(lightBodyItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.getDefault(lightBodyUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.getDefault(lightBodyFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.getDefault(lightBodyLetterSpacingKey),
          wordSpacing: EzCM.getDefault(lightBodyWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzCM.getDefault(useDark ? darkBodyFontFamilyKey : lightBodyFontFamilyKey),
  );
}

/// Builds [TextTheme.labelLarge] w/ values from [EzCP]
TextStyle ezLabelStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzCM.get(darkLabelFontSizeKey),
          fontWeight: EzCM.get(darkLabelBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzCM.get(darkLabelItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.get(darkLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.get(darkLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.get(darkLabelLetterSpacingKey),
          wordSpacing: EzCM.get(darkLabelWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzCM.get(lightLabelFontSizeKey),
          fontWeight: EzCM.get(lightLabelBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzCM.get(lightLabelItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.get(lightLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.get(lightLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.get(lightLabelLetterSpacingKey),
          wordSpacing: EzCM.get(lightLabelWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzCM.get(useDark ? darkLabelFontFamilyKey : lightLabelFontFamilyKey),
  );
}

/// Builds [TextTheme.labelLarge] w/ values from [EzConfig.defaults]
TextStyle ezDefaultLabelStyle(Color? color, {required bool isDark}) {
  final bool useDark = isDark;
  final TextStyle starter = useDark
      ? TextStyle(
          fontSize: EzCM.getDefault(darkLabelFontSizeKey),
          fontWeight:
              EzCM.getDefault(darkLabelBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle:
              EzCM.getDefault(darkLabelItalicizedKey) == true ? FontStyle.italic : FontStyle.normal,
          decoration: EzCM.getDefault(darkLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.getDefault(darkLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.getDefault(darkLabelLetterSpacingKey),
          wordSpacing: EzCM.getDefault(darkLabelWordSpacingKey),
        )
      : TextStyle(
          fontSize: EzCM.getDefault(lightLabelFontSizeKey),
          fontWeight:
              EzCM.getDefault(lightLabelBoldedKey) == true ? FontWeight.bold : FontWeight.normal,
          fontStyle: EzCM.getDefault(lightLabelItalicizedKey) == true
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: EzCM.getDefault(lightLabelUnderlinedKey) == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color,
          height: EzCM.getDefault(lightLabelFontHeightKey),
          leadingDistribution: TextLeadingDistribution.even,
          letterSpacing: EzCM.getDefault(lightLabelLetterSpacingKey),
          wordSpacing: EzCM.getDefault(lightLabelWordSpacingKey),
        );

  return fuseWithGFont(
    starter: starter,
    gFont: EzCM.getDefault(useDark ? darkLabelFontFamilyKey : lightLabelFontFamilyKey),
  );
}
