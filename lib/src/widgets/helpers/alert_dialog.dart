/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzAlertDialog extends AlertDialog {
  /// EzConfig Provider
  final EzCP config;

  /// Dialog content becomes [contents] in an [EzScrollView]
  final List<Widget>? contents;

  /// Whether a "Close" [Action] should be included
  final bool needsClose;

  /// [AlertDialog] wrapper with custom styling
  const EzAlertDialog(
    this.config, {
    super.key,
    super.title,
    super.content,
    this.contents,
    super.actions,
    this.needsClose = true,
  }) : assert(
         (content == null && contents == null) || ((content == null) != (contents == null)),
         'Either content or contents should be provided, but not both.',
       );

  @override
  Widget build(BuildContext context) {
    // Define the content //

    final Widget? dialogContent =
        content ?? ((contents == null) ? null : EzScrollView(config, children: contents!));

    late final Widget closeAction = EzAction(
      config,
      text: config.ezL10n.gClose,
      onPressed: () => Navigator.of(context).pop(),
    );

    late final List<Widget>? closedActions = needsClose
        ? (actions?.length ?? 0) > 1
              ? <Widget>[...actions!, closeAction]
              : <Widget>[closeAction, if (actions != null) ...actions!]
        : actions;

    // Return the build //

    return SelectionArea(
      child: AlertDialog(
        // Title
        title: title,
        titlePadding: title == null
            ? null
            : EdgeInsets.only(
                top: config.marginVal,
                left: config.marginVal,
                right: config.marginVal,
              ),

        // Content
        content: dialogContent,
        contentPadding: dialogContent == null
            ? null
            : EdgeInsets.only(
                top: (title == null) ? config.marginVal : config.spacing,
                left: config.marginVal,
                right: config.marginVal,
              ),

        // Actions
        actions: (closedActions == null)
            ? null
            : closedActions.length <= 2
            ? config.isLefty
                  ? closedActions.reversed.toList()
                  : closedActions
            : <Widget>[EzCol(mainAxisAlignment: MainAxisAlignment.center, children: closedActions)],
        actionsAlignment: (closedActions != null && closedActions.length > 2)
            ? MainAxisAlignment.center
            : config.isLefty
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,

        // General
        iconPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.all(config.marginVal),
        actionsPadding: EzInsets.wrap(config.spacing),
      ),
    );
  }
}

class EzAction extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [EzTextButton.text] passthrough
  final String text;

  /// Optional [Semantics] override for [text]
  final String? semantics;

  /// [EzTextButton.onPressed] passthrough
  final void Function() onPressed;

  /// Will add [FontWeight.bold] to [style]
  final bool isDefaultAction;

  /// Will add [ColorScheme.error] to [style]
  final bool isDestructiveAction;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [EzTextButton] wrapper with custom styling for an [AlertDialog]
  const EzAction(
    this.config, {
    super.key,
    required this.text,
    this.semantics,
    required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? baseStyle = style ?? config.bodyStyle;

    final TextStyle? textStyle = isDefaultAction
        ? baseStyle?.copyWith(fontWeight: FontWeight.bold)
        : isDestructiveAction
        ? baseStyle?.copyWith(color: config.colors.error)
        : baseStyle;

    return EzTextButton(
      config,
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: config.colors.surfaceDim,
        padding: EzInsets.wrap(config.spacing),
      ),
      text: text,
      semantics: semantics,
      textStyle: textStyle,
    );
  }
}

/// Pairs with [EzAlertDialog]
List<EzAction> ezActionPair(
  EzCP config, {
  String? confirmMsg,
  required void Function() onConfirm,
  bool confirmIsDefault = false,
  bool confirmIsDestructive = false,
  String? denyMsg,
  required void Function() onDeny,
  bool denyIsDefault = false,
  bool denyIsDestructive = false,
  TextStyle? style,
}) => <EzAction>[
  EzAction(
    config,
    text: denyMsg ?? config.ezL10n.gNo,
    onPressed: onDeny,
    isDefaultAction: denyIsDefault,
    isDestructiveAction: denyIsDestructive,
    style: style,
  ),
  EzAction(
    config,
    text: confirmMsg ?? config.ezL10n.gYes,
    onPressed: onConfirm,
    isDefaultAction: confirmIsDefault,
    isDestructiveAction: confirmIsDestructive,
    style: style,
  ),
];
