/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class EzToolTipper extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [Tooltip.message] passthrough
  final String? message;

  /// [Tooltip.richMessage] passthrough
  final InlineSpan? richMessage;

  /// Classic question mark tool tip
  const EzToolTipper(
    this.config, {
    super.key,
    this.message,
    this.richMessage,
  }) : assert(((message == null) != (richMessage == null)),
            'Either message or richMessage must be provided, but not both');

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> key = GlobalKey<TooltipState>();
    bool isTooltipVisible = false;

    return EzTextBackground(
      config,
      padding: EdgeInsets.all(config.marginVal),
      text: Semantics(
        label: config.ezL10n.gHelp,
        button: true,
        onTap: () async {
          if (isTooltipVisible) {
            Tooltip.dismissAllToolTips();
          } else {
            key.currentState?.ensureTooltipVisible();

            // Wait for auto-announcement to finish
            await Future<void>.delayed(ezReadingTime(config, config.ezL10n.gHelp));
            String message = this.message ?? '';

            if (richMessage != null) {
              if (richMessage.runtimeType == EzInlineLink) {
                message = (richMessage as EzInlineLink).hint;
              } else if (richMessage.runtimeType == TextSpan) {
                for (final InlineSpan child in (richMessage as TextSpan).children!) {
                  switch (child.runtimeType) {
                    case const (TextSpan):
                      final TextSpan ogSpan = child as TextSpan;
                      message += ogSpan.semanticsLabel ?? ogSpan.text!;
                      break;
                    case const (EzPlainText):
                      final EzPlainText plainSpan = child as EzPlainText;
                      message += plainSpan.semanticsLabel ?? plainSpan.text!;
                      break;
                    case const (EzInlineLink):
                      final EzInlineLink linkSpan = child as EzInlineLink;
                      message += linkSpan.richLabel ?? linkSpan.text;
                      break;
                    default:
                      break;
                  }
                }
              }
            }

            if (context.mounted) {
              await SemanticsService.sendAnnouncement(
                View.of(context),
                message,
                config.isLTR ? TextDirection.ltr : TextDirection.rtl,
                assertiveness: Assertiveness.assertive,
              );
            }
          }
          isTooltipVisible = !isTooltipVisible;
        },
        child: Tooltip(
          waitDuration: Duration.zero,
          showDuration: ezReadingTime(config, message ?? richMessage!.toPlainText()),
          triggerMode: TooltipTriggerMode.tap,
          excludeFromSemantics: true,
          message: message,
          richMessage: richMessage,
          child: EzIcon(
            config,
            Icons.help_outline,
            color: config.colors.outline,
          ),
        ),
      ),
      baseColor: config.colors.surface,
      borderRadius: config.textRadius,
    );
  }
}
