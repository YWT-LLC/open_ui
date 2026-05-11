/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class EzConfigRandomizer extends StatelessWidget {
  /// [EzAlertDialog.title] that shows on click
  /// Defaults to [EFUILang.ssRandomize]
  final String? dialogTitle;

  /// [ezRichUndoWarning] passthrough
  final Set<String>? saveSkip;

  /// [EzElevatedIconButton] for randomizing [EzConfig]
  const EzConfigRandomizer({
    super.key,
    this.dialogTitle,
    this.saveSkip,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext dCon) => EzAlertDialog(
            title: Text(
              dialogTitle ??
                  EzConfig.l10n.ssRandomize(EzConfig.isDark
                      ? EzConfig.l10n.gDark.toLowerCase()
                      : EzConfig.l10n.gLight.toLowerCase()),
              textAlign: TextAlign.center,
            ),
            content: ezRichUndoWarning(context, skip: saveSkip),
            actions: ezActionPair(
              onConfirm: () => EzConfig.rebuildUI(changes: () => EzConfig.randomize()),
              confirmIsDestructive: true,
              onDeny: () => Navigator.of(dCon).pop(),
            ),
            needsClose: false,
          ),
        ),
        icon: EzIcon(LineIcons.diceD6),
        label: EzConfig.l10n.ssRandom,
      );
}
