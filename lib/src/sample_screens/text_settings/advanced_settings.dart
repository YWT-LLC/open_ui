/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class AdvancedTextSettings extends StatefulWidget {
  // Providers
  final EzDisplayStyleProvider displayProvider;
  final EzHeadlineStyleProvider headlineProvider;
  final EzTitleStyleProvider titleProvider;
  final EzBodyStyleProvider bodyProvider;
  final EzLabelStyleProvider labelProvider;

  const AdvancedTextSettings({
    super.key,
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
  });

  @override
  State<AdvancedTextSettings> createState() => _AdvancedTextSettingsState();
}

class _AdvancedTextSettingsState extends State<AdvancedTextSettings> {
  // Gather the build data //

  EzTextSettingType editing = EzTextSettingType.display;

  // Define custom functions //

  /// [ThemeMode] string
  String tS() => EzConfig.isDark ? 'dark_' : 'light_';

  /// Font family setting
  EzFontSetting familyController(BuildContext context, EzTextSettingType source) =>
      switch (source) {
        EzTextSettingType.display => EzFontSetting(
            key: ValueKey<String>('${tS()}font_display'),
            type: EzTextSettingType.display,
            baseStyle: widget.bodyProvider.value,
            notifierCallback: widget.displayProvider.fuse,
          ),
        EzTextSettingType.headline => EzFontSetting(
            key: ValueKey<String>('${tS()}font_headline'),
            type: EzTextSettingType.headline,
            baseStyle: widget.bodyProvider.value,
            notifierCallback: widget.headlineProvider.fuse,
          ),
        EzTextSettingType.title => EzFontSetting(
            key: ValueKey<String>('${tS()}font_title'),
            type: EzTextSettingType.title,
            baseStyle: widget.bodyProvider.value,
            notifierCallback: widget.titleProvider.fuse,
          ),
        EzTextSettingType.body => EzFontSetting(
            key: ValueKey<String>('${tS()}font_body'),
            type: EzTextSettingType.body,
            baseStyle: widget.bodyProvider.value,
            notifierCallback: widget.bodyProvider.fuse,
          ),
        EzTextSettingType.label => EzFontSetting(
            key: ValueKey<String>('${tS()}font_label'),
            type: EzTextSettingType.label,
            baseStyle: widget.bodyProvider.value,
            notifierCallback: widget.labelProvider.fuse,
          ),
      };

  Widget _sizeIcon() => EzTextBackground(
        Icon(
          Icons.text_fields_sharp,
          color: EzConfig.colors.onSurface,
          size: widget.labelProvider.value.fontSize,
        ),
        borderRadius: EzConfig.textFieldRadius,
      );

  /// Font size setting
  EzFontDoubleSetting sizeController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}size_display'),
            configKey: EzConfig.isDark ? darkDisplayFontSizeKey : lightDisplayFontSizeKey,
            initialValue: widget.displayProvider.value.fontSize!,
            min: minDisplay,
            max: maxDisplay,
            notifierCallback: widget.displayProvider.resize,
            style: widget.bodyProvider.value,
            icon: _sizeIcon(),
            plusMinus: true,
            tooltip: EzConfig.l10n.tsFontSize,
          ),
        EzTextSettingType.headline => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}size_headline'),
            configKey: EzConfig.isDark ? darkHeadlineFontSizeKey : lightHeadlineFontSizeKey,
            initialValue: widget.headlineProvider.value.fontSize!,
            min: minHeadline,
            max: maxHeadline,
            notifierCallback: widget.headlineProvider.resize,
            style: widget.bodyProvider.value,
            icon: _sizeIcon(),
            plusMinus: true,
            tooltip: EzConfig.l10n.tsFontSize,
          ),
        EzTextSettingType.title => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}size_title'),
            configKey: EzConfig.isDark ? darkTitleFontSizeKey : lightTitleFontSizeKey,
            initialValue: widget.titleProvider.value.fontSize!,
            min: minTitle,
            max: maxTitle,
            notifierCallback: widget.titleProvider.resize,
            style: widget.bodyProvider.value,
            icon: _sizeIcon(),
            plusMinus: true,
            tooltip: EzConfig.l10n.tsFontSize,
          ),
        EzTextSettingType.body => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}size_body'),
            configKey: EzConfig.isDark ? darkBodyFontSizeKey : lightBodyFontSizeKey,
            initialValue: widget.bodyProvider.value.fontSize!,
            min: minBody,
            max: maxBody,
            notifierCallback: widget.bodyProvider.resize,
            style: widget.bodyProvider.value,
            icon: _sizeIcon(),
            plusMinus: true,
            tooltip: EzConfig.l10n.tsFontSize,
          ),
        EzTextSettingType.label => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}size_label'),
            configKey: EzConfig.isDark ? darkLabelFontSizeKey : lightLabelFontSizeKey,
            initialValue: widget.labelProvider.value.fontSize!,
            min: minLabel,
            max: maxLabel,
            notifierCallback: widget.labelProvider.resize,
            style: widget.bodyProvider.value,
            icon: _sizeIcon(),
            plusMinus: true,
            tooltip: EzConfig.l10n.tsFontSize,
          ),
      };

  /// Bold (font weight) setting
  EzBoldSetting boldController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzBoldSetting(
            key: ValueKey<String>('${tS()}bold_display'),
            type: EzTextSettingType.display,
            notifierCallback: widget.displayProvider.bold,
          ),
        EzTextSettingType.headline => EzBoldSetting(
            key: ValueKey<String>('${tS()}bold_headline'),
            type: EzTextSettingType.headline,
            notifierCallback: widget.headlineProvider.bold,
          ),
        EzTextSettingType.title => EzBoldSetting(
            key: ValueKey<String>('${tS()}bold_title'),
            type: EzTextSettingType.title,
            notifierCallback: widget.titleProvider.bold,
          ),
        EzTextSettingType.body => EzBoldSetting(
            key: ValueKey<String>('${tS()}bold_body'),
            type: EzTextSettingType.body,
            notifierCallback: widget.bodyProvider.bold,
          ),
        EzTextSettingType.label => EzBoldSetting(
            key: ValueKey<String>('${tS()}bold_label'),
            type: EzTextSettingType.label,
            notifierCallback: widget.labelProvider.bold,
          ),
      };

  /// Italic (font style) setting
  EzItalicSetting italicsController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzItalicSetting(
            key: ValueKey<String>('${tS()}italic_display'),
            type: EzTextSettingType.display,
            notifierCallback: widget.displayProvider.italic,
          ),
        EzTextSettingType.headline => EzItalicSetting(
            key: ValueKey<String>('${tS()}italic_headline'),
            type: EzTextSettingType.headline,
            notifierCallback: widget.headlineProvider.italic,
          ),
        EzTextSettingType.title => EzItalicSetting(
            key: ValueKey<String>('${tS()}italic_title'),
            type: EzTextSettingType.title,
            notifierCallback: widget.titleProvider.italic,
          ),
        EzTextSettingType.body => EzItalicSetting(
            key: ValueKey<String>('${tS()}italic_body'),
            type: EzTextSettingType.body,
            notifierCallback: widget.bodyProvider.italic,
          ),
        EzTextSettingType.label => EzItalicSetting(
            key: ValueKey<String>('${tS()}italic_label'),
            type: EzTextSettingType.label,
            notifierCallback: widget.labelProvider.italic,
          ),
      };

  /// Underline (decoration) setting
  EzUnderlineSetting underlineController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzUnderlineSetting(
            key: ValueKey<String>('${tS()}underline_display'),
            type: EzTextSettingType.display,
            notifierCallback: widget.displayProvider.underline,
          ),
        EzTextSettingType.headline => EzUnderlineSetting(
            key: ValueKey<String>('${tS()}underline_headline'),
            type: EzTextSettingType.headline,
            notifierCallback: widget.headlineProvider.underline,
          ),
        EzTextSettingType.title => EzUnderlineSetting(
            key: ValueKey<String>('${tS()}underline_title'),
            type: EzTextSettingType.title,
            notifierCallback: widget.titleProvider.underline,
          ),
        EzTextSettingType.body => EzUnderlineSetting(
            key: ValueKey<String>('${tS()}underline_body'),
            type: EzTextSettingType.body,
            notifierCallback: widget.bodyProvider.underline,
          ),
        EzTextSettingType.label => EzUnderlineSetting(
            key: ValueKey<String>('${tS()}underline_label'),
            type: EzTextSettingType.label,
            notifierCallback: widget.labelProvider.underline,
          ),
      };

  Widget _letterIcon() => EzTextBackground(
        Icon(
          Icons.horizontal_distribute_sharp,
          color: EzConfig.colors.onSurface,
          size: widget.labelProvider.value.fontSize,
        ),
        borderRadius: EzConfig.textFieldRadius,
      );

  /// Letter spacing setting
  EzFontDoubleSetting letterSpacingController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}letter_spacing_display'),
            configKey: EzConfig.isDark ? darkDisplayWordSpacingKey : lightDisplayWordSpacingKey,
            initialValue: widget.displayProvider.value.letterSpacing!,
            min: minLetterSpacing,
            max: maxLetterSpacing,
            notifierCallback: widget.displayProvider.setLetterSpacing,
            style: widget.bodyProvider.value,
            icon: _letterIcon(),
            tooltip: EzConfig.l10n.tsLetterSpacing,
          ),
        EzTextSettingType.headline => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}letter_spacing_headline'),
            configKey: EzConfig.isDark ? darkHeadlineWordSpacingKey : lightHeadlineWordSpacingKey,
            initialValue: widget.headlineProvider.value.letterSpacing!,
            min: minLetterSpacing,
            max: maxLetterSpacing,
            notifierCallback: widget.headlineProvider.setLetterSpacing,
            style: widget.bodyProvider.value,
            icon: _letterIcon(),
            tooltip: EzConfig.l10n.tsLetterSpacing,
          ),
        EzTextSettingType.title => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}letter_spacing_title'),
            configKey: EzConfig.isDark ? darkTitleWordSpacingKey : lightTitleWordSpacingKey,
            initialValue: widget.titleProvider.value.letterSpacing!,
            min: minLetterSpacing,
            max: maxLetterSpacing,
            notifierCallback: widget.titleProvider.setLetterSpacing,
            style: widget.bodyProvider.value,
            icon: _letterIcon(),
            tooltip: EzConfig.l10n.tsLetterSpacing,
          ),
        EzTextSettingType.body => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}letter_spacing_body'),
            configKey: EzConfig.isDark ? darkBodyWordSpacingKey : lightBodyWordSpacingKey,
            initialValue: widget.bodyProvider.value.letterSpacing!,
            min: minLetterSpacing,
            max: maxLetterSpacing,
            notifierCallback: widget.bodyProvider.setLetterSpacing,
            style: widget.bodyProvider.value,
            icon: _letterIcon(),
            tooltip: EzConfig.l10n.tsLetterSpacing,
          ),
        EzTextSettingType.label => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}letter_spacing_label'),
            configKey: EzConfig.isDark ? darkLabelWordSpacingKey : lightLabelWordSpacingKey,
            initialValue: widget.labelProvider.value.letterSpacing!,
            min: minLetterSpacing,
            max: maxLetterSpacing,
            notifierCallback: widget.labelProvider.setLetterSpacing,
            style: widget.bodyProvider.value,
            icon: _letterIcon(),
            tooltip: EzConfig.l10n.tsLetterSpacing,
          ),
      };

  Widget _wordIcon() => EzTextBackground(
        Icon(
          Icons.space_bar_sharp,
          color: EzConfig.colors.onSurface,
          size: widget.labelProvider.value.fontSize,
        ),
        borderRadius: EzConfig.textFieldRadius,
      );

  /// Word spacing setting
  EzFontDoubleSetting wordSpacingController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}word_spacing_display'),
            configKey: EzConfig.isDark ? darkDisplayWordSpacingKey : lightDisplayWordSpacingKey,
            initialValue: widget.displayProvider.value.wordSpacing!,
            min: minWordSpacing,
            max: maxWordSpacing,
            notifierCallback: widget.displayProvider.setWordSpacing,
            style: widget.bodyProvider.value,
            icon: _wordIcon(),
            tooltip: EzConfig.l10n.tsWordSpacing,
          ),
        EzTextSettingType.headline => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}word_spacing_headline'),
            configKey: EzConfig.isDark ? darkHeadlineWordSpacingKey : lightHeadlineWordSpacingKey,
            initialValue: widget.headlineProvider.value.wordSpacing!,
            min: minWordSpacing,
            max: maxWordSpacing,
            notifierCallback: widget.headlineProvider.setWordSpacing,
            style: widget.bodyProvider.value,
            icon: _wordIcon(),
            tooltip: EzConfig.l10n.tsWordSpacing,
          ),
        EzTextSettingType.title => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}word_spacing_title'),
            configKey: EzConfig.isDark ? darkTitleWordSpacingKey : lightTitleWordSpacingKey,
            initialValue: widget.titleProvider.value.wordSpacing!,
            min: minWordSpacing,
            max: maxWordSpacing,
            notifierCallback: widget.titleProvider.setWordSpacing,
            style: widget.bodyProvider.value,
            icon: _wordIcon(),
            tooltip: EzConfig.l10n.tsWordSpacing,
          ),
        EzTextSettingType.body => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}word_spacing_body'),
            configKey: EzConfig.isDark ? darkBodyWordSpacingKey : lightBodyWordSpacingKey,
            initialValue: widget.bodyProvider.value.wordSpacing!,
            min: minWordSpacing,
            max: maxWordSpacing,
            notifierCallback: widget.bodyProvider.setWordSpacing,
            style: widget.bodyProvider.value,
            icon: _wordIcon(),
            tooltip: EzConfig.l10n.tsWordSpacing,
          ),
        EzTextSettingType.label => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}word_spacing_label'),
            configKey: EzConfig.isDark ? darkLabelWordSpacingKey : lightLabelWordSpacingKey,
            initialValue: widget.labelProvider.value.wordSpacing!,
            min: minWordSpacing,
            max: maxWordSpacing,
            notifierCallback: widget.labelProvider.setWordSpacing,
            style: widget.bodyProvider.value,
            icon: _wordIcon(),
            tooltip: EzConfig.l10n.tsWordSpacing,
          ),
      };

  Widget _lineIcon() => EzTextBackground(
        Icon(
          Icons.format_line_spacing_sharp,
          color: EzConfig.colors.onSurface,
          size: widget.labelProvider.value.fontSize,
        ),
        borderRadius: EzConfig.textFieldRadius,
      );

  /// Line height setting
  EzFontDoubleSetting lineHeightController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}line_height_display'),
            configKey: EzConfig.isDark ? darkDisplayFontHeightKey : lightDisplayFontHeightKey,
            initialValue: widget.displayProvider.value.height!,
            min: minFontHeight,
            max: maxFontHeight,
            notifierCallback: widget.displayProvider.setHeight,
            style: widget.bodyProvider.value,
            icon: _lineIcon(),
            tooltip: EzConfig.l10n.tsLineHeight,
          ),
        EzTextSettingType.headline => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}line_height_headline'),
            configKey: EzConfig.isDark ? darkHeadlineFontHeightKey : lightHeadlineFontHeightKey,
            initialValue: widget.headlineProvider.value.height!,
            min: minFontHeight,
            max: maxFontHeight,
            notifierCallback: widget.headlineProvider.setHeight,
            style: widget.bodyProvider.value,
            icon: _lineIcon(),
            tooltip: EzConfig.l10n.tsLineHeight,
          ),
        EzTextSettingType.title => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}line_height_title'),
            configKey: EzConfig.isDark ? darkTitleFontHeightKey : lightTitleFontHeightKey,
            initialValue: widget.titleProvider.value.height!,
            min: minFontHeight,
            max: maxFontHeight,
            notifierCallback: widget.titleProvider.setHeight,
            style: widget.bodyProvider.value,
            icon: _lineIcon(),
            tooltip: EzConfig.l10n.tsLineHeight,
          ),
        EzTextSettingType.body => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}line_height_body'),
            configKey: EzConfig.isDark ? darkBodyFontHeightKey : lightBodyFontHeightKey,
            initialValue: widget.bodyProvider.value.height!,
            min: minFontHeight,
            max: maxFontHeight,
            notifierCallback: widget.bodyProvider.setHeight,
            style: widget.bodyProvider.value,
            icon: _lineIcon(),
            tooltip: EzConfig.l10n.tsLineHeight,
          ),
        EzTextSettingType.label => EzFontDoubleSetting(
            key: ValueKey<String>('${tS()}line_height_label'),
            configKey: EzConfig.isDark ? darkLabelFontHeightKey : lightLabelFontHeightKey,
            initialValue: widget.labelProvider.value.height!,
            min: minFontHeight,
            max: maxFontHeight,
            notifierCallback: widget.labelProvider.setHeight,
            style: widget.bodyProvider.value,
            icon: _lineIcon(),
            tooltip: EzConfig.l10n.tsLineHeight,
          ),
      };

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final EdgeInsets colMargin = EzInsets.col(EzConfig.marginVal);
    const EzSwapSpacer swapSpacer = EzSwapSpacer(breakpoint: ScreenSize.medium);

    // Return the build //

    return EzCol(children: <Widget>[
      // Style selector
      EzScrollView(
        scrollDirection: Axis.horizontal,
        primary: false,
        children: <Widget>[
          EzText(
            EzConfig.l10n.gEditing,
            style: widget.labelProvider.value,
            textAlign: TextAlign.center,
          ),
          EzConfig.margin,
          EzDropdownMenu<EzTextSettingType>(
            widthEntry: EzConfig.l10n.tsHeadline,
            textStyle: widget.labelProvider.value,
            dropdownMenuEntries: EzTextSettingType.values
                .map((EzTextSettingType type) => DropdownMenuEntry<EzTextSettingType>(
                      value: type,
                      label: type.label,
                    ))
                .toList(),
            enableSearch: false,
            initialSelection: editing,
            onSelected: (EzTextSettingType? value) {
              if (value != null) setState(() => editing = value);
            },
          ),
        ],
      ),
      EzConfig.spacer,

      // Controls
      EzRowCol.sym(
        breakpoint: ScreenSize.medium,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Font family
          familyController(context, editing),
          swapSpacer,

          // Font size
          sizeController(editing),
          swapSpacer,

          // Font weight, style, and decoration
          EzScrollView(
            scrollDirection: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              boldController(editing),
              EzConfig.rowSpacer,
              italicsController(editing),
              EzConfig.rowSpacer,
              underlineController(editing),
            ],
          ),

          // Letter, word, and line spacing
          swapSpacer,
          EzScrollView(
            scrollDirection: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              letterSpacingController(editing),
              EzConfig.rowSpacer,
              wordSpacingController(editing),
              EzConfig.rowSpacer,
              lineHeightController(editing),
            ],
          ),
        ],
      ),
      EzConfig.separator,

      // Display preview
      EzTextBackground(
        EzRichText(
          <InlineSpan>[
            EzPlainText(text: EzConfig.l10n.tsDisplayP1),
            EzInlineLink(
              EzConfig.l10n.tsDisplayLink,
              style: widget.displayProvider.value,
              textAlign: TextAlign.center,
              onTap: () => setState(() => editing = EzTextSettingType.display),
              hint: EzConfig.l10n.tsLinkHint(EzConfig.l10n.tsDisplay.toLowerCase()),
            ),
            EzPlainText(text: EzConfig.l10n.tsDisplayP2),
          ],
          textBackground: false,
          style: widget.displayProvider.value,
          textAlign: TextAlign.center,
        ),
        baseColor: EzConfig.colors.surface,
        padding: colMargin,
        borderRadius: EzConfig.textRadius,
      ),
      EzConfig.spacer,

      // Headline preview
      EzTextBackground(
        EzRichText(
          <InlineSpan>[
            EzPlainText(text: EzConfig.l10n.tsHeadlineP1),
            EzInlineLink(
              EzConfig.l10n.tsHeadlineLink,
              style: widget.headlineProvider.value,
              textAlign: TextAlign.center,
              onTap: () => setState(() => editing = EzTextSettingType.headline),
              hint: EzConfig.l10n.tsLinkHint(EzConfig.l10n.tsHeadline.toLowerCase()),
            ),
            EzPlainText(text: EzConfig.l10n.tsHeadlineP2),
          ],
          textBackground: false,
          style: widget.headlineProvider.value,
          textAlign: TextAlign.center,
        ),
        baseColor: EzConfig.colors.surface,
        padding: colMargin,
        borderRadius: EzConfig.textRadius,
      ),
      EzConfig.spacer,

      // Title preview
      EzTextBackground(
        EzRichText(
          <InlineSpan>[
            EzPlainText(text: EzConfig.l10n.tsTitleP1),
            EzInlineLink(
              EzConfig.l10n.tsTitleLink,
              style: widget.titleProvider.value,
              textAlign: TextAlign.center,
              onTap: () => setState(() => editing = EzTextSettingType.title),
              hint: EzConfig.l10n.tsLinkHint(EzConfig.l10n.tsTitle.toLowerCase()),
            ),
          ],
          textBackground: false,
          style: widget.titleProvider.value,
          textAlign: TextAlign.center,
        ),
        baseColor: EzConfig.colors.surface,
        padding: colMargin,
        borderRadius: EzConfig.textRadius,
      ),
      EzConfig.spacer,

      // Body preview
      EzTextBackground(
        EzRichText(
          <InlineSpan>[
            EzPlainText(text: EzConfig.l10n.tsBodyP1),
            EzInlineLink(
              EzConfig.l10n.tsBodyLink,
              style: widget.bodyProvider.value,
              textAlign: TextAlign.center,
              onTap: () => setState(() => editing = EzTextSettingType.body),
              hint: EzConfig.l10n.tsLinkHint(EzConfig.l10n.tsBody.toLowerCase()),
            ),
            EzPlainText(text: EzConfig.l10n.tsBodyP2),
          ],
          textBackground: false,
          style: widget.bodyProvider.value,
          textAlign: TextAlign.center,
        ),
        baseColor: EzConfig.colors.surface,
        padding: colMargin,
        borderRadius: EzConfig.textRadius,
      ),
      EzConfig.spacer,

      // Label preview
      EzTextBackground(
        EzRichText(
          <InlineSpan>[
            EzPlainText(text: EzConfig.l10n.tsLabelP1),
            EzInlineLink(
              EzConfig.l10n.tsLabelLink,
              style: widget.labelProvider.value,
              textAlign: TextAlign.center,
              onTap: () => setState(() => editing = EzTextSettingType.label),
              hint: EzConfig.l10n.tsLinkHint(EzConfig.l10n.tsLabel.toLowerCase()),
            ),
            EzPlainText(text: EzConfig.l10n.tsLabelP2),
          ],
          textBackground: false,
          style: widget.labelProvider.value,
          textAlign: TextAlign.center,
        ),
        baseColor: EzConfig.colors.surface,
        padding: colMargin,
        borderRadius: EzConfig.textRadius,
      ),

      // Reset all
      EzConfig.separator,
      EzResetButton(
        all: false,
        dynamicTitle: () => EzConfig.l10n.tsReset(ezThemeString(false)),
        onConfirm: () async {
          if (EzConfig.isDark) {
            await EzConfig.removeKeys(darkTextKeys.keys.toSet());
            await EzConfig.remove(darkOnSurfaceKey);
          } else {
            await EzConfig.removeKeys(lightTextKeys.keys.toSet());
            await EzConfig.remove(lightOnSurfaceKey);
          }

          setState(() => editing = EzTextSettingType.display);
        },
      ),
    ]);
  }
}
