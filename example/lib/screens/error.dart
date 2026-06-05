/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EZCProvider>(
      builder: (_, EZCProvider config, __) => OpenUIScaffold(EzScreen(Center(
        child: EzScrollView(children: <Widget>[
          EzText(
            config.l10n.g404Wonder,
            style: config.headlineStyle,
            textAlign: TextAlign.center,
          ),
          config.separator,
          EzText(
            config.l10n.g404,
            style: ezSubTitleStyle(),
            textAlign: TextAlign.center,
          ),
          config.separator,
          EzText(
            config.l10n.g404Note,
            style: config.labelStyle,
            textAlign: TextAlign.center,
          ),
          EzFooter(config.locale.languageCode, spacing: 0)
        ]),
      ))),
    );
  }
}
