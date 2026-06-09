/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzWarning extends StatelessWidget {
  /// EzConfig provider
  final EzCP config;

  /// What does the user need to know?
  final String body;

  /// Warning [String] to grab the user's attention
  /// Defaults to [EFUILang.gAttention]
  final String? title;

  /// [Card] wrapper designed to grab attention for warnings...
  ///  /!\  [title]  /!\
  ///       [body]
  const EzWarning(this.config, {required this.body, this.title, super.key});

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
                    EzIcon(config, Icons.warning, color: config.colors.secondary),
                    config.rowMargin,

                    Text(
                      title ?? config.ezL10n.gAttention,
                      style: config.titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    config.rowMargin,

                    // Thing 2
                    EzIcon(config, Icons.warning, color: config.colors.secondary),
                  ],
                ),
                config.spacer,

                // Body
                Text(
                  body,
                  style: config.bodyStyle,
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
        ),
      );
}
