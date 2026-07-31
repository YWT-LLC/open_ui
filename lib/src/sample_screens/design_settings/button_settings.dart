/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class ButtonDesign extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Extra settings at the beginning
  final List<Widget>? prepend;

  /// Extra settings at the end
  final List<Widget>? append;

  /// Optional style setting label override
  final String? styleLabel;

  /// Defaults to [EzCP.separator]
  final Widget? resetSpacer;

  /// Extra keys for [EzCM.reset]
  final Set<String>? resetExtraDark;

  /// Extra keys for [EzCM.reset]
  final Set<String>? resetExtraLight;

  /// Extra keys for [EzCM.reset]
  final Set<String>? resetSkip;

  /// Extra keys for [EzCM.reset]
  final Set<String>? saveSkip;

  const ButtonDesign(
    this.config, {
    super.key,
    required this.prepend,
    required this.append,
    this.styleLabel,
    this.resetSpacer,
    required this.resetExtraDark,
    required this.resetExtraLight,
    required this.resetSkip,
    required this.saveSkip,
  });

  @override
  State<StatefulWidget> createState() => _ButtonDesignState();
}

class _ButtonDesignState extends State<ButtonDesign> {
  late double iconSize = widget.config.iconSize;

  @override
  Widget build(BuildContext context) => EzCol(
        children: <Widget>[
          // Optional 'before' settings
          if (widget.prepend != null) ...widget.prepend!,

          // Icon size
          EzIconSizeSetting(
            widget.config,
            onChanged: (double size) => setState(() => iconSize = size),
          ),
          widget.config.spacer,

          // Padding
          EzPaddingSetting(widget.config, iconSize: iconSize),
          widget.config.spacer,

          // Button style
          _ButtonStyleSetting(
            widget.config,
            styleLabel: widget.styleLabel,
            iconSize: iconSize,
          ),
          widget.config.separator,

          // Underline links
          EzSwitchPair(
            widget.config,
            key: ValueKey<bool>(widget.config.lineLinks),
            text: widget.config.ezL10n.dsAlwaysUnderline,
            valueKey: widget.config.isDark ? darkLineLinksKey : lightLineLinksKey,
            afterChanged: (bool? value) async {
              if (value == null) return;

              if (EzCM.updateBoth) {
                await EzCM.setBool(
                    widget.config.isDark ? lightLineLinksKey : darkLineLinksKey, value);
              }
              await widget.config.rebuildUI();
            },
          ),
          widget.config.spacer,

          // Show back FAB
          EzSwitchPair(
            widget.config,
            text: widget.config.ezL10n.dsShowBack,
            valueKey: widget.config.isDark ? darkShowBackFABKey : lightShowBackFABKey,
            afterChanged: (bool? value) async {
              if (value == null) return;

              if (EzCM.updateBoth) {
                await EzCM.setBool(
                    widget.config.isDark ? lightShowBackFABKey : darkShowBackFABKey, value);
              }
              await widget.config.rebuildUI();
            },
          ),
          widget.config.spacer,

          // Show scroll
          EzSwitchPair(
            widget.config,
            text: widget.config.ezL10n.dsShowScroll,
            valueKey: widget.config.isDark ? darkShowScrollKey : lightShowScrollKey,
            afterChanged: (bool? value) async {
              if (value == null) return;

              if (EzCM.updateBoth) {
                await EzCM.setBool(
                    widget.config.isDark ? lightShowScrollKey : darkShowScrollKey, value);
              }
              await widget.config.rebuildUI();
            },
          ),

          if (widget.append != null) ...widget.append!,

          // Local reset all
          widget.resetSpacer ?? widget.config.separator,
          EzResetButton(
            widget.config,
            all: false,
            dynamicTitle: () =>
                widget.config.ezL10n.dsResetButton(ezThemeString(widget.config, bothable: true)),
            onConfirm: () async {
              if (EzCM.updateBoth || widget.config.isDark) {
                await EzCM.removeKeys(darkButtonDesignKeys.keys.toSet());
                await EzCM.remove(darkIconSizeKey);

                if (widget.resetExtraDark != null) {
                  await EzCM.removeKeys(widget.resetExtraDark!);
                }
              }

              if (EzCM.updateBoth || !widget.config.isDark) {
                await EzCM.removeKeys(lightButtonDesignKeys.keys.toSet());
                await EzCM.remove(lightIconSizeKey);

                if (widget.resetExtraLight != null) {
                  await EzCM.removeKeys(widget.resetExtraLight!);
                }
              }

              setState(() => iconSize =
                  EzCM.getDefault(widget.config.isDark ? darkIconSizeKey : lightIconSizeKey));
            },
            resetSkip: widget.resetSkip,
            saveSkip: widget.saveSkip,
          ),
        ],
      );
}

class _ButtonStyleSetting extends StatelessWidget {
  final EzCP config;
  final String? styleLabel;
  final double iconSize;

  const _ButtonStyleSetting(this.config, {this.styleLabel, required this.iconSize});

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        config,
        onPressed: () async {
          EzButtonShape currShape = config.buttonShape;
          double currWidth = config.borderWidth;

          await ezModal(
            config,
            context: context,
            builder: (_) => StatefulBuilder(
              builder: (_, StateSetter setModal) => ezModalScroll(
                config,
                children: <Widget>[
                  // Shape choices
                  RadioGroup<EzButtonShape>(
                    groupValue: currShape,
                    onChanged: (EzButtonShape? choice) async {
                      if (choice == null) return;

                      if (EzCM.updateBoth || config.isDark) {
                        await EzCM.setString(darkButtonShapeKey, choice.value);
                      }
                      if (EzCM.updateBoth || !config.isDark) {
                        await EzCM.setString(lightButtonShapeKey, choice.value);
                      }

                      setModal(() => currShape = choice);
                    },
                    child: EzScrollView(
                      config,
                      scrollDirection: Axis.horizontal,
                      thumbVisibility: false,
                      showScrollHint: true,
                      children: EzButtonShape.values
                          .map(
                            (EzButtonShape shape) => Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: config.spacing,
                                horizontal: config.spacing / 2,
                              ),
                              child: EzCol(
                                children: <Widget>[
                                  EzElevatedButton(
                                    config,
                                    text: shape.name(config.ezL10n),
                                    style: ElevatedButton.styleFrom(
                                      side: currWidth == 0
                                          ? BorderSide.none
                                          : BorderSide(
                                              color: config.colors.primaryContainer,
                                              width: currWidth,
                                            ),
                                      shape: shape.shape,
                                    ),
                                    onPressed: () async {
                                      if (EzCM.updateBoth || config.isDark) {
                                        await EzCM.setString(darkButtonShapeKey, shape.value);
                                      }
                                      if (EzCM.updateBoth || !config.isDark) {
                                        await EzCM.setString(lightButtonShapeKey, shape.value);
                                      }

                                      setModal(() => currShape = shape);
                                    },
                                  ),
                                  config.margin,
                                  ExcludeSemantics(
                                      child: EzRadio<EzButtonShape>(config, value: shape)),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  config.spacer,

                  // Border width slider
                  Text(config.ezL10n.dsBorderWidth, style: config.bodyStyle),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
                    child: Slider(
                      // Slider values
                      value: currWidth,
                      max: maxBorderWidth,
                      divisions: 30,
                      label: currWidth.toStringAsFixed(2),

                      // Slider functions
                      onChanged: (double value) => setModal(() => currWidth = value),
                      onChangeEnd: (double value) async {
                        if (EzCM.updateBoth || config.isDark) {
                          await EzCM.setDouble(darkBorderWidthKey, value);
                        }

                        if (EzCM.updateBoth || !config.isDark) {
                          await EzCM.setDouble(lightBorderWidthKey, value);
                        }
                      },
                    ),
                  ),
                  config.spacer,

                  // Reset button
                  EzElevatedIconButton(
                    config,
                    onPressed: () async {
                      if (EzCM.updateBoth || config.isDark) {
                        await EzCM.remove(darkButtonShapeKey);
                        await EzCM.remove(darkBorderWidthKey);
                      }
                      if (EzCM.updateBoth || !config.isDark) {
                        await EzCM.remove(lightButtonShapeKey);
                        await EzCM.remove(lightBorderWidthKey);
                      }

                      setModal(() {
                        currShape = EBSConfig.safeLookup(
                          EzCM.getDefault(config.isDark ? darkButtonShapeKey : lightButtonShapeKey),
                        );
                        currWidth = EzCM.getDefault(
                          config.isDark ? darkBorderWidthKey : lightBorderWidthKey,
                        );
                      });
                    },
                    icon: EzIcon(config, Icons.refresh),
                    label: config.ezL10n.gReset,
                  ),
                  config.separator,
                ],
              ),
            ),
          );

          if (currShape != config.buttonShape || currWidth != config.borderWidth) {
            await config.rebuildUI();
          }
        },
        label: styleLabel ?? config.ezL10n.dsStyle,
        icon: Icon(Icons.edit, size: iconSize),
      );
}
