/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class EzIconSizeSetting extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Set to false when using this outside of [EzTextSettings]
  final bool fullCheck;

  /// [EzTextBackground.backgroundColor] passthrough
  final Color? backgroundColor;

  const EzIconSizeSetting(
    this.config, {
    super.key,
    this.fullCheck = true,
    this.backgroundColor,
  });

  @override
  State<EzIconSizeSetting> createState() => _EzIconSizeSettingState();
}

class _EzIconSizeSettingState extends State<EzIconSizeSetting> {
  late double iconSize = widget.config.iconSize;

  @override
  Widget build(BuildContext context) => EzCol(children: <Widget>[
        Tooltip(
          message: widget.config.ezL10n.gCenterReset,
          child: GestureDetector(
            onLongPress: () async {
              if (EzCM.updateBoth || widget.config.isDark) {
                await EzCM.remove(darkIconSizeKey);
              }
              if (EzCM.updateBoth || !widget.config.isDark) {
                await EzCM.remove(lightIconSizeKey);
              }

              setState(() => iconSize = defaultIconSize);

              if (widget.fullCheck && context.mounted) {
                widget.config.pingRebuild(iconSize != widget.config.iconSize ||
                    ezTextRebuildCheck(widget.config, context: context));
              } else {
                widget.config.pingRebuild(iconSize != widget.config.iconSize);
              }
            },
            child: EzText(
              widget.config,
              text: widget.config.ezL10n.tsIconSize,
              style: widget.config.bodyStyle,
            ),
          ),
        ),
        EzTextBackground(
          widget.config,
          text: EzRow(
            widget.config,
            reverseHands: false,
            children: <Widget>[
              // Minus
              (iconSize > minIconSize)
                  ? EzIconButton(
                      widget.config,
                      onPressed: () async {
                        iconSize -= iconDelta;
                        if (EzCM.updateBoth || widget.config.isDark) {
                          await EzCM.setDouble(darkIconSizeKey, iconSize);
                        }
                        if (EzCM.updateBoth || !widget.config.isDark) {
                          await EzCM.setDouble(lightIconSizeKey, iconSize);
                        }

                        setState(() {});

                        if (widget.fullCheck && context.mounted) {
                          widget.config.pingRebuild(iconSize != widget.config.iconSize ||
                              ezTextRebuildCheck(widget.config, context: context));
                        } else {
                          widget.config.pingRebuild(iconSize != widget.config.iconSize);
                        }
                      },
                      tooltip:
                          '${widget.config.ezL10n.gDecrease} ${widget.config.ezL10n.tsIconSize.toLowerCase()}',
                      iconSize: iconSize,
                      icon: const Icon(Icons.remove),
                    )
                  : EzIconButton(
                      widget.config,
                      enabled: false,
                      tooltip: widget.config.ezL10n.gMinimum,
                      iconSize: iconSize,
                      icon: Icon(Icons.remove, color: widget.config.colors.outline),
                    ),
              widget.config.rowMargin,

              // Preview
              GestureDetector(
                onLongPress: () async {
                  if (EzCM.updateBoth || widget.config.isDark) {
                    await EzCM.remove(darkIconSizeKey);
                  }
                  if (EzCM.updateBoth || !widget.config.isDark) {
                    await EzCM.remove(lightIconSizeKey);
                  }

                  setState(() => iconSize = defaultIconSize);

                  if (widget.fullCheck && context.mounted) {
                    widget.config.pingRebuild(iconSize != widget.config.iconSize ||
                        ezTextRebuildCheck(widget.config, context: context));
                  } else {
                    widget.config.pingRebuild(iconSize != widget.config.iconSize);
                  }
                },
                child: Icon(
                  Icons.sync_alt,
                  size: iconSize,
                  color: widget.config.colors.onSurface,
                ),
              ),
              widget.config.rowMargin,

              // Plus
              (iconSize < maxIconSize)
                  ? EzIconButton(
                      widget.config,
                      onPressed: () async {
                        iconSize += iconDelta;
                        if (EzCM.updateBoth || widget.config.isDark) {
                          await EzCM.setDouble(darkIconSizeKey, iconSize);
                        }
                        if (EzCM.updateBoth || !widget.config.isDark) {
                          await EzCM.setDouble(lightIconSizeKey, iconSize);
                        }

                        setState(() {});

                        if (widget.fullCheck && context.mounted) {
                          widget.config.pingRebuild(iconSize != widget.config.iconSize ||
                              ezTextRebuildCheck(widget.config, context: context));
                        } else {
                          widget.config.pingRebuild(iconSize != widget.config.iconSize);
                        }
                      },
                      tooltip:
                          '${widget.config.ezL10n.gIncrease} ${widget.config.ezL10n.tsIconSize.toLowerCase()}',
                      iconSize: iconSize,
                      icon: const Icon(Icons.add),
                    )
                  : EzIconButton(
                      widget.config,
                      enabled: false,
                      tooltip: widget.config.ezL10n.gMaximum,
                      iconSize: iconSize,
                      icon: Icon(Icons.add, color: widget.config.colors.outline),
                    ),
            ],
          ),
          buttonShape: true,
          padding: EdgeInsets.zero,
          baseColor: widget.config.colors.surface,
          backgroundColor: widget.backgroundColor,
        ),
      ]);
}
