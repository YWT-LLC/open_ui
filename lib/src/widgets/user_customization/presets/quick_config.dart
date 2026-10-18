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

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        config,
        onPressed: () => ezModal(
          config,
          context: context,
          builder: (_) => _Options(
            config,
            extraBig: extraBig,
            extraVis: extraVis,
            extraChalk: extraChalk,
            extraNebula: extraNebula,
            extraWall: extraWall,
          ),
        ),
        icon: EzIcon(config, Icons.edit),
        label: config.ezL10n.ssLoadPreset,
      );
}

class _Options extends StatelessWidget {
  final EzCP config;
  final Future<void> Function(bool)? extraBig;
  final Future<void> Function(bool)? extraVis;
  final Future<void> Function(bool)? extraChalk;
  final Future<void> Function(bool)? extraNebula;
  final Future<void> Function(bool)? extraWall;

  const _Options(
    this.config, {
    required this.extraBig,
    required this.extraVis,
    required this.extraChalk,
    required this.extraNebula,
    required this.extraWall,
  });

  Widget wrapIt(Widget child) => Padding(padding: EzInsets.wrap(config.spacing), child: child);

  @override
  Widget build(BuildContext context) => EzScrollView(config, children: <Widget>[
        EzWrap(children: <Widget>[
          wrapIt(EzBigButtonsConfig(config, updateBoth: false, extra: extraBig)),
          wrapIt(EzHighVisibilityConfig(config, updateBoth: false, extra: extraVis)),
          wrapIt(EzChalkboardConfig(config, autoConfirm: false, extra: extraChalk)),
          wrapIt(EzNebulaConfig(config, autoConfirm: false, extra: extraNebula)),
          wrapIt(EzWallHolesConfig(config, autoConfirm: false, extra: extraWall)),
        ]),
        EzSpacer(config.spacing * 1.5),
      ]);
}
