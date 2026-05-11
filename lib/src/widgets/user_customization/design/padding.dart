/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzPaddingSetting extends StatelessWidget {
  final int _steps;
  final int _decimals;

  /// An ez to use padding setting
  const EzPaddingSetting({super.key})
      : _steps = 20,
        _decimals = 0;

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String configKey = EzConfig.isDark ? darkPaddingKey : lightPaddingKey;
    final double defaultValue = EzConfig.getDefault(configKey);

    double currValue = EzConfig.get(configKey);

    // Return the build //

    return EzElevatedIconButton(
      onPressed: () async {
        final double backup = currValue;

        await ezModal(
          context: context,
          builder: (_) => StatefulBuilder(
            builder: (_, StateSetter setModal) => ezModalScroll(<Widget>[
              // Preview
              Semantics(
                button: false,
                readOnly: true,
                label: EzConfig.l10n.gSetToValue(
                  EzConfig.l10n.dsPadding,
                  currValue.toStringAsFixed(_decimals),
                ),
                child: ExcludeSemantics(
                  child: EzCol(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Title
                      Text(
                        EzConfig.l10n.dsPadding,
                        style: EzConfig.styles.titleLarge,
                        textAlign: TextAlign.center,
                      ),

                      // Preview
                      EzConfig.spacer,
                      EzScrollView(
                        scrollDirection: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          EzElevatedButton(
                            enabled: false,
                            style: ElevatedButton.styleFrom(padding: EdgeInsets.all(currValue)),
                            text: EzConfig.l10n.gCurrently,
                          ),
                          EzConfig.rowSpacer,
                          EzElevatedButton(
                            enabled: false,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(currValue),
                              shape: const CircleBorder(),
                            ),
                            text: currValue.toStringAsFixed(_decimals),
                          ),
                        ],
                      ),
                      EzConfig.spacer,
                    ],
                  ),
                ),
              ),

              // Slider
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
                child: Slider(
                  // Slider values
                  value: currValue,
                  min: minPadding,
                  max: maxPadding,
                  divisions: _steps,

                  // Slider functions
                  onChanged: (double value) => setModal(() => currValue = value),
                  onChangeEnd: (double value) async {
                    await EzConfig.setDouble(configKey, value);
                    if (EzConfig.updateBoth) {
                      await EzConfig.setDouble(
                          EzConfig.isDark ? lightPaddingKey : darkPaddingKey, value);
                    }
                  },

                  // Slider semantics
                  semanticFormatterCallback: (double value) => value.toStringAsFixed(_decimals),
                ),
              ),
              EzConfig.spacer,

              // Reset button
              EzElevatedIconButton(
                onPressed: () async {
                  await EzConfig.remove(configKey);
                  if (EzConfig.updateBoth) {
                    await EzConfig.remove(EzConfig.isDark ? lightPaddingKey : darkPaddingKey);
                  }
                  setModal(() => currValue = defaultValue);
                },
                icon: const Icon(Icons.refresh),
                label: '${EzConfig.l10n.gResetTo} ${defaultValue.toStringAsFixed(_decimals)}',
              ),
              EzConfig.separator,
            ]),
          ),
        );

        if (currValue != backup) await EzConfig.rebuildUI();
      },
      icon: const Icon(Icons.padding),
      label: EzConfig.l10n.dsPadding,
    );
  }
}
