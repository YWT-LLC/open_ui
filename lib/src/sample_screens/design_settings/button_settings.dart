/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class ButtonDesign extends StatelessWidget {
  final List<Widget>? prepend;
  final List<Widget>? append;
  final String? styleLabel;
  final Widget resetSpacer;
  final Set<String>? resetExtraDark;
  final Set<String>? resetExtraLight;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  const ButtonDesign({
    super.key,
    required this.prepend,
    required this.append,
    this.styleLabel,
    this.resetSpacer = const EzSeparator(),
    required this.resetExtraDark,
    required this.resetExtraLight,
    required this.resetSkip,
    required this.saveSkip,
  });

  // Return the build //
  @override
  Widget build(BuildContext context) => EzCol(children: <Widget>[
        // Optional 'before' settings
        if (prepend != null) ...prepend!,

        // Padding
        const EzPaddingSetting(),
        EzConfig.spacer,

        // Button style
        _ButtonStyleSetting(styleLabel),
        EzConfig.separator,

        // Underline links
        EzSwitchPair(
          text: EzConfig.l10n.dsAlwaysUnderline,
          clickable: true,
          valueKey: EzConfig.isDark ? darkLineLinksKey : lightLineLinksKey,
          afterChanged: (bool? value) async {
            if (value == null) return;
            if (EzConfig.updateBoth) {
              await EzConfig.setBool(EzConfig.isDark ? lightLineLinksKey : darkLineLinksKey, value);
            }

            await EzConfig.rebuildUI();
          },
        ),
        EzConfig.spacer,

        // Show back FAB
        EzSwitchPair(
          text: EzConfig.l10n.dsShowBack,
          valueKey: EzConfig.isDark ? darkShowBackFABKey : lightShowBackFABKey,
          afterChanged: (bool? value) async {
            if (value == null) return;
            if (EzConfig.updateBoth) {
              await EzConfig.setBool(
                  EzConfig.isDark ? lightShowBackFABKey : darkShowBackFABKey, value);
            }

            await EzConfig.rebuildUI();
          },
        ),
        EzConfig.spacer,

        // Show scroll
        EzSwitchPair(
          valueKey: EzConfig.isDark ? darkShowScrollKey : lightShowScrollKey,
          afterChanged: (bool? value) async {
            if (value == null) return;
            if (EzConfig.updateBoth) {
              await EzConfig.setBool(
                  EzConfig.isDark ? lightShowScrollKey : darkShowScrollKey, value);
            }

            await EzConfig.rebuildUI();
          },
          text: EzConfig.l10n.dsShowScroll,
        ),

        if (append != null) ...append!,

        // Local reset all
        resetSpacer,
        EzResetButton(
          all: false,
          dynamicTitle: () => EzConfig.l10n.dsResetButton(ezThemeString(true)),
          onConfirm: () async {
            if (EzConfig.updateBoth || EzConfig.isDark) {
              await EzConfig.removeKeys(darkButtonDesignKeys.keys.toSet());
              if (resetExtraDark != null) {
                await EzConfig.removeKeys(resetExtraDark!);
              }
            }

            if (EzConfig.updateBoth || !EzConfig.isDark) {
              await EzConfig.removeKeys(lightButtonDesignKeys.keys.toSet());
              if (resetExtraLight != null) {
                await EzConfig.removeKeys(resetExtraLight!);
              }
            }
          },
          resetSkip: resetSkip,
          saveSkip: saveSkip,
        ),
      ]);
}

class _ButtonStyleSetting extends StatelessWidget {
  final String? label;

  const _ButtonStyleSetting(this.label);

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        onPressed: () async {
          EzButtonShape currShape = EzConfig.buttonShape;
          double currWidth = EzConfig.borderWidth;

          await ezModal(
            context: context,
            builder: (_) => StatefulBuilder(
              builder: (_, StateSetter setModal) => ezModalScroll(<Widget>[
                // Shape choices
                RadioGroup<EzButtonShape>(
                  groupValue: currShape,
                  onChanged: (EzButtonShape? choice) {
                    if (choice != null) setModal(() => currShape = choice);
                  },
                  child: EzScrollView(
                    scrollDirection: Axis.horizontal,
                    thumbVisibility: false,
                    showScrollHint: true,
                    children: EzButtonShape.values
                        .map(
                          (EzButtonShape shape) => Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: EzConfig.spacing,
                              horizontal: EzConfig.spacing / 2,
                            ),
                            child: EzCol(children: <Widget>[
                              EzElevatedButton(
                                text: shape.name,
                                style: ElevatedButton.styleFrom(
                                  side: currWidth == 0
                                      ? BorderSide.none
                                      : BorderSide(
                                          color: EzConfig.colors.primaryContainer,
                                          width: currWidth,
                                        ),
                                  shape: shape.shape,
                                ),
                                onPressed: () async {
                                  if (EzConfig.updateBoth || EzConfig.isDark) {
                                    await EzConfig.setString(darkButtonShapeKey, shape.value);
                                  }
                                  if (EzConfig.updateBoth || !EzConfig.isDark) {
                                    await EzConfig.setString(lightButtonShapeKey, shape.value);
                                  }

                                  setModal(() => currShape = shape);
                                },
                              ),
                              EzConfig.margin,
                              ExcludeSemantics(child: EzRadio<EzButtonShape>(value: shape)),
                            ]),
                          ),
                        )
                        .toList(),
                  ),
                ),
                EzConfig.spacer,

                // Border width slider
                Text(
                  EzConfig.l10n.dsBorderWidth,
                  style: EzConfig.styles.bodyLarge,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
                  child: Slider(
                    // Slider values
                    value: currWidth,
                    min: minBorderWidth,
                    max: maxBorderWidth,
                    divisions: 30,
                    label: currWidth.toStringAsFixed(2),

                    // Slider functions
                    onChanged: (double value) => setModal(() => currWidth = value),
                    onChangeEnd: (double value) async {
                      if (EzConfig.updateBoth || EzConfig.isDark) {
                        await EzConfig.setDouble(darkBorderWidthKey, value);
                      }

                      if (EzConfig.updateBoth || !EzConfig.isDark) {
                        await EzConfig.setDouble(lightBorderWidthKey, value);
                      }
                    },
                  ),
                ),
                EzConfig.spacer,

                // Reset button
                EzElevatedIconButton(
                  onPressed: () async {
                    if (EzConfig.updateBoth || EzConfig.isDark) {
                      await EzConfig.remove(darkButtonShapeKey);
                      await EzConfig.remove(darkBorderWidthKey);
                    }
                    if (EzConfig.updateBoth || !EzConfig.isDark) {
                      await EzConfig.remove(lightButtonShapeKey);
                      await EzConfig.remove(lightBorderWidthKey);
                    }

                    setModal(() {
                      currShape = EBSConfig.lookup(EzConfig.getDefault(
                          EzConfig.isDark ? darkButtonShapeKey : lightButtonShapeKey));
                      currWidth = EzConfig.getDefault(
                          EzConfig.isDark ? darkBorderWidthKey : lightBorderWidthKey);
                    });
                  },
                  icon: EzIcon(Icons.refresh),
                  label: EzConfig.l10n.gReset,
                ),
                EzConfig.separator,
              ]),
            ),
          );

          if (currShape != EzConfig.buttonShape || currWidth != EzConfig.borderWidth) {
            await EzConfig.rebuildUI();
          }
        },
        label: label ?? EzConfig.l10n.dsStyle,
        icon: EzIcon(Icons.edit),
      );
}
