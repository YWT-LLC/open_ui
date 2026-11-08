/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:material_ui/material_ui.dart';

class EzIconSizeSetting extends StatefulWidget {
  final EzCP config;

  /// If you want to track the iconSize changes externally
  final void Function(double iconSize)? onChanged;

  /// Set to false when using this outside of [EzTextSettings]
  final bool fullCheck;

  final Color? backgroundColor;

  const EzIconSizeSetting(
    this.config, {
    required super.key,
    required this.onChanged,
    this.fullCheck = true,
    this.backgroundColor,
  });

  @override
  State<EzIconSizeSetting> createState() => _EzIconSizeSettingState();
}

class _EzIconSizeSettingState extends State<EzIconSizeSetting> {
  late double iconSize = widget.config.iconSize;

  @override
  Widget build(BuildContext context) => EzCol(
        children: <Widget>[
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

                setState(() => iconSize = ywt.defaultIconSize);
                widget.onChanged?.call(ywt.defaultIconSize);

                if (widget.fullCheck && context.mounted) {
                  widget.config.pingRebuild(
                    iconSize != widget.config.iconSize ||
                        ezTextRebuildCheck(widget.config, context: context),
                  );
                } else {
                  widget.config.pingRebuild(iconSize != widget.config.iconSize);
                }
              },
              child: EzText(
                widget.config,
                text: widget.config.ezL10n.tsIconSize,
                style: widget.config.bodyStyle,
                backgroundColor: widget.backgroundColor,
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
                (iconSize > ywt.minIconSize)
                    ? EzIconButton(
                        widget.config,
                        onPressed: () async {
                          iconSize -= ywt.iconDelta;
                          if (EzCM.updateBoth || widget.config.isDark) {
                            await EzCM.setDouble(darkIconSizeKey, iconSize);
                          }
                          if (EzCM.updateBoth || !widget.config.isDark) {
                            await EzCM.setDouble(lightIconSizeKey, iconSize);
                          }

                          setState(() {});
                          widget.onChanged?.call(iconSize);

                          if (widget.fullCheck && context.mounted) {
                            widget.config.pingRebuild(
                              iconSize != widget.config.iconSize ||
                                  ezTextRebuildCheck(widget.config, context: context),
                            );
                          } else {
                            widget.config.pingRebuild(iconSize != widget.config.iconSize);
                          }
                        },
                        tooltip:
                            '${widget.config.ezL10n.gDecrease} ${widget.config.ezL10n.tsIconSize.toLowerCase()}',
                        iconSize: iconSize,
                        icon: EzIcon(widget.config, Icons.remove),
                      )
                    : EzIconButton(
                        widget.config,
                        enabled: false,
                        tooltip: widget.config.ezL10n.gMinimum,
                        iconSize: iconSize,
                        icon: EzIcon(widget.config, Icons.remove),
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

                    setState(() => iconSize = ywt.defaultIconSize);
                    widget.onChanged?.call(ywt.defaultIconSize);

                    if (widget.fullCheck && context.mounted) {
                      widget.config.pingRebuild(
                        iconSize != widget.config.iconSize ||
                            ezTextRebuildCheck(widget.config, context: context),
                      );
                    } else {
                      widget.config.pingRebuild(iconSize != widget.config.iconSize);
                    }
                  },
                  child: Icon(
                    Icons.sync_alt,
                    size: iconSize,
                    color: widget.config.onSurface,
                  ),
                ),
                widget.config.rowMargin,

                // Plus
                (iconSize < ywt.maxIconSize)
                    ? EzIconButton(
                        widget.config,
                        onPressed: () async {
                          iconSize += ywt.iconDelta;
                          if (EzCM.updateBoth || widget.config.isDark) {
                            await EzCM.setDouble(darkIconSizeKey, iconSize);
                          }
                          if (EzCM.updateBoth || !widget.config.isDark) {
                            await EzCM.setDouble(lightIconSizeKey, iconSize);
                          }

                          setState(() {});
                          widget.onChanged?.call(iconSize);

                          if (widget.fullCheck && context.mounted) {
                            widget.config.pingRebuild(
                              iconSize != widget.config.iconSize ||
                                  ezTextRebuildCheck(widget.config, context: context),
                            );
                          } else {
                            widget.config.pingRebuild(iconSize != widget.config.iconSize);
                          }
                        },
                        tooltip:
                            '${widget.config.ezL10n.gIncrease} ${widget.config.ezL10n.tsIconSize.toLowerCase()}',
                        iconSize: iconSize,
                        icon: EzIcon(widget.config, Icons.add),
                      )
                    : EzIconButton(
                        widget.config,
                        enabled: false,
                        tooltip: widget.config.ezL10n.gMaximum,
                        iconSize: iconSize,
                        icon: EzIcon(widget.config, Icons.add),
                      ),
              ],
            ),
            shape: widget.config.buttonShape,
            borderRadius: widget.config.buttonShape.radius,
            padding: EdgeInsets.zero,
            baseColor: widget.config.surfaceFill.asColor,
            backgroundColor: widget.backgroundColor,
          ),
        ],
      );
}
