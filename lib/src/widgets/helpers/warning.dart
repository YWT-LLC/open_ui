/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzWarning extends StatelessWidget {
  final EzCP config;

  /// Defaults to [OUILang.gAttention]
  final String? title;

  final String body;

  ///  /!\  [title]  /!\
  ///       [body]
  const EzWarning(
    this.config, {
    required this.body,
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Semantics(
        label: '${title ?? config.ezL10n.gAttention}: $body',
        readOnly: true,
        child: ExcludeSemantics(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(config.marginVal),
              child: EzCol(children: <Widget>[
                // Title
                EzScrollView(
                  config,
                  scrollDirection: Axis.horizontal,
                  startCentered: true,
                  children: <Widget>[
                    // Thing1
                    EzIcon(config, Icons.warning, fill: config.secondaryFill),

                    // Title
                    config.rowMargin,
                    Text(
                      title ?? config.ezL10n.gAttention,
                      style: config.titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    config.rowMargin,

                    // Thing 2
                    EzIcon(config, Icons.warning, fill: config.secondaryFill),
                  ],
                ),
                config.spacer,

                // Body
                Text(body, style: config.bodyStyle, textAlign: TextAlign.center),
              ]),
            ),
          ),
        ),
      );
}
