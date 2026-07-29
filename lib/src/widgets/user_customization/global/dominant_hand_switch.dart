/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzDominantHandSwitch extends StatelessWidget {
  final EzCP config;

  /// Standardized tool for updating [isLeftyKey]
  const EzDominantHandSwitch(this.config, {super.key});

  // Return the build //

  @override
  Widget build(BuildContext context) => EzScrollView(
        config,
        reverseHands: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // Label
          EzText(config, text: config.ezL10n.ssDominantHand, textAlign: TextAlign.center),
          config.rowMargin,

          // Button
          EzDropdownMenu<bool>(
            config,
            widthEntry: config.ezL10n.gRight,
            dropdownMenuEntries: <DropdownMenuEntry<bool>>[
              DropdownMenuEntry<bool>(value: false, label: config.ezL10n.gRight),
              DropdownMenuEntry<bool>(value: true, label: config.ezL10n.gLeft),
            ],
            enableSearch: false,
            initialSelection: config.isLefty,
            onSelected: (bool? makeLeft) async {
              if (makeLeft == null || makeLeft == config.isLefty) return;
              await EzCM.setBool(isLeftyKey, makeLeft);
              await config.rebuildUI(noECT);
            },
          ),
        ],
      );
}
