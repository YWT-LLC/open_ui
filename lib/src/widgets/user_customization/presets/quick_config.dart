/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzQuickConfig extends StatelessWidget {
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

  /// Opens a [BottomSheet] with [EzElevatedIconButton]s for different [EzConfig] presets
  const EzQuickConfig({
    super.key,
    this.extraBig,
    this.extraVis,
    this.extraChalk,
    this.extraNebula,
    this.extraWall,
  });

  Widget wrapIt(Widget child) => Padding(padding: EzInsets.wrap(EzConfig.spacing), child: child);

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        onPressed: () => ezModal(
          context: context,
          builder: (_) {
            bool dewIt = EzConfig.updateBoth;

            return StatefulBuilder(
              builder: (_, StateSetter setModal) => ezModalScroll(<Widget>[
                // Update both/auto confirm toggle
                EzSwitchPair(
                  value: dewIt,
                  text: 'Update both/auto confirm', // TODO: test && l10n
                  onChanged: (bool? value) {
                    if (value == null) return;

                    setModal(() => dewIt = value);
                  },
                ),
                EzSpacer(space: EzConfig.spacing * 0.5),

                // Choices
                EzWrap(children: <Widget>[
                  wrapIt(EzBigButtonsConfig(updateBoth: dewIt, extra: extraBig)),
                  wrapIt(EzHighVisibilityConfig(updateBoth: dewIt, extra: extraVis)),
                  wrapIt(EzChalkboardConfig(autoConfirm: dewIt, extra: extraChalk)),
                  wrapIt(EzNebulaConfig(autoConfirm: dewIt, extra: extraNebula)),
                  wrapIt(EzWallHolesConfig(autoConfirm: dewIt, extra: extraWall)),
                ]),
                EzSpacer(space: EzConfig.spacing * 1.5),
              ]),
            );
          },
        ),
        icon: EzIcon(Icons.edit),
        label: EzConfig.l10n.ssLoadPreset,
      );
}
