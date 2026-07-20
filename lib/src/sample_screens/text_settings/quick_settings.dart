/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class QuickTextSettings extends StatefulWidget {
  final EzCP config;

  // Providers
  final EzDisplayStyleProvider displayProvider;
  final EzHeadlineStyleProvider headlineProvider;
  final EzTitleStyleProvider titleProvider;
  final EzBodyStyleProvider bodyProvider;
  final EzLabelStyleProvider labelProvider;

  const QuickTextSettings(
    this.config, {
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

  late double backOpacity = widget.config.textBackgroundOpacity;

  late Color buttonBackground = widget.config.colors.surface.withValues(alpha: backOpacity);
  late Color textBackground = widget.config.colors.surfaceContainer.withValues(alpha: backOpacity);

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final EdgeInsets wrapPadding = EdgeInsets.only(
      left: widget.config.spacing / 2,
      right: widget.config.spacing / 2,
      bottom: widget.config.spacing,
    );

    // Return the build //

    return EzCol(
      children: <Widget>[
        // Required batch settings
        EzWrap(
          children: <Widget>[
            // Font family
            Padding(
              padding: wrapPadding,
              child: EzFontFamilyBatchSetting(
                widget.config,
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
                widget.config,
                text: EzFontDoubleBatchSetting(
                  widget.config,
                  displayProvider: widget.displayProvider,
                  headlineProvider: widget.headlineProvider,
                  titleProvider: widget.titleProvider,
                  bodyProvider: widget.bodyProvider,
                  labelProvider: widget.labelProvider,
                ),
                backgroundColor: buttonBackground,
                shape: widget.config.buttonShape,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
        widget.config.spacer,

        // Display preview
        EzText(
          widget.config,
          text:
              widget.config.ezL10n.tsDisplayP1 +
              widget.config.ezL10n.tsDisplayLink +
              widget.config.ezL10n.tsDisplayP2,
          textAlign: TextAlign.center,
          style: widget.displayProvider.value,
          backgroundColor: textBackground,
        ),
        widget.config.centerLine,

        // Headline preview
        EzText(
          widget.config,
          text:
              widget.config.ezL10n.tsHeadlineP1 +
              widget.config.ezL10n.tsHeadlineLink +
              widget.config.ezL10n.tsHeadlineP2,
          textAlign: TextAlign.center,
          style: widget.headlineProvider.value,
          backgroundColor: textBackground,
        ),
        widget.config.centerLine,

        // Title preview
        EzText(
          widget.config,
          text: widget.config.ezL10n.tsTitleP1 + widget.config.ezL10n.tsTitleLink,
          textAlign: TextAlign.center,
          style: widget.titleProvider.value,
          backgroundColor: textBackground,
        ),
        widget.config.centerLine,

        // Body preview
        EzText(
          widget.config,
          text:
              widget.config.ezL10n.tsBodyP1 +
              widget.config.ezL10n.tsBodyLink +
              widget.config.ezL10n.tsBodyP2,
          textAlign: TextAlign.center,
          style: widget.bodyProvider.value,
          backgroundColor: textBackground,
        ),
        widget.config.centerLine,

        // Label preview
        EzText(
          widget.config,
          text:
              widget.config.ezL10n.tsLabelP1 +
              widget.config.ezL10n.tsLabelLink +
              widget.config.ezL10n.tsLabelP2,
          textAlign: TextAlign.center,
          style: widget.labelProvider.value,
          backgroundColor: textBackground,
        ),
        widget.config.divider,

        // Text background opacity
        EzText(
          widget.config,
          text: widget.config.ezL10n.tsTextBackground,
          style: widget.labelProvider.value,
          textAlign: TextAlign.center,
          backgroundColor: textBackground,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
          child: Slider(
            // Slider values
            value: backOpacity,
            divisions: 20,
            label: backOpacity.toStringAsFixed(2),

            // Slider functions
            onChanged: (double value) {
              setState(() {
                backOpacity = value;
                buttonBackground = widget.config.colors.surface.withValues(alpha: backOpacity);
                textBackground = widget.config.colors.surfaceContainer.withValues(
                  alpha: backOpacity,
                );
              });
            },
            onChangeEnd: (double value) async {
              if (EzCM.updateBoth || widget.config.isDark) {
                await EzCM.setDouble(darkTextBackgroundOpacityKey, value);
              }
              if (EzCM.updateBoth || !widget.config.isDark) {
                await EzCM.setDouble(lightTextBackgroundOpacityKey, value);
              }

              if (context.mounted) {
                widget.config.pingRebuild(
                  ezTextRebuildCheck(widget.config, context: context) ||
                      (value != widget.config.textBackgroundOpacity),
                );
              }
            },

            // Slider semantics
            semanticFormatterCallback: (double value) => value.toStringAsFixed(2),
          ),
        ),
        widget.config.spacer,

        // Icon size
        EzIconSizeSetting(widget.config, backgroundColor: buttonBackground),

        // Reset all
        widget.config.separator,
        EzResetButton(
          widget.config,
          all: false,
          dynamicTitle: () =>
              widget.config.ezL10n.tsReset(ezThemeString(widget.config, bothable: true)),
          onConfirm: () async {
            if (EzCM.updateBoth || widget.config.isDark) {
              await EzCM.removeKeys(darkTextKeys.keys.toSet());
              await EzCM.remove(darkOnSurfaceKey);
            }

            if (EzCM.updateBoth || !widget.config.isDark) {
              await EzCM.removeKeys(lightTextKeys.keys.toSet());
              await EzCM.remove(lightOnSurfaceKey);
            }
          },
        ),
      ],
    );
  }
}
