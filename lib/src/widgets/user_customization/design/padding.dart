/* empathetech_flutter_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzPaddingSetting extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  final int _steps;
  final int _decimals;

  /// An ez to use padding setting
  const EzPaddingSetting(this.config, {super.key})
      : _steps = 20,
        _decimals = 0;

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String configKey = config.isDark ? darkPaddingKey : lightPaddingKey;
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
                  config.ezL10n.dsPadding,
                  currValue.toStringAsFixed(_decimals),
                ),
                child: ExcludeSemantics(
                  child: EzCol(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Title
                      Text(
                        config.ezL10n.dsPadding,
                        style: config.titleStyle,
                        textAlign: TextAlign.center,
                      ),

                      // Preview
                      config.spacer,
                      EzScrollView(
                        config,
                        scrollDirection: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          EzElevatedButton(
                            config,
                            enabled: false,
                            style: ElevatedButton.styleFrom(padding: EdgeInsets.all(currValue)),
                            text: config.ezL10n.gCurrently,
                          ),
                          config.rowSpacer,
                          EzElevatedButton(
                            config,
                            enabled: false,
                            style: ElevatedButton.styleFrom(padding: EdgeInsets.all(currValue)),
                            text: currValue.toStringAsFixed(_decimals),
                          ),
                        ],
                      ),
                      config.spacer,
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
                    await EzCM.setDouble(configKey, value);
                    if (EzCM.updateBoth) {
                      await EzCM.setDouble(config.isDark ? lightPaddingKey : darkPaddingKey, value);
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
                    await EzCM.remove(config.isDark ? lightPaddingKey : darkPaddingKey);
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
      icon: EzIcon(config, Icons.padding),
      label: config.ezL10n.dsPadding,
    );
  }
}
