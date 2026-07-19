/* empathetech_flutter_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSpacingSetting extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  final int _steps;
  final int _decimals;

  /// An easy to use spacing setting
  const EzSpacingSetting(this.config, {super.key})
      : _steps = 26,
        _decimals = 1;

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String configKey = config.isDark ? darkSpacingKey : lightSpacingKey;
    final double defaultValue = EzCM.getDefault(configKey);

    double currValue = EzCM.get(configKey);

    // Return the build //

    return EzElevatedIconButton(
      config,
      onPressed: () async {
        final double backup = currValue;

        await ezModal(
          config,
          context: context,
          builder: (_) => StatefulBuilder(
            builder: (_, StateSetter setModal) => ezModalScroll(config, children: <Widget>[
              // Preview
              Semantics(
                button: false,
                readOnly: true,
                label: config.ezL10n.gSetToValue(
                  config.ezL10n.dsSpacing,
                  currValue.toStringAsFixed(_decimals),
                ),
                child: ExcludeSemantics(
                  child: EzCol(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Title
                      Text(
                        config.ezL10n.dsSpacing,
                        style: config.titleStyle,
                        textAlign: TextAlign.center,
                      ),
                      EzSpacer(currValue),

                      // Vertical preview
                      EzElevatedButton(
                        config,
                        enabled: false,
                        text: config.ezL10n.gValue,
                      ),

                      // Divider preview
                      EzDivider(currValue * 3),

                      // Horizontal preview
                      EzScrollView(
                        config,
                        scrollDirection: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          EzElevatedButton(
                            config,
                            enabled: false,
                            text: config.ezL10n.gCurrently,
                          ),
                          EzSpacer(currValue, vertical: false),
                          EzElevatedButton(
                            config,
                            enabled: false,
                            text: currValue.toStringAsFixed(_decimals),
                          ),
                        ],
                      ),
                      EzSpacer(currValue),
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
                    await EzCM.setDouble(configKey, value);

                    if (EzCM.updateBoth) {
                      await EzCM.setDouble(
                        config.isDark ? lightSpacingKey : darkSpacingKey,
                        value,
                      );
                    }
                  },

                  // Slider semantics
                  semanticFormatterCallback: (double value) => value.toStringAsFixed(_decimals),
                ),
              ),
              config.spacer,

              // Reset button
              EzElevatedIconButton(
                config,
                onPressed: () async {
                  await EzCM.remove(configKey);
                  if (EzCM.updateBoth) {
                    await EzCM.remove(config.isDark ? lightSpacingKey : darkSpacingKey);
                  }
                  setModal(() => currValue = defaultValue);
                },
                icon: EzIcon(config, Icons.refresh),
                label: '${config.ezL10n.gResetTo} ${defaultValue.toStringAsFixed(_decimals)}',
              ),
              config.separator,
            ]),
          ),
        );

        if (currValue != backup) await config.rebuildUI(<EzCacheType>{EzCacheType.design});
      },
      icon: EzIcon(config, Icons.space_bar),
      label: config.ezL10n.dsSpacing,
    );
  }
}
