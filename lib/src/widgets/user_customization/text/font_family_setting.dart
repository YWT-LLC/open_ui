/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontSetting extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Which [TextStyle] to update
  final EzTextSettingType type;

  /// Base [TextStyle] for the [DropdownMenu]
  /// Will be provided to [fuseWithGFont] alongside the current selection
  final TextStyle baseStyle;

  /// Callback to live update the [TextStyle] on your UI
  final void Function(String font) notifierCallback;

  /// Standardized tool for updating the [TextStyle.fontFamily] that matches [type]
  /// [EzFontSetting] options are built from [googleStyles]
  const EzFontSetting(
    this.config, {
    required super.key,
    required this.type,
    required this.baseStyle,
    required this.notifierCallback,
  });

  @override
  State<EzFontSetting> createState() => _FontSettingState();
}

class _FontSettingState extends State<EzFontSetting> {
  late String? currFont = EzCM.get(widget.type.fontKey(widget.config.isDark)) == null
      ? null
      : ezClassToCamel(ezFirstWord(EzCM.get(widget.type.fontKey(widget.config.isDark))));

  @override
  Widget build(BuildContext context) => Tooltip(
        message: widget.config.ezL10n.tsFontFamily,
        child: EzDropdownMenu<String>(
          widget.config,
          widthEntry: fingerPaint,
          textStyle: fuseWithGFont(
            starter: widget.baseStyle,
            gFont: currFont ?? EzCM.get(widget.type.fontKey(widget.config.isDark)),
          ),
          dropdownMenuEntries: googleStyles.entries
              .map((MapEntry<String, TextStyle> entry) => DropdownMenuEntry<String>(
                    value: entry.key,
                    label: ezCamelToTitle(entry.key),
                    style: TextButton.styleFrom(textStyle: entry.value),
                  ))
              .toList(),
          enableSearch: false,
          initialSelection: currFont,
          onSelected: (String? font) async {
            if (font == null) return;
            currFont = font;

            await EzCM.setString(widget.type.fontKey(widget.config.isDark), font);
            if (EzCM.updateBoth) {
              await EzCM.setString(widget.type.fontMirror(widget.config.isDark), font);
            }
            widget.notifierCallback(font);

            if (context.mounted) {
              widget.config.pingRebuild(ezTextRebuildCheck(widget.config, context: context));
            }
            setState(() {});
          },
        ),
      );
}
