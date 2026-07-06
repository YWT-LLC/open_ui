/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzUnderlineSetting extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Which [TextStyle] to update
  final EzTextSettingType type;

  /// Callback to live update the [TextStyle] on your UI
  final void Function(bool underline) notifierCallback;

  /// Standardized tool for toggling [TextDecoration.underline] in the [TextStyle.decoration] that matches [type]
  const EzUnderlineSetting(
    this.config, {
    required super.key,
    required this.type,
    required this.notifierCallback,
  });

  @override
  State<EzUnderlineSetting> createState() => _EzUnderlineSettingState();
}

class _EzUnderlineSettingState extends State<EzUnderlineSetting> {
  late bool isUnderlined = EzCM.get(widget.type.underlineKey(widget.config.isDark)) ?? false;

  @override
  Widget build(BuildContext context) => EzIconButton(
        widget.config,
        onPressed: () async {
          isUnderlined = !isUnderlined;

          await EzCM.setBool(widget.type.underlineKey(widget.config.isDark), isUnderlined);
          if (EzCM.updateBoth) {
            await EzCM.setBool(widget.type.underlineMirror(widget.config.isDark), isUnderlined);
          }

          widget.notifierCallback(isUnderlined);
          if (context.mounted) {
            widget.config.pingRebuild(ezTextRebuildCheck(widget.config, context: context));
          }

          setState(() {});
        },
        tooltip: widget.config.ezL10n.tsUnderline,
        icon: Icon(
          Icons.format_underline,
          color: isUnderlined ? widget.config.colors.primary : widget.config.colors.outline,
        ),
      );
}
