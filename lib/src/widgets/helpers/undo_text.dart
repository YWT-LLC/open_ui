/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Remind the user that reset/randomize/etc cannot be undone automatically
/// Includes and [EzInlineLink] to save current config to JSON
Widget ezRichUndoWarning(
  EzCP config, {
  required BuildContext context,
  bool standalone = true,
  Set<String>? skip,
}) {
  final EzRichText text = EzRichText(
    config,
    children: <InlineSpan>[
      // Cannot be undone
      EzPlainText(
        text: config.ezL10n.gUndoWarn1,
        style: config.bodyStyle,
      ),

      // Save link
      EzInlineLink(
        config,
        text: config.ezL10n.gSave,
        onTap: () => EzCM.saveConfig(config, context: context, skip: skip),
        hint: config.ezL10n.gSaveHint,
        style: config.bodyStyle,
        textAlign: TextAlign.center,
      ),

      // Can restore manually
      EzPlainText(
        text: config.ezL10n.gUndoWarn2,
        style: config.bodyStyle,
      ),
    ],
    textBackground: false,
    style: config.bodyStyle,
    textAlign: TextAlign.center,
  );

  return standalone
      ? SizedBox(
          width: ezTextSize(
            config.ezL10n.gSave + config.ezL10n.gUndoWarn2,
            context: context,
            style: config.bodyStyle,
          ).width,
          child: text,
        )
      : text;
}
