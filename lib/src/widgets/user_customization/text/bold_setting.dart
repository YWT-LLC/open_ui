/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzBoldSetting extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Which [TextStyle] to update
  final EzTextSettingType type;

  /// Callback to live update the [TextStyle] on your UI
  final void Function(bool bold) notifierCallback;

  /// Standardized tool for toggling [FontWeight.bold] in the [TextStyle.fontWeight] that matches [type]
  const EzBoldSetting(
    this.config, {
    required super.key,
    required this.type,
    required this.notifierCallback,
  });

  @override
  State<EzBoldSetting> createState() => _EzBoldSettingState();
}

class _EzBoldSettingState extends State<EzBoldSetting> {
  late bool isBold = EzCM.get(widget.type.boldKey(widget.config.isDark)) ?? false;

  @override
  Widget build(BuildContext context) => EzIconButton(
        widget.config,
        onPressed: () async {
          isBold = !isBold;

          await EzCM.setBool(widget.type.boldKey(widget.config.isDark), isBold);
          if (EzCM.updateBoth) {
            await EzCM.setBool(widget.type.boldMirror(widget.config.isDark), isBold);
          }

          widget.notifierCallback(isBold);
          if (context.mounted) {
            widget.config.pingRebuild(ezTextRebuildCheck(widget.config, context: context));
          }

          setState(() {});
        },
        tooltip: widget.config.ezL10n.tsBold,
        icon: Icon(
          Icons.format_bold_outlined,
          color: isBold ? widget.config.colors.primary : widget.config.colors.outline,
        ),
      );
}
