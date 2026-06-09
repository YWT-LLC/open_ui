/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzMarginSetting extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  final int _steps;
  final int _decimals;

  /// An ez to use margin setting
  const EzMarginSetting(this.config, {super.key})
      : _steps = 20,
        _decimals = 1;

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String configKey = config.isDark ? darkMarginKey : lightMarginKey;
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
            builder: (BuildContext modalContext, StateSetter setModal) =>
                ezModalScroll(config, children: <Widget>[
              // Preview
              Semantics(
                button: false,
                readOnly: true,
                label: config.ezL10n.gSetToValue(
                  config.ezL10n.dsMargin,
                  currValue.toStringAsFixed(_decimals),
                ),
                child: ExcludeSemantics(
                  child: EzCol(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Title
                      Text(
                        config.ezL10n.dsMargin,
                        style: config.titleStyle,
                        textAlign: TextAlign.center,
                      ),

                      // Preview
                      config.spacer,
                      EzTextBackground(
                        config,
                        text: Text(
                          currValue.toStringAsFixed(_decimals),
                          style: config.bodyStyle,
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.all(currValue),
                      ),
                      Container(
                        color: config.colors.onSurface,
                        height: heightOf(modalContext) * 0.25,
                        width: widthOf(modalContext) * 0.25,
                        child: Container(
                          decoration: BoxDecoration(
                            color: config.colors.surface,
                            image: (config.backgroundImagePath == noImageValue)
                                ? null
                                : config.backgroundImage,
                          ),
                          margin: EdgeInsets.all(currValue * 0.25),
                        ),
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
                  min: minMargin,
                  max: maxMargin,
                  divisions: _steps,

                  // Slider functions
                  onChanged: (double value) => setModal(() => currValue = value),
                  onChangeEnd: (double value) async {
                    await EzCM.setDouble(configKey, value);
                    if (EzCM.updateBoth) {
                      await EzCM.setDouble(config.isDark ? lightMarginKey : darkMarginKey, value);
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
                    await EzCM.remove(config.isDark ? lightMarginKey : darkMarginKey);
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

        if (currValue != backup) await config.rebuildUI(<EzSettingType>{EzSettingType.design});
      },
      icon: EzIcon(config, Icons.margin),
      label: config.ezL10n.dsMargin,
    );
  }
}
