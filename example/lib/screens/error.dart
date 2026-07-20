/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:open_ui/open_ui.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EzCP>(
      builder: (_, EzCP config, __) => OpenUIScaffold(
        config,
        body: EzScreen(
          config,
          child: Center(
            child: EzScrollView(
              config,
              children: <Widget>[
                EzText(
                  config,
                  text: config.ezL10n.g404Wonder,
                  style: config.headlineStyle,
                  textAlign: TextAlign.center,
                ),
                config.separator,
                EzText(
                  config,
                  text: config.ezL10n.g404,
                  style: ezSubTitleStyle(config.styles),
                  textAlign: TextAlign.center,
                ),
                config.separator,
                EzText(
                  config,
                  text: config.ezL10n.g404Note,
                  style: config.labelStyle,
                  textAlign: TextAlign.center,
                ),
                EzFooter(config, spacing: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
