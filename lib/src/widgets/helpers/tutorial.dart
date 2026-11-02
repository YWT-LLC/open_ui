/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:open_ui/open_ui.dart';

class EzTutorial extends StatelessWidget {
  final EzCP config;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Widget? title;
  final String content;
  final String? contentSemantics;
  final String acceptMessage;
  final String? acceptSemantics;
  final void Function() onAccept;

  /// [AlertDialog] wrapped in a [SelectionArea] and [Positioned] widget
  /// Pairs well with [OverlayPortal] for displaying tutorials
  const EzTutorial(
    this.config, {
    super.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.title,
    required this.content,
    this.contentSemantics,
    required this.acceptMessage,
    this.acceptSemantics,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) => Positioned(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: SelectionArea(
          child: AlertDialog(
            // Title
            title: title,
            titlePadding: EdgeInsets.symmetric(
              horizontal: config.marginVal,
              vertical: config.spacing / 2,
            ),

            // Content
            content: Text(content, semanticsLabel: contentSemantics, textAlign: TextAlign.center),
            contentPadding: EdgeInsets.symmetric(
              horizontal: config.marginVal,
              vertical: config.spacing / 2,
            ),

            // Actions
            actions: <Widget>[
              EzAction(config,
                  text: acceptMessage, semantics: acceptSemantics, onPressed: onAccept),
            ],
            actionsAlignment: config.isLefty ? MainAxisAlignment.start : MainAxisAlignment.end,

            // General
            iconPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.all(config.marginVal),
            actionsPadding: EzInsets.wrap(config.spacing),
          ),
        ),
      );
}
