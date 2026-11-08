/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

class EzDominantHandSwitch extends StatelessWidget {
  final EzCP config;

  /// Standardized tool for updating [isLeftyKey]
  const EzDominantHandSwitch(this.config, {super.key});

  // Return the build //

  @override
  Widget build(BuildContext context) => EzDropdownMenu<bool>(
        config,
        label: config.ezL10n.ssDominantHand,
        widthEntry: config.ezL10n.gRight,
        dropdownMenuEntries: <EzDropMenuEntry<bool>>[
          EzDropMenuEntry<bool>(config, value: false, label: config.ezL10n.gRight),
          EzDropMenuEntry<bool>(config, value: true, label: config.ezL10n.gLeft),
        ],
        enableSearch: false,
        initialSelection: config.isLefty,
        onSelected: (bool? makeLeft) async {
          if (makeLeft == null || makeLeft == config.isLefty) return;
          await EzCM.setBool(isLeftyKey, makeLeft);
          await config.rebuildUI();
        },
      );
}
