/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzFontDoubleSetting extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// The [EzCM] key being edited
  final String configKey;

  /// An alt to updateBoth
  final String? mirrorKey;

  /// Starting (aka current) value for [configKey]
  final double initialValue;

  /// Only relevant if [plusMinus] is true
  /// Absolute amount to scale on each click
  final double delta;

  /// Optionally include plus/minus buttons surrounding the [TextFormField]
  /// Increments/decrements based on [delta]
  final bool plusMinus;

  /// Lower limit for the new value(s)
  final double min;

  /// Upper limit for the new value(s)
  final double max;

  /// Use this to live update the [TextStyle] on your UI
  final void Function(double) notifierCallback;

  /// Label [icon] below the [EzFontDoubleSetting]
  final Widget icon;

  /// [Tooltip.message] passthrough
  final String tooltip;

  /// [TextStyle] for the [TextFormField]
  final TextStyle? style;

  /// Standardized tool for updating double [TextStyle] values for the passed [configKey]
  /// For example: [TextStyle.fontSize], [TextStyle.letterSpacing], [TextStyle.wordSpacing], and [TextStyle.height]
  const EzFontDoubleSetting(
    this.config, {
    super.key,
    required this.configKey,
    this.mirrorKey,
    required this.initialValue,
    this.delta = 1.0,
    this.plusMinus = false,
    required this.min,
    required this.max,
    required this.notifierCallback,
    required this.icon,
    required this.tooltip,
    required this.style,
  });

  @override
  State<EzFontDoubleSetting> createState() => _FontDoubleSettingState();
}

class _FontDoubleSettingState extends State<EzFontDoubleSetting> {
  // Define the build data //

  late double currValue;
  final TextEditingController controller = TextEditingController();

  late final Size sizeLimit = ezTextSize(
    sampleString,
    context: context,
    style: widget.style,
  );

  late double formFieldWidth =
      max(sizeLimit.width + widget.config.padding, kMinInteractiveDimension);
  late double formFieldHeight =
      max(sizeLimit.height + widget.config.padding, kMinInteractiveDimension);

  // Init //

  @override
  void initState() {
    super.initState();
    currValue = widget.initialValue;
    controller.text = currValue.toString();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => Tooltip(
        message: widget.tooltip,
        child: EzCol(children: <Widget>[
          EzScrollView(
            widget.config,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              // Minus
              if (widget.plusMinus) ...<Widget>[
                (currValue > widget.min)
                    ? EzIconButton(
                        widget.config,
                        onPressed: () async {
                          currValue -= widget.delta;
                          controller.text = currValue.toString();

                          await EzCM.setDouble(
                            widget.configKey,
                            currValue,
                          );
                          if (widget.mirrorKey != null) {
                            await EzCM.setDouble(
                              widget.mirrorKey!,
                              currValue,
                            );
                          }

                          widget.notifierCallback(currValue);
                          if (context.mounted) {
                            widget.config
                                .pingRebuild(ezTextRebuildCheck(widget.config, context: context));
                          }

                          setState(() {});
                        },
                        tooltip:
                            '${widget.config.ezL10n.gDecrease} ${widget.tooltip.toLowerCase()}',
                        icon: const Icon(Icons.remove),
                      )
                    : EzIconButton(
                        widget.config,
                        enabled: false,
                        tooltip: widget.config.ezL10n.gMinimum,
                        icon: Icon(Icons.remove, color: widget.config.colors.outline),
                      ),
                widget.config.rowMargin,
              ],

              // Text field
              EzTextField(
                controller: controller,
                constraints: BoxConstraints(maxWidth: formFieldWidth, maxHeight: formFieldHeight),
                hintText: widget.initialValue.toString(),
                keyboardType: TextInputType.number,
                style: widget.style,
                validator: (String? value) {
                  if (value == null) return null;
                  final double? doubleVal = double.tryParse(value);

                  if (doubleVal == null || doubleVal < widget.min || doubleVal > widget.max) {
                    setState(() {
                      formFieldWidth = (sizeLimit.width + widget.config.padding) * 1.75;
                      formFieldHeight = (sizeLimit.height + widget.config.padding) * 1.75;
                    });
                    return '${widget.min}  <->  ${widget.max}';
                  }

                  setState(() {
                    formFieldWidth = sizeLimit.width + widget.config.padding;
                    formFieldHeight = sizeLimit.height + widget.config.padding;
                  });
                  return null;
                },
                onFieldSubmitted: (String stringVal) async {
                  final double? doubleVal = double.tryParse(stringVal);

                  if (doubleVal == null || doubleVal < widget.min || doubleVal > widget.max) {
                    return;
                  }
                  currValue = doubleVal;

                  await EzCM.setDouble(widget.configKey, doubleVal);
                  if (widget.mirrorKey != null) {
                    await EzCM.setDouble(widget.mirrorKey!, doubleVal);
                  }

                  widget.notifierCallback(doubleVal);
                  if (context.mounted) {
                    widget.config.pingRebuild(ezTextRebuildCheck(widget.config, context: context));
                  }

                  setState(() {});
                },
              ),

              if (widget.plusMinus) ...<Widget>[
                widget.config.rowMargin,

                // Plus icon
                (currValue < widget.max)
                    ? EzIconButton(
                        widget.config,
                        onPressed: () async {
                          currValue += widget.delta;
                          controller.text = currValue.toString();

                          await EzCM.setDouble(
                            widget.configKey,
                            currValue,
                          );
                          if (widget.mirrorKey != null) {
                            await EzCM.setDouble(
                              widget.mirrorKey!,
                              currValue,
                            );
                          }

                          widget.notifierCallback(currValue);
                          if (context.mounted) {
                            widget.config
                                .pingRebuild(ezTextRebuildCheck(widget.config, context: context));
                          }

                          setState(() {});
                        },
                        tooltip:
                            '${widget.config.ezL10n.gIncrease} ${widget.tooltip.toLowerCase()}',
                        icon: const Icon(Icons.add),
                      )
                    : EzIconButton(
                        widget.config,
                        enabled: false,
                        tooltip: widget.config.ezL10n.gMaximum,
                        icon: Icon(
                          Icons.add,
                          color: widget.config.colors.outline,
                        ),
                      ),
              ],
            ],
          ),

          // Label icon
          widget.icon,
        ]),
      );
}
