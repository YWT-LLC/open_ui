/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class QuickTextSettings extends StatefulWidget {
  // Providers
  final EzDisplayStyleProvider displayProvider;
  final EzHeadlineStyleProvider headlineProvider;
  final EzTitleStyleProvider titleProvider;
  final EzBodyStyleProvider bodyProvider;
  final EzLabelStyleProvider labelProvider;

  const QuickTextSettings({
    super.key,
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
  });

  @override
  State<QuickTextSettings> createState() => _QuickTextSettingsState();
}

class _QuickTextSettingsState extends State<QuickTextSettings> {
  // Gather the build data //

  late double backOpacity = EzConfig.textBackgroundOpacity;

  late Color buttonBackground = EzConfig.colors.surface.withValues(alpha: backOpacity);
  late Color textBackground = EzConfig.colors.surfaceContainer.withValues(alpha: backOpacity);

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final EdgeInsets colMargin = EzInsets.col(EzConfig.marginVal);
    final EdgeInsets wrapPadding = EdgeInsets.only(
      left: EzConfig.spacing / 2,
      right: EzConfig.spacing / 2,
      bottom: EzConfig.spacing,
    );

    // Return the build //

    return EzCol(children: <Widget>[
      // Required batch settings
      EzWrap(children: <Widget>[
        // Font family
        Padding(
          padding: wrapPadding,
          child: EzFontFamilyBatchSetting(
            displayProvider: widget.displayProvider,
            headlineProvider: widget.headlineProvider,
            titleProvider: widget.titleProvider,
            bodyProvider: widget.bodyProvider,
            labelProvider: widget.labelProvider,
          ),
        ),

        // Font size
        Padding(
          padding: wrapPadding,
          child: EzTextBackground(
            EzFontDoubleBatchSetting(
              displayProvider: widget.displayProvider,
              headlineProvider: widget.headlineProvider,
              titleProvider: widget.titleProvider,
              bodyProvider: widget.bodyProvider,
              labelProvider: widget.labelProvider,
            ),
            backgroundColor: buttonBackground,
            buttonShape: true,
            padding: EdgeInsets.zero,
          ),
        ),
      ]),

      EzConfig.spacer,
      // Display preview
      EzTextBackground(
        Text(
          EzConfig.l10n.tsDisplayP1 + EzConfig.l10n.tsDisplayLink + EzConfig.l10n.tsDisplayP2,
          textAlign: TextAlign.center,
          style: widget.displayProvider.value,
        ),
        backgroundColor: textBackground,
        padding: colMargin,
      ),
      EzConfig.spacer,

      // Headline preview
      EzTextBackground(
        Text(
          EzConfig.l10n.tsHeadlineP1 + EzConfig.l10n.tsHeadlineLink + EzConfig.l10n.tsHeadlineP2,
          textAlign: TextAlign.center,
          style: widget.headlineProvider.value,
        ),
        backgroundColor: textBackground,
        padding: colMargin,
      ),
      EzConfig.spacer,

      // Title preview
      EzTextBackground(
        Text(
          EzConfig.l10n.tsTitleP1 + EzConfig.l10n.tsTitleLink,
          textAlign: TextAlign.center,
          style: widget.titleProvider.value,
        ),
        backgroundColor: textBackground,
        padding: colMargin,
      ),
      EzConfig.spacer,

      // Body preview
      EzTextBackground(
        Text(
          EzConfig.l10n.tsBodyP1 + EzConfig.l10n.tsBodyLink + EzConfig.l10n.tsBodyP2,
          textAlign: TextAlign.center,
          style: widget.bodyProvider.value,
        ),
        backgroundColor: textBackground,
        padding: colMargin,
      ),
      EzConfig.spacer,

      // Label preview
      EzTextBackground(
        Text(
          EzConfig.l10n.tsLabelP1 + EzConfig.l10n.tsLabelLink + EzConfig.l10n.tsLabelP2,
          textAlign: TextAlign.center,
          style: widget.labelProvider.value,
        ),
        backgroundColor: textBackground,
        padding: colMargin,
      ),
      EzConfig.divider,

      // Text background opacity
      EzTextBackground(
        Text(
          EzConfig.l10n.tsTextBackground,
          style: widget.labelProvider.value,
          textAlign: TextAlign.center,
        ),
        backgroundColor: textBackground,
        padding: colMargin,
      ),
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
        child: Slider(
          // Slider values
          value: backOpacity,
          min: minOpacity,
          max: maxOpacity,
          divisions: 20,
          label: backOpacity.toStringAsFixed(2),

          // Slider functions
          onChanged: (double value) {
            setState(() {
              backOpacity = value;
              buttonBackground = EzConfig.colors.surface.withValues(alpha: backOpacity);
              textBackground = EzConfig.colors.surfaceContainer.withValues(alpha: backOpacity);
            });
          },
          onChangeEnd: (double value) async {
            if (EzConfig.updateBoth || EzConfig.isDark) {
              await EzConfig.setDouble(darkTextBackgroundOpacityKey, value);
            }
            if (EzConfig.updateBoth || !EzConfig.isDark) {
              await EzConfig.setDouble(lightTextBackgroundOpacityKey, value);
            }

            if (context.mounted) {
              EzConfig.pingRebuild(
                  ezTextRebuildCheck(context) || (value != EzConfig.textBackgroundOpacity));
            }
          },

          // Slider semantics
          semanticFormatterCallback: (double value) => value.toStringAsFixed(2),
        ),
      ),
      EzConfig.spacer,

      // Icon size
      EzIconSizeSetting(backgroundColor: buttonBackground),

      // Reset all
      EzConfig.separator,
      EzResetButton(
        all: false,
        dynamicTitle: () => EzConfig.l10n.tsReset(ezThemeString(true)),
        onConfirm: () async {
          if (EzConfig.updateBoth || EzConfig.isDark) {
            await EzConfig.removeKeys(darkTextKeys.keys.toSet());
            await EzConfig.remove(darkOnSurfaceKey);
          }

          if (EzConfig.updateBoth || !EzConfig.isDark) {
            await EzConfig.removeKeys(lightTextKeys.keys.toSet());
            await EzConfig.remove(lightOnSurfaceKey);
          }
        },
      ),
    ]);
  }
}
