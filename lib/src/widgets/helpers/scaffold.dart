/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:flutter/material.dart';

class EzScaffold extends Scaffold {
  final EzCP config;

  /// [List] of (preferably) [FloatingActionButton]s
  final List<Widget>? fabs;

  /// Sole entry of [Scaffold.persistentFooterButtons]
  /// [EzFooter] recommended
  final Widget? footer;

  /// Optional override
  /// Defaults to [AlignmentDirectional.centerEnd]
  final AlignmentDirectional? footerAlign;

  /// [Scaffold] wrapper with ezPresets
  EzScaffold(
    this.config, {
    super.key,
    super.appBar,
    super.drawer,
    super.endDrawer,
    required super.body,
    required this.footer,
    this.footerAlign,
    required this.fabs,
  }) : super(
          floatingActionButton: (fabs == null) ? null : EzCol(children: fabs),
          floatingActionButtonLocation: config.isLefty
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
          persistentFooterButtons: footer == null ? null : <Widget>[footer],
          persistentFooterAlignment: footerAlign ?? AlignmentDirectional.centerEnd,
          resizeToAvoidBottomInset: false,
        );
}

class EzFooter extends StatelessWidget {
  final EzCP config;

  /// Just [contributeMessage] for this locale
  final Locale defaultLocale;

  /// Just [contributeMessage] when true
  final bool human;

  final Widget? contributeMessage;
  final Widget? translateMessage;

  /// For YWT
  final String? a11howPath;

  /// Shout-out: [TextAlign.start] >> [TextAlign.left] || [TextAlign.right]
  final TextAlign textAlign;

  /// Contribution/translation links, intended for [EzScaffold.persistentFooter]
  const EzFooter(
    this.config, {
    super.key,
    this.defaultLocale = english,
    this.human = false,
    this.contributeMessage,
    this.translateMessage,
    required this.a11howPath,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) =>
      (human || (config.locale.languageCode == defaultLocale.languageCode))
          ? contributeMessage ??
              EzLink(
                config,
                text: config.ezL10n.gDevInfo,
                hint: config.ezL10n.gOpenLink,
                tooltip: ywt.websiteContributeMula,
                url: Uri.parse(ywt.websiteContributeMula),
              )
          : translateMessage ??
              EzRichText(
                config,
                children: <InlineSpan>[
                  EzPlainText(
                    text: config.ezL10n.gMachineTranslated,
                    style: config.labelStyle,
                  ),
                  config.richLine,
                  EzPlainText(
                    text: config.ezL10n.gA11Mistake,
                    style: config.labelStyle,
                  ),
                  EzInlineLink(
                    config,
                    text: config.ezL10n.gA11Fix,
                    style: config.labelStyle,
                    hint: config.ezL10n.gGitRequired,
                    url: (a11howPath != null)
                        ? Uri.parse('${ywt.a11howLive}?${Uri(queryParameters: <String, String>{
                                'project': a11howPath!,
                                'locale': config.locale.languageCode,
                              }).query}')
                        : Uri.parse(ywt.a11howLive),
                  ),
                ],
                style: config.labelStyle,
                textAlign: textAlign,
              );
}
