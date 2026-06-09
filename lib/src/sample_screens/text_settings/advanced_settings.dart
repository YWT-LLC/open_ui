/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class AdvancedTextSettings extends StatefulWidget {
  final EzCP config;

  // Providers
  final EzDisplayStyleProvider displayProvider;
  final EzHeadlineStyleProvider headlineProvider;
  final EzTitleStyleProvider titleProvider;
  final EzBodyStyleProvider bodyProvider;
  final EzLabelStyleProvider labelProvider;

  const AdvancedTextSettings(
    this.config, {
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
  String tS() => widget.config.isDark ? 'dark_' : 'light_';

  /// Font family setting
  EzFontSetting familyController(BuildContext context, EzTextSettingType source) =>
      switch (source) {
        EzTextSettingType.display => EzFontSetting(
            widget.config,
            key: ValueKey<String>('${tS()}font_display'),
            type: EzTextSettingType.display,
            baseStyle: widget.bodyProvider.value,
            notifierCallback: widget.displayProvider.fuse,
          ),
        EzTextSettingType.headline => EzFontSetting(
            widget.config,
            key: ValueKey<String>('${tS()}font_headline'),
            type: EzTextSettingType.headline,
            baseStyle: widget.bodyProvider.value,
            notifierCallback: widget.headlineProvider.fuse,
          ),
        EzTextSettingType.title => EzFontSetting(
            widget.config,
            key: ValueKey<String>('${tS()}font_title'),
            type: EzTextSettingType.title,
            baseStyle: widget.bodyProvider.value,
            notifierCallback: widget.titleProvider.fuse,
          ),
        EzTextSettingType.body => EzFontSetting(
            widget.config,
            key: ValueKey<String>('${tS()}font_body'),
            type: EzTextSettingType.body,
            baseStyle: widget.bodyProvider.value,
            notifierCallback: widget.bodyProvider.fuse,
          ),
        EzTextSettingType.label => EzFontSetting(
            widget.config,
            key: ValueKey<String>('${tS()}font_label'),
            type: EzTextSettingType.label,
            baseStyle: widget.bodyProvider.value,
            notifierCallback: widget.labelProvider.fuse,
          ),
      };

  Widget _sizeIcon() => EzTextBackground(
        widget.config,
        text: Icon(
          Icons.text_fields_sharp,
          color: widget.config.colors.onSurface,
          size: widget.labelProvider.value.fontSize,
        ),
        borderRadius: widget.config.textFieldRadius,
      );

  /// Font size setting
  EzFontDoubleSetting sizeController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}size_display'),
            configKey: widget.config.isDark ? darkDisplayFontSizeKey : lightDisplayFontSizeKey,
            initialValue: widget.displayProvider.value.fontSize!,
            min: minDisplay,
            max: maxDisplay,
            notifierCallback: widget.displayProvider.resize,
            style: widget.bodyProvider.value,
            icon: _sizeIcon(),
            plusMinus: true,
            tooltip: widget.config.ezL10n.tsFontSize,
          ),
        EzTextSettingType.headline => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}size_headline'),
            configKey: widget.config.isDark ? darkHeadlineFontSizeKey : lightHeadlineFontSizeKey,
            initialValue: widget.headlineProvider.value.fontSize!,
            min: minHeadline,
            max: maxHeadline,
            notifierCallback: widget.headlineProvider.resize,
            style: widget.bodyProvider.value,
            icon: _sizeIcon(),
            plusMinus: true,
            tooltip: widget.config.ezL10n.tsFontSize,
          ),
        EzTextSettingType.title => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}size_title'),
            configKey: widget.config.isDark ? darkTitleFontSizeKey : lightTitleFontSizeKey,
            initialValue: widget.titleProvider.value.fontSize!,
            min: minTitle,
            max: maxTitle,
            notifierCallback: widget.titleProvider.resize,
            style: widget.bodyProvider.value,
            icon: _sizeIcon(),
            plusMinus: true,
            tooltip: widget.config.ezL10n.tsFontSize,
          ),
        EzTextSettingType.body => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}size_body'),
            configKey: widget.config.isDark ? darkBodyFontSizeKey : lightBodyFontSizeKey,
            initialValue: widget.bodyProvider.value.fontSize!,
            min: minBody,
            max: maxBody,
            notifierCallback: widget.bodyProvider.resize,
            style: widget.bodyProvider.value,
            icon: _sizeIcon(),
            plusMinus: true,
            tooltip: widget.config.ezL10n.tsFontSize,
          ),
        EzTextSettingType.label => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}size_label'),
            configKey: widget.config.isDark ? darkLabelFontSizeKey : lightLabelFontSizeKey,
            initialValue: widget.labelProvider.value.fontSize!,
            min: minLabel,
            max: maxLabel,
            notifierCallback: widget.labelProvider.resize,
            style: widget.bodyProvider.value,
            icon: _sizeIcon(),
            plusMinus: true,
            tooltip: widget.config.ezL10n.tsFontSize,
          ),
      };

  /// Bold (font weight) setting
  EzBoldSetting boldController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzBoldSetting(
            widget.config,
            key: ValueKey<String>('${tS()}bold_display'),
            type: EzTextSettingType.display,
            notifierCallback: widget.displayProvider.bold,
          ),
        EzTextSettingType.headline => EzBoldSetting(
            widget.config,
            key: ValueKey<String>('${tS()}bold_headline'),
            type: EzTextSettingType.headline,
            notifierCallback: widget.headlineProvider.bold,
          ),
        EzTextSettingType.title => EzBoldSetting(
            widget.config,
            key: ValueKey<String>('${tS()}bold_title'),
            type: EzTextSettingType.title,
            notifierCallback: widget.titleProvider.bold,
          ),
        EzTextSettingType.body => EzBoldSetting(
            widget.config,
            key: ValueKey<String>('${tS()}bold_body'),
            type: EzTextSettingType.body,
            notifierCallback: widget.bodyProvider.bold,
          ),
        EzTextSettingType.label => EzBoldSetting(
            widget.config,
            key: ValueKey<String>('${tS()}bold_label'),
            type: EzTextSettingType.label,
            notifierCallback: widget.labelProvider.bold,
          ),
      };

  /// Italic (font style) setting
  EzItalicSetting italicsController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzItalicSetting(
            widget.config,
            key: ValueKey<String>('${tS()}italic_display'),
            type: EzTextSettingType.display,
            notifierCallback: widget.displayProvider.italic,
          ),
        EzTextSettingType.headline => EzItalicSetting(
            widget.config,
            key: ValueKey<String>('${tS()}italic_headline'),
            type: EzTextSettingType.headline,
            notifierCallback: widget.headlineProvider.italic,
          ),
        EzTextSettingType.title => EzItalicSetting(
            widget.config,
            key: ValueKey<String>('${tS()}italic_title'),
            type: EzTextSettingType.title,
            notifierCallback: widget.titleProvider.italic,
          ),
        EzTextSettingType.body => EzItalicSetting(
            widget.config,
            key: ValueKey<String>('${tS()}italic_body'),
            type: EzTextSettingType.body,
            notifierCallback: widget.bodyProvider.italic,
          ),
        EzTextSettingType.label => EzItalicSetting(
            widget.config,
            key: ValueKey<String>('${tS()}italic_label'),
            type: EzTextSettingType.label,
            notifierCallback: widget.labelProvider.italic,
          ),
      };

  /// Underline (decoration) setting
  EzUnderlineSetting underlineController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzUnderlineSetting(
            widget.config,
            key: ValueKey<String>('${tS()}underline_display'),
            type: EzTextSettingType.display,
            notifierCallback: widget.displayProvider.underline,
          ),
        EzTextSettingType.headline => EzUnderlineSetting(
            widget.config,
            key: ValueKey<String>('${tS()}underline_headline'),
            type: EzTextSettingType.headline,
            notifierCallback: widget.headlineProvider.underline,
          ),
        EzTextSettingType.title => EzUnderlineSetting(
            widget.config,
            key: ValueKey<String>('${tS()}underline_title'),
            type: EzTextSettingType.title,
            notifierCallback: widget.titleProvider.underline,
          ),
        EzTextSettingType.body => EzUnderlineSetting(
            widget.config,
            key: ValueKey<String>('${tS()}underline_body'),
            type: EzTextSettingType.body,
            notifierCallback: widget.bodyProvider.underline,
          ),
        EzTextSettingType.label => EzUnderlineSetting(
            widget.config,
            key: ValueKey<String>('${tS()}underline_label'),
            type: EzTextSettingType.label,
            notifierCallback: widget.labelProvider.underline,
          ),
      };

  Widget _letterIcon() => EzTextBackground(
        widget.config,
        text: Icon(
          Icons.horizontal_distribute_sharp,
          color: widget.config.colors.onSurface,
          size: widget.labelProvider.value.fontSize,
        ),
        borderRadius: widget.config.textFieldRadius,
      );

  /// Letter spacing setting
  EzFontDoubleSetting letterSpacingController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}letter_spacing_display'),
            configKey:
                widget.config.isDark ? darkDisplayWordSpacingKey : lightDisplayWordSpacingKey,
            initialValue: widget.displayProvider.value.letterSpacing!,
            min: minLetterSpacing,
            max: maxLetterSpacing,
            notifierCallback: widget.displayProvider.setLetterSpacing,
            style: widget.bodyProvider.value,
            icon: _letterIcon(),
            tooltip: widget.config.ezL10n.tsLetterSpacing,
          ),
        EzTextSettingType.headline => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}letter_spacing_headline'),
            configKey:
                widget.config.isDark ? darkHeadlineWordSpacingKey : lightHeadlineWordSpacingKey,
            initialValue: widget.headlineProvider.value.letterSpacing!,
            min: minLetterSpacing,
            max: maxLetterSpacing,
            notifierCallback: widget.headlineProvider.setLetterSpacing,
            style: widget.bodyProvider.value,
            icon: _letterIcon(),
            tooltip: widget.config.ezL10n.tsLetterSpacing,
          ),
        EzTextSettingType.title => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}letter_spacing_title'),
            configKey: widget.config.isDark ? darkTitleWordSpacingKey : lightTitleWordSpacingKey,
            initialValue: widget.titleProvider.value.letterSpacing!,
            min: minLetterSpacing,
            max: maxLetterSpacing,
            notifierCallback: widget.titleProvider.setLetterSpacing,
            style: widget.bodyProvider.value,
            icon: _letterIcon(),
            tooltip: widget.config.ezL10n.tsLetterSpacing,
          ),
        EzTextSettingType.body => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}letter_spacing_body'),
            configKey: widget.config.isDark ? darkBodyWordSpacingKey : lightBodyWordSpacingKey,
            initialValue: widget.bodyProvider.value.letterSpacing!,
            min: minLetterSpacing,
            max: maxLetterSpacing,
            notifierCallback: widget.bodyProvider.setLetterSpacing,
            style: widget.bodyProvider.value,
            icon: _letterIcon(),
            tooltip: widget.config.ezL10n.tsLetterSpacing,
          ),
        EzTextSettingType.label => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}letter_spacing_label'),
            configKey: widget.config.isDark ? darkLabelWordSpacingKey : lightLabelWordSpacingKey,
            initialValue: widget.labelProvider.value.letterSpacing!,
            min: minLetterSpacing,
            max: maxLetterSpacing,
            notifierCallback: widget.labelProvider.setLetterSpacing,
            style: widget.bodyProvider.value,
            icon: _letterIcon(),
            tooltip: widget.config.ezL10n.tsLetterSpacing,
          ),
      };

  Widget _wordIcon() => EzTextBackground(
        widget.config,
        text: Icon(
          Icons.space_bar_sharp,
          color: widget.config.colors.onSurface,
          size: widget.labelProvider.value.fontSize,
        ),
        borderRadius: widget.config.textFieldRadius,
      );

  /// Word spacing setting
  EzFontDoubleSetting wordSpacingController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}word_spacing_display'),
            configKey:
                widget.config.isDark ? darkDisplayWordSpacingKey : lightDisplayWordSpacingKey,
            initialValue: widget.displayProvider.value.wordSpacing!,
            min: minWordSpacing,
            max: maxWordSpacing,
            notifierCallback: widget.displayProvider.setWordSpacing,
            style: widget.bodyProvider.value,
            icon: _wordIcon(),
            tooltip: widget.config.ezL10n.tsWordSpacing,
          ),
        EzTextSettingType.headline => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}word_spacing_headline'),
            configKey:
                widget.config.isDark ? darkHeadlineWordSpacingKey : lightHeadlineWordSpacingKey,
            initialValue: widget.headlineProvider.value.wordSpacing!,
            min: minWordSpacing,
            max: maxWordSpacing,
            notifierCallback: widget.headlineProvider.setWordSpacing,
            style: widget.bodyProvider.value,
            icon: _wordIcon(),
            tooltip: widget.config.ezL10n.tsWordSpacing,
          ),
        EzTextSettingType.title => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}word_spacing_title'),
            configKey: widget.config.isDark ? darkTitleWordSpacingKey : lightTitleWordSpacingKey,
            initialValue: widget.titleProvider.value.wordSpacing!,
            min: minWordSpacing,
            max: maxWordSpacing,
            notifierCallback: widget.titleProvider.setWordSpacing,
            style: widget.bodyProvider.value,
            icon: _wordIcon(),
            tooltip: widget.config.ezL10n.tsWordSpacing,
          ),
        EzTextSettingType.body => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}word_spacing_body'),
            configKey: widget.config.isDark ? darkBodyWordSpacingKey : lightBodyWordSpacingKey,
            initialValue: widget.bodyProvider.value.wordSpacing!,
            min: minWordSpacing,
            max: maxWordSpacing,
            notifierCallback: widget.bodyProvider.setWordSpacing,
            style: widget.bodyProvider.value,
            icon: _wordIcon(),
            tooltip: widget.config.ezL10n.tsWordSpacing,
          ),
        EzTextSettingType.label => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}word_spacing_label'),
            configKey: widget.config.isDark ? darkLabelWordSpacingKey : lightLabelWordSpacingKey,
            initialValue: widget.labelProvider.value.wordSpacing!,
            min: minWordSpacing,
            max: maxWordSpacing,
            notifierCallback: widget.labelProvider.setWordSpacing,
            style: widget.bodyProvider.value,
            icon: _wordIcon(),
            tooltip: widget.config.ezL10n.tsWordSpacing,
          ),
      };

  Widget _lineIcon() => EzTextBackground(
        widget.config,
        text: Icon(
          Icons.format_line_spacing_sharp,
          color: widget.config.colors.onSurface,
          size: widget.labelProvider.value.fontSize,
        ),
        borderRadius: widget.config.textFieldRadius,
      );

  /// Line height setting
  EzFontDoubleSetting lineHeightController(EzTextSettingType source) => switch (source) {
        EzTextSettingType.display => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}line_height_display'),
            configKey: widget.config.isDark ? darkDisplayFontHeightKey : lightDisplayFontHeightKey,
            initialValue: widget.displayProvider.value.height!,
            min: minFontHeight,
            max: maxFontHeight,
            notifierCallback: widget.displayProvider.setHeight,
            style: widget.bodyProvider.value,
            icon: _lineIcon(),
            tooltip: widget.config.ezL10n.tsLineHeight,
          ),
        EzTextSettingType.headline => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}line_height_headline'),
            configKey:
                widget.config.isDark ? darkHeadlineFontHeightKey : lightHeadlineFontHeightKey,
            initialValue: widget.headlineProvider.value.height!,
            min: minFontHeight,
            max: maxFontHeight,
            notifierCallback: widget.headlineProvider.setHeight,
            style: widget.bodyProvider.value,
            icon: _lineIcon(),
            tooltip: widget.config.ezL10n.tsLineHeight,
          ),
        EzTextSettingType.title => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}line_height_title'),
            configKey: widget.config.isDark ? darkTitleFontHeightKey : lightTitleFontHeightKey,
            initialValue: widget.titleProvider.value.height!,
            min: minFontHeight,
            max: maxFontHeight,
            notifierCallback: widget.titleProvider.setHeight,
            style: widget.bodyProvider.value,
            icon: _lineIcon(),
            tooltip: widget.config.ezL10n.tsLineHeight,
          ),
        EzTextSettingType.body => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}line_height_body'),
            configKey: widget.config.isDark ? darkBodyFontHeightKey : lightBodyFontHeightKey,
            initialValue: widget.bodyProvider.value.height!,
            min: minFontHeight,
            max: maxFontHeight,
            notifierCallback: widget.bodyProvider.setHeight,
            style: widget.bodyProvider.value,
            icon: _lineIcon(),
            tooltip: widget.config.ezL10n.tsLineHeight,
          ),
        EzTextSettingType.label => EzFontDoubleSetting(
            widget.config,
            key: ValueKey<String>('${tS()}line_height_label'),
            configKey: widget.config.isDark ? darkLabelFontHeightKey : lightLabelFontHeightKey,
            initialValue: widget.labelProvider.value.height!,
            min: minFontHeight,
            max: maxFontHeight,
            notifierCallback: widget.labelProvider.setHeight,
            style: widget.bodyProvider.value,
            icon: _lineIcon(),
            tooltip: widget.config.ezL10n.tsLineHeight,
          ),
      };

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final EzSwapSpacer swapSpacer =
        EzSwapSpacer(widget.config.spacing, breakpoint: ScreenSize.medium);

    return EzCol(children: <Widget>[
      // Style selector
      EzScrollView(
        widget.config,
        scrollDirection: Axis.horizontal,
        primary: false,
        children: <Widget>[
          EzText(
            widget.config,
            text: widget.config.ezL10n.gEditing,
            style: widget.labelProvider.value,
            textAlign: TextAlign.center,
          ),
          widget.config.margin,
          EzDropdownMenu<EzTextSettingType>(
            widget.config,
            widthEntry: widget.config.ezL10n.tsHeadline,
            textStyle: widget.labelProvider.value,
            dropdownMenuEntries: EzTextSettingType.values
                .map((EzTextSettingType type) => DropdownMenuEntry<EzTextSettingType>(
                      value: type,
                      label: type.label(widget.config.ezL10n),
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
      widget.config.spacer,

      // Controls
      EzRowCol.sym(
        widget.config,
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
            widget.config,
            scrollDirection: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              boldController(editing),
              widget.config.rowSpacer,
              italicsController(editing),
              widget.config.rowSpacer,
              underlineController(editing),
            ],
          ),

          // Letter, word, and line spacing
          swapSpacer,
          EzScrollView(
            widget.config,
            scrollDirection: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              letterSpacingController(editing),
              widget.config.rowSpacer,
              wordSpacingController(editing),
              widget.config.rowSpacer,
              lineHeightController(editing),
            ],
          ),
        ],
      ),
      widget.config.separator,

      // Display preview
      EzRichText(
        widget.config,
        children: <InlineSpan>[
          EzPlainText(text: widget.config.ezL10n.tsDisplayP1),
          EzInlineLink(
            widget.config,
            text: widget.config.ezL10n.tsDisplayLink,
            style: widget.displayProvider.value,
            textAlign: TextAlign.center,
            onTap: () => setState(() => editing = EzTextSettingType.display),
            hint: widget.config.ezL10n.tsLinkHint(widget.config.ezL10n.tsDisplay.toLowerCase()),
          ),
          EzPlainText(text: widget.config.ezL10n.tsDisplayP2),
        ],
        style: widget.displayProvider.value,
        textAlign: TextAlign.center,
        baseColor: widget.config.colors.surface,
        borderRadius: widget.config.textRadius,
      ),
      widget.config.centerLine,

      // Headline preview
      EzRichText(
        widget.config,
        children: <InlineSpan>[
          EzPlainText(text: widget.config.ezL10n.tsHeadlineP1),
          EzInlineLink(
            widget.config,
            text: widget.config.ezL10n.tsHeadlineLink,
            style: widget.headlineProvider.value,
            textAlign: TextAlign.center,
            onTap: () => setState(() => editing = EzTextSettingType.headline),
            hint: widget.config.ezL10n.tsLinkHint(widget.config.ezL10n.tsHeadline.toLowerCase()),
          ),
          EzPlainText(text: widget.config.ezL10n.tsHeadlineP2),
        ],
        style: widget.headlineProvider.value,
        textAlign: TextAlign.center,
        baseColor: widget.config.colors.surface,
        borderRadius: widget.config.textRadius,
      ),
      widget.config.centerLine,

      // Title preview
      EzRichText(
        widget.config,
        children: <InlineSpan>[
          EzPlainText(text: widget.config.ezL10n.tsTitleP1),
          EzInlineLink(
            widget.config,
            text: widget.config.ezL10n.tsTitleLink,
            style: widget.titleProvider.value,
            textAlign: TextAlign.center,
            onTap: () => setState(() => editing = EzTextSettingType.title),
            hint: widget.config.ezL10n.tsLinkHint(widget.config.ezL10n.tsTitle.toLowerCase()),
          ),
        ],
        style: widget.titleProvider.value,
        textAlign: TextAlign.center,
        baseColor: widget.config.colors.surface,
        borderRadius: widget.config.textRadius,
      ),
      widget.config.centerLine,

      // Body preview
      EzRichText(
        widget.config,
        children: <InlineSpan>[
          EzPlainText(text: widget.config.ezL10n.tsBodyP1),
          EzInlineLink(
            widget.config,
            text: widget.config.ezL10n.tsBodyLink,
            style: widget.bodyProvider.value,
            textAlign: TextAlign.center,
            onTap: () => setState(() => editing = EzTextSettingType.body),
            hint: widget.config.ezL10n.tsLinkHint(widget.config.ezL10n.tsBody.toLowerCase()),
          ),
          EzPlainText(text: widget.config.ezL10n.tsBodyP2),
        ],
        style: widget.bodyProvider.value,
        textAlign: TextAlign.center,
        baseColor: widget.config.colors.surface,
        borderRadius: widget.config.textRadius,
      ),
      widget.config.centerLine,

      // Label preview
      EzRichText(
        widget.config,
        children: <InlineSpan>[
          EzPlainText(text: widget.config.ezL10n.tsLabelP1),
          EzInlineLink(
            widget.config,
            text: widget.config.ezL10n.tsLabelLink,
            style: widget.labelProvider.value,
            textAlign: TextAlign.center,
            onTap: () => setState(() => editing = EzTextSettingType.label),
            hint: widget.config.ezL10n.tsLinkHint(widget.config.ezL10n.tsLabel.toLowerCase()),
          ),
          EzPlainText(text: widget.config.ezL10n.tsLabelP2),
        ],
        style: widget.labelProvider.value,
        textAlign: TextAlign.center,
        baseColor: widget.config.colors.surface,
        borderRadius: widget.config.textRadius,
      ),

      // Reset all
      widget.config.separator,
      EzResetButton(
        widget.config,
        all: false,
        dynamicTitle: () =>
            widget.config.ezL10n.tsReset(ezThemeString(widget.config, bothable: false)),
        onConfirm: () async {
          if (widget.config.isDark) {
            await EzCM.removeKeys(darkTextKeys.keys.toSet());
            await EzCM.remove(darkOnSurfaceKey);
          } else {
            await EzCM.removeKeys(lightTextKeys.keys.toSet());
            await EzCM.remove(lightOnSurfaceKey);
          }

          setState(() => editing = EzTextSettingType.display);
        },
      ),
    ]);
  }
}
