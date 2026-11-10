/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

// TODO: figure out how to disable the button layer builder

class EzQuickConfig extends StatelessWidget {
  final EzCP config;

  /// Extra changes for [EzBigButtonsConfig]
  final Future<void> Function(bool)? extraBig;

  /// Extra changes for [EzHighVisibilityConfig]
  final Future<void> Function(bool)? extraVis;

  /// Extra changes for [EzChalkboardConfig]
  final Future<void> Function(bool)? extraChalk;

  /// Opens a [BottomSheet] with [EzElevatedIconButton]s for different presets
  const EzQuickConfig(
    this.config, {
    super.key,
    this.extraBig,
    this.extraVis,
    this.extraChalk,
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

  const _Options(
    this.config, {
    required this.extraBig,
    required this.extraVis,
    required this.extraChalk,
  });

  @override
  Widget build(BuildContext context) => ezModalScroll(config, children: <Widget>[
        EzWrap(children: <Widget>[
          ezWrap(config, child: EzBigButtonsConfig(config, updateBoth: false, extra: extraBig)),
          ezWrap(config, child: EzHighVisibilityConfig(config, updateBoth: false, extra: extraVis)),
          ezWrap(config, child: EzChalkboardConfig(config, autoConfirm: false, extra: extraChalk)),
        ]),
        EzSpacer(config.spacing * 1.5),
      ]);
}
