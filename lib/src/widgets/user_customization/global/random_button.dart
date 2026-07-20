/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class EzConfigRandomizer extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [EzAlertDialog.title] that shows on click
  /// Defaults to [OUILang.ssRandomize]
  final String? dialogTitle;

  /// [ezRichUndoWarning] passthrough
  final Set<String>? saveSkip;

  /// [EzElevatedIconButton] for [EzCM.randomize]
  const EzConfigRandomizer(this.config, {super.key, this.dialogTitle, this.saveSkip});

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        config,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext dCon) => EzAlertDialog(
            config,
            title: Text(
              dialogTitle ??
                  config.ezL10n.ssRandomize(
                    config.isDark
                        ? config.ezL10n.gDark.toLowerCase()
                        : config.ezL10n.gLight.toLowerCase(),
                  ),
              textAlign: TextAlign.center,
            ),
            content: ezRichUndoWarning(config, context: context, skip: saveSkip),
            actions: ezActionPair(
              config,
              onConfirm: () =>
                  config.rebuildUI(allECT, changes: () => EzCM.randomize(config.isDark)),
              confirmIsDestructive: true,
              onDeny: () => Navigator.of(dCon).pop(),
            ),
            needsClose: false,
          ),
        ),
        icon: EzIcon(config, LineIcons.diceD6),
        label: config.ezL10n.ssRandom,
      );
}
