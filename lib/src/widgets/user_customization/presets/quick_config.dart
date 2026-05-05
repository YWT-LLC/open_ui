/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class TryTip extends StatelessWidget {
  final Widget child;

  const TryTip({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Tooltip(
        message: EzConfig.l10n.ssTryMe,
        excludeFromSemantics: true,
        child: child,
      );
}

class EzQuickConfig extends StatelessWidget {
  /// Extra changes for [EzBigButtonsConfig]
  final Future<void> Function()? extraBig;

  /// Extra changes for [EzHighVisibilityConfig]
  final Future<void> Function()? extraVis;

  /// Extra changes for [EzChalkboardConfig]
  final Future<void> Function()? extraChalk;

  /// Extra changes for [EzNebulaConfig]
  final Future<void> Function()? extraNebula;

  /// Extra changes for [EzWallHolesConfig]
  final Future<void> Function()? extraWall;

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
          builder: (_) => ezModalScroll(<Widget>[
            // Choices
            EzWrap(children: <Widget>[
              // Important
              wrapIt(EzBigButtonsConfig(extraBig)),
              wrapIt(EzHighVisibilityConfig(extraVis)),
              wrapIt(EzChalkboardConfig(extraChalk)), // segue

              // Fun
              wrapIt(EzNebulaConfig(extraNebula)),
              wrapIt(EzWallHolesConfig(extraWall)),
            ]),
            EzConfig.spacer,
          ]),
        ),
        icon: const Icon(Icons.edit),
        label: EzConfig.l10n.ssLoadPreset,
      );
}
