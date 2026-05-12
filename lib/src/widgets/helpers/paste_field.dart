/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EzPasteField extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final List<String>? autofillHints;
  final InputDecoration? decoration;

  const EzPasteField({
    super.key,
    required this.controller,
    this.style,
    required this.validator,
    this.autofillHints,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) => EzRow(children: <Widget>[
        // Field
        Expanded(
          child: TextFormField(
            controller: controller,
            enabled: true,
            readOnly: false,
            maxLines: 1,
            textAlign: TextAlign.start,
            style: style,
            validator: validator,
            autofillHints: autofillHints,
            autovalidateMode: AutovalidateMode.onUnfocus,
          ),
        ),
        EzConfig.rowMargin,

        // Paste
        EzIconButton(
          onPressed: () async {
            final String? clipText = (await Clipboard.getData(Clipboard.kTextPlain))?.text;
            if (clipText != null) controller.text = clipText;
          },
          icon: EzIcon(Icons.paste),
        ),
      ]);
}
