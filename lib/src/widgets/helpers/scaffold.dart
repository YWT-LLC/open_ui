/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:material_ui/material_ui.dart';

class EzScaffold extends Scaffold {
  final EzCP config;

  /// [List] of (preferably) [FloatingActionButton]s
  final List<Widget>? fabs;

  /// Sole entry of [Scaffold.persistentFooterButtons]
  /// [EzFooter] recommended
  final Widget? footer;

  /// Optional override
  /// Defaults to [AlignmentDirectional.bottomCenter]
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
          floatingActionButton: (fabs == null)
              ? null
              : EzCol(children: <Widget>[
                  ...fabs,
                  config.margin,
                ]),
          floatingActionButtonLocation: config.isLefty
              ? FloatingActionButtonLocation.startDocked
              : FloatingActionButtonLocation.endDocked,
          persistentFooterButtons:
              (footer == null || footer == const SizedBox.shrink()) ? null : <Widget>[footer],
          persistentFooterAlignment: footerAlign ?? AlignmentDirectional.bottomCenter,
          persistentFooterDecoration: const BoxDecoration(),
          resizeToAvoidBottomInset: false,
        );
}

class EzFooter extends StatelessWidget {
  final EzCP config;

  /// Hide the [contributeMessage] in [defaultLocale]
  /// [translateMessage]s are always present in other locales
  final bool hide;

  /// Just [contributeMessage] for this locale
  final Locale defaultLocale;

  /// Just [contributeMessage] when true
  final bool human;

  /// For YWT
  final String? a11howPath;

  /// Shout-out: [TextAlign.start] >> [TextAlign.left] || [TextAlign.right]
  final TextAlign textAlign;

  final Widget? contributeMessage;
  final Widget? translateMessage;

  /// Contribution/translation links, intended for [EzScaffold.footer]
  const EzFooter(
    this.config, {
    super.key,
    this.hide = false,
    this.defaultLocale = english,
    this.human = false,
    required this.a11howPath,
    this.textAlign = TextAlign.center,
    this.contributeMessage,
    this.translateMessage,
  });

  @override
  Widget build(BuildContext context) =>
      (human || (config.locale.languageCode == defaultLocale.languageCode))
          ? hide
              ? const SizedBox.shrink()
              : (contributeMessage ??
                  EzLink(
                    config,
                    text: config.ezL10n.gDevInfo,
                    style: config.labelStyle,
                    inline: true,
                    textAlign: textAlign,
                    url: Uri.parse(ywt.websiteContributeMula),
                    hint: config.ezL10n.gOpenLink,
                    tooltip: ywt.websiteContributeMula,
                  ))
          : (translateMessage ??
              EzRichText(
                config,
                children: <InlineSpan>[
                  // Machine translated
                  EzPlainText(
                    text: config.ezL10n.gMachineTranslated,
                    style: config.labelStyle,
                  ),
                  EzRichLine(style: config.labelStyle),

                  // See a mistake?
                  EzPlainText(
                    text: config.ezL10n.gA11Mistake,
                    style: config.labelStyle,
                  ),
                  EzInlineLink(
                    config,
                    text: config.ezL10n.gA11Fix,
                    style: config.labelStyle,
                    url: (a11howPath != null)
                        ? Uri.parse('${ywt.a11howLive}?${Uri(queryParameters: <String, String>{
                                'project': a11howPath!,
                                'locale': config.locale.languageCode,
                              }).query}')
                        : Uri.parse(ywt.a11howLive),
                    hint: config.ezL10n.gGitRequired,
                  ),
                ],
                style: config.labelStyle,
                textAlign: textAlign,
              ));
}
