/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';

/// 0.1
const double _delta = 0.1;

const List<String> _darkKeys = <String>[
  darkDisplayFontSizeKey,
  darkHeadlineFontSizeKey,
  darkTitleFontSizeKey,
  darkBodyFontSizeKey,
  darkLabelFontSizeKey,
];

const List<String> _lightKeys = <String>[
  lightDisplayFontSizeKey,
  lightHeadlineFontSizeKey,
  lightTitleFontSizeKey,
  lightBodyFontSizeKey,
  lightLabelFontSizeKey,
];

class EzFontDoubleBatchSetting extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Required for max/min awareness
  final EzDisplayStyleProvider displayProvider;

  /// Required for max/min awareness
  final EzHeadlineStyleProvider headlineProvider;

  /// Required for max/min awareness
  final EzTitleStyleProvider titleProvider;

  /// Required for max/min awareness
  final EzBodyStyleProvider bodyProvider;

  /// Required for max/min awareness
  final EzLabelStyleProvider labelProvider;

  /// Amount to scale (relative to the default value) on each click
  final double delta;

  final double? _iconSize;

  /// Must have each iteration of [EzTextStyleProvider] in this parent's widget tree
  /// Updates all [TextStyle.fontSize]s at once by [delta], calculated individually based on each [TextStyle.fontSize]s default value
  /// Follows [EzCM] limits: [minDisplay], [minHeadline], [maxTitle], etc.
  EzFontDoubleBatchSetting(
    this.config, {
    super.key,
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
    this.delta = _delta,
  }) : _iconSize = titleProvider.value.fontSize;

  // Define the build data //

  final bool atMax = fontSizeMaxes.entries.every(
    (MapEntry<String, double> max) => max.value == EzCM.get(max.key),
  );

  final bool atMin = fontSizeMins.entries.every(
    (MapEntry<String, double> min) => min.value == EzCM.get(min.key),
  );

  // Define custom functions //

  EzTextStyleProvider providerFromKey(String key) => switch (key) {
    darkDisplayFontSizeKey || lightDisplayFontSizeKey => displayProvider,
    darkHeadlineFontSizeKey || lightHeadlineFontSizeKey => headlineProvider,
    darkTitleFontSizeKey || lightTitleFontSizeKey => titleProvider,
    darkBodyFontSizeKey || lightBodyFontSizeKey => bodyProvider,
    darkLabelFontSizeKey || lightLabelFontSizeKey => labelProvider,
    _ => throw Exception('Invalid key: $key'),
  };

  // Return the build //

  @override
  Widget build(BuildContext context) => Tooltip(
    message: config.ezL10n.tsFontSize,
    child: EzRow(
      config,
      reverseHands: false,
      children: <Widget>[
        // Minus icon
        atMin
            ? EzIconButton(
                config,
                enabled: false,
                tooltip: config.ezL10n.gMinimum,
                iconSize: _iconSize,
                icon: Icon(Icons.remove, color: config.colors.outline),
              )
            : EzIconButton(
                config,
                onPressed: () async {
                  if (EzCM.updateBoth || config.isDark) {
                    for (final String key in _darkKeys) {
                      final EzTextStyleProvider provider = providerFromKey(key);

                      final double currSize = provider.value.fontSize ?? EzCM.get(key);

                      if (currSize != fontSizeMins[key]) {
                        final double newSize = currSize - (fontSizeDefaults[key]! * delta);
                        final double sizeLimit = fontSizeMins[key]!;

                        if (newSize >= sizeLimit) {
                          await EzCM.setDouble(key, newSize);
                          provider.resize(newSize);
                        } else {
                          await EzCM.setDouble(key, sizeLimit);
                          provider.resize(sizeLimit);
                        }
                      }
                    }
                  }

                  if (EzCM.updateBoth || !config.isDark) {
                    for (final String key in _lightKeys) {
                      final EzTextStyleProvider provider = providerFromKey(key);

                      final double currSize = provider.value.fontSize ?? EzCM.get(key);

                      if (currSize != fontSizeMins[key]) {
                        final double newSize = currSize - (fontSizeDefaults[key]! * delta);
                        final double sizeLimit = fontSizeMins[key]!;

                        if (newSize >= sizeLimit) {
                          await EzCM.setDouble(key, newSize);
                          provider.resize(newSize);
                        } else {
                          await EzCM.setDouble(key, sizeLimit);
                          provider.resize(sizeLimit);
                        }
                      }
                    }
                  }

                  if (context.mounted) {
                    config.pingRebuild(ezTextRebuildCheck(config, context: context));
                  }
                },
                tooltip: '${config.ezL10n.gDecrease} ${config.ezL10n.tsFontSize.toLowerCase()}',
                iconSize: _iconSize,
                icon: const Icon(Icons.remove),
              ),
        config.rowMargin,

        // Core
        GestureDetector(
          onLongPress: () async {
            if (EzCM.updateBoth || config.isDark) {
              for (final String key in _darkKeys) {
                final EzTextStyleProvider provider = providerFromKey(key);

                await EzCM.setDouble(key, fontSizeDefaults[key]!);
                provider.resize(fontSizeDefaults[key]!);
              }
            }

            if (EzCM.updateBoth || !config.isDark) {
              for (final String key in _lightKeys) {
                final EzTextStyleProvider provider = providerFromKey(key);

                await EzCM.setDouble(key, fontSizeDefaults[key]!);
                provider.resize(fontSizeDefaults[key]!);
              }
            }

            if (context.mounted) {
              config.pingRebuild(ezTextRebuildCheck(config, context: context));
            }
          },
          child: Icon(Icons.text_fields_sharp, size: _iconSize, color: config.colors.onSurface),
        ),
        config.rowMargin,

        // Plus icon
        atMax
            ? EzIconButton(
                config,
                enabled: false,
                tooltip: config.ezL10n.gMaximum,
                iconSize: _iconSize,
                icon: Icon(Icons.add, color: config.colors.outline),
              )
            : EzIconButton(
                config,
                onPressed: () async {
                  if (EzCM.updateBoth || config.isDark) {
                    for (final String key in _darkKeys) {
                      final EzTextStyleProvider provider = providerFromKey(key);

                      final double currSize = provider.value.fontSize ?? EzCM.get(key);

                      if (currSize != fontSizeMaxes[key]) {
                        final double newSize = currSize + (fontSizeDefaults[key]! * delta);
                        final double sizeLimit = fontSizeMaxes[key]!;

                        if (newSize <= sizeLimit) {
                          await EzCM.setDouble(key, newSize);
                          provider.resize(newSize);
                        } else {
                          await EzCM.setDouble(key, sizeLimit);
                          provider.resize(sizeLimit);
                        }
                      }
                    }
                  }

                  if (EzCM.updateBoth || !config.isDark) {
                    for (final String key in _lightKeys) {
                      final EzTextStyleProvider provider = providerFromKey(key);

                      final double currSize = provider.value.fontSize ?? EzCM.get(key);

                      if (currSize != fontSizeMaxes[key]) {
                        final double newSize = currSize + (fontSizeDefaults[key]! * delta);
                        final double sizeLimit = fontSizeMaxes[key]!;

                        if (newSize <= sizeLimit) {
                          await EzCM.setDouble(key, newSize);
                          provider.resize(newSize);
                        } else {
                          await EzCM.setDouble(key, sizeLimit);
                          provider.resize(sizeLimit);
                        }
                      }
                    }
                  }

                  if (context.mounted) {
                    config.pingRebuild(ezTextRebuildCheck(config, context: context));
                  }
                },
                tooltip: '${config.ezL10n.gIncrease} ${config.ezL10n.tsFontSize.toLowerCase()}',
                iconSize: _iconSize,
                icon: const Icon(Icons.add),
              ),
      ],
    ),
  );
}
