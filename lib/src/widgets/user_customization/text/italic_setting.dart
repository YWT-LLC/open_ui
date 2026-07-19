/* empathetech_flutter_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzItalicSetting extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Which [TextStyle] to update
  final EzTextSettingType type;

  /// Callback to live update the [TextStyle] on your UI
  final void Function(bool italic) notifierCallback;

  /// Standardized tool for toggling [FontStyle.italic] in the [TextStyle.fontStyle] that matches [type]
  const EzItalicSetting(
    this.config, {
    required super.key,
    required this.type,
    required this.notifierCallback,
  });

  @override
  State<EzItalicSetting> createState() => _EzItalicSettingState();
}

class _EzItalicSettingState extends State<EzItalicSetting> {
  late bool isItalic = EzCM.get(widget.type.italicKey(widget.config.isDark)) ?? false;

  @override
  Widget build(BuildContext context) => EzIconButton(
        widget.config,
        onPressed: () async {
          isItalic = !isItalic;

          await EzCM.setBool(widget.type.italicKey(widget.config.isDark), isItalic);
          if (EzCM.updateBoth) {
            await EzCM.setBool(widget.type.italicMirror(widget.config.isDark), isItalic);
          }

          widget.notifierCallback(isItalic);
          if (context.mounted) {
            widget.config.pingRebuild(ezTextRebuildCheck(widget.config, context: context));
          }

          setState(() {});
        },
        tooltip: widget.config.ezL10n.tsItalic,
        icon: Icon(
          Icons.format_italic,
          color: isItalic ? widget.config.colors.primary : widget.config.colors.outline,
        ),
      );
}
