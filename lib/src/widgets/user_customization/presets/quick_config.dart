/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzQuickConfig extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Extra changes for [EzBigButtonsConfig]
  final Future<void> Function(bool)? extraBig;

  /// Extra changes for [EzHighVisibilityConfig]
  final Future<void> Function(bool)? extraVis;

  /// Extra changes for [EzChalkboardConfig]
  final Future<void> Function(bool)? extraChalk;

  /// Extra changes for [EzNebulaConfig]
  final Future<void> Function(bool)? extraNebula;

  /// Extra changes for [EzWallHolesConfig]
  final Future<void> Function(bool)? extraWall;

  /// Opens a [BottomSheet] with [EzElevatedIconButton]s for different presets
  const EzQuickConfig(
    this.config, {
    super.key,
    this.extraBig,
    this.extraVis,
    this.extraChalk,
    this.extraNebula,
    this.extraWall,
  });

  Widget wrapIt(Widget child) => Padding(padding: EzInsets.wrap(config.spacing), child: child);

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
    config,
    onPressed: () => ezModal(
      config,
      context: context,
      builder: (_) {
        bool dewIt = EzCM.updateBoth;

        return StatefulBuilder(
          builder: (_, StateSetter setModal) => ezModalScroll(
            config,
            children: <Widget>[
              // Update both/auto confirm toggle
              EzSwitchPair(
                config,
                key: ValueKey<String>('dis-$dewIt'),
                value: dewIt,
                text: config.ezL10n.ssDewIt,
                onChanged: (bool? value) {
                  if (value == null) return;
                  setModal(() => dewIt = value);
                },
              ),
              EzSpacer(config.spacing * 0.5),

              // Choices
              EzWrap(
                children: <Widget>[
                  wrapIt(EzBigButtonsConfig(config, updateBoth: dewIt, extra: extraBig)),
                  wrapIt(EzHighVisibilityConfig(config, updateBoth: dewIt, extra: extraVis)),
                  wrapIt(EzChalkboardConfig(config, autoConfirm: dewIt, extra: extraChalk)),
                  wrapIt(EzNebulaConfig(config, autoConfirm: dewIt, extra: extraNebula)),
                  wrapIt(EzWallHolesConfig(config, autoConfirm: dewIt, extra: extraWall)),
                ],
              ),
              EzSpacer(config.spacing * 1.5),
            ],
          ),
        );
      },
    ),
    icon: EzIcon(config, Icons.edit),
    label: config.ezL10n.ssLoadPreset,
  );
}
