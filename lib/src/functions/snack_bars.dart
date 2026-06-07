/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

/// Standardized [SnackBar] with an [EzCountdownTimer]
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> ezSnackBar(
  EzCP config, {
  required BuildContext context,
  required String message,
  Color? backgroundColor,
  VoidCallback? onVisible,
  bool? showCloseIcon,
  Future<void> Function()? undo,
  String? undoMessage,
}) {
  final Duration toastLength =
      (undo == null) ? ezReadingTime(message) : ezReadingTime(message) + const Duration(seconds: 2);

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      showCloseIcon: showCloseIcon ?? true,
      onVisible: onVisible,
      padding: EdgeInsets.all(config.marginVal),
      width: min(
        _snackWidth(
          config,
          context: context,
          message: message,
          showCloseIcon: showCloseIcon ?? true,
          showUndo: undo != null,
          undoMsg: undoMessage,
        ),
        widthOf(context),
      ),
      content: EzRow(
        reverseHands: false,
        children: <Widget>[
          // Text
          Flexible(child: Text(message, textAlign: TextAlign.center)),

          // Undo (conditional)
          if (undo != null) ...<Widget>[
            config.rowMargin,
            EzTextButton(
              text: undoMessage ?? config.efuiL10n.gUndo,
              textStyle: config.bodyStyle?.copyWith(color: config.colors.primary),
              onPressed: () async {
                await undo();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }
              },
            ),
          ],

          // Timer
          config.rowMargin,
          EzCountdownTimer(config, duration: toastLength),

          // Close (inherited, above)
        ],
      ),
      duration: toastLength,
    ),
  );
}

double _snackWidth(
  EzCP config, {
  required BuildContext context,
  required String message,
  required bool showCloseIcon,
  required bool showUndo,
  String? undoMsg,
}) =>
    // Text width
    (config.marginVal +
        ezTextSize(
          message,
          context: context,
          style: config.theme.snackBarTheme.contentTextStyle,
        ).width) +
    // Undo width
    (showUndo
        ? (config.marginVal +
            ezTextSize(
              undoMsg ?? config.efuiL10n.gUndo,
              context: context,
              style: config.bodyStyle,
            ).width)
        : 0) +
    // Timer width
    (config.marginVal + config.iconSize + config.padding) +
    // Close width
    ((showCloseIcon ? (config.iconSize + (config.padding / 2) + config.spacing) : 0) +
        config.marginVal);
