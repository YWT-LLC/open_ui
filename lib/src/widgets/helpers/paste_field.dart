/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EzPasteField extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  final TextEditingController controller;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final List<String>? autofillHints;
  final InputDecoration? decoration;

  const EzPasteField(
    this.config, {
    super.key,
    required this.controller,
    this.style,
    required this.validator,
    this.autofillHints,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) => EzRow(config, children: <Widget>[
        // Field
        Expanded(
          child: TextFormField(
            controller: controller,
            enabled: true,
            style: style,
            validator: validator,
            autofillHints: autofillHints,
            autovalidateMode: AutovalidateMode.onUnfocus,
          ),
        ),
        config.rowMargin,

        // Paste
        EzIconButton(
          config,
          onPressed: () async {
            final String? clipText = (await Clipboard.getData(Clipboard.kTextPlain))?.text;
            if (clipText != null) controller.text = clipText;
          },
          icon: EzIcon(config, Icons.paste),
        ),
      ]);
}
