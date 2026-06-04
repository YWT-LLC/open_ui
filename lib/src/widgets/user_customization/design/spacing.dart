/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSpacingSetting extends StatelessWidget {
  final int _steps;
  final int _decimals;

  /// An easy to use spacing setting
  const EzSpacingSetting({super.key})
      : _steps = 26,
        _decimals = 1;

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String configKey = EzConfig.isDark ? darkSpacingKey : lightSpacingKey;
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
                  EzConfig.l10n.dsSpacing,
                  currValue.toStringAsFixed(_decimals),
                ),
                child: ExcludeSemantics(
                  child: EzCol(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Title
                      Text(
                        EzConfig.l10n.dsSpacing,
                        style: EzConfig.titleStyle,
                        textAlign: TextAlign.center,
                      ),
                      EzSpacer(space: currValue),

                      // Vertical preview
                      EzElevatedButton(
                        enabled: false,
                        text: EzConfig.l10n.gValue,
                      ),

                      // Divider preview
                      EzDivider(height: currValue * 3),

                      // Horizontal preview
                      EzScrollView(
                        scrollDirection: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          EzElevatedButton(
                            enabled: false,
                            text: EzConfig.l10n.gCurrently,
                          ),
                          EzSpacer(space: currValue, vertical: false),
                          EzElevatedButton(
                            enabled: false,
                            text: currValue.toStringAsFixed(_decimals),
                          ),
                        ],
                      ),
                      EzSpacer(space: currValue),
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
                  min: minSpacing,
                  max: maxSpacing,
                  divisions: _steps,

                  // Slider functions
                  onChanged: (double value) => setModal(() => currValue = value),
                  onChangeEnd: (double value) async {
                    await EzConfig.setDouble(configKey, value);

                    if (EzConfig.updateBoth) {
                      await EzConfig.setDouble(
                        EzConfig.isDark ? lightSpacingKey : darkSpacingKey,
                        value,
                      );
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
                    await EzConfig.remove(EzConfig.isDark ? lightSpacingKey : darkSpacingKey);
                  }
                  setModal(() => currValue = defaultValue);
                },
                icon: EzIcon(Icons.refresh),
                label: '${EzConfig.l10n.gResetTo} ${defaultValue.toStringAsFixed(_decimals)}',
              ),
              EzConfig.separator,
            ]),
          ),
        );

        if (currValue != backup) await EzConfig.rebuildUI();
      },
      icon: EzIcon(Icons.space_bar),
      label: EzConfig.l10n.dsSpacing,
    );
  }
}
