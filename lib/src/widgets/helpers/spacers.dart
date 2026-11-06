/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:flutter/material.dart';

// Spacers //

class EzSpacer extends StatelessWidget {
  /// The final frontier
  final double space;

  final bool vertical;
  final bool horizontal;

  const EzSpacer(
    this.space, {
    super.key,
    this.vertical = true,
    this.horizontal = true,
  });

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
      child: SizedBox(height: vertical ? space : null, width: horizontal ? space : null));
}

class EzKeyboardSpacer extends StatelessWidget {
  /// The final frontier
  /// [MediaQuery]'s [EdgeInsets.bottom] will be appended automatically
  final double space;

  /// Always ignores [MediaQuery]
  final bool horizontal;

  /// A spacer that automatically responds to on-screen keyboard open/close
  const EzKeyboardSpacer(
    this.space, {
    super.key,
    this.horizontal = true,
  });

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: SizedBox(
          key: UniqueKey(),
          height: space + MediaQuery.of(context).viewInsets.bottom,
          width: horizontal ? space : null,
        ),
      );
}

class EzSwapSpacer extends StatelessWidget {
  /// The final frontier
  final double space;

  /// Which [ScreenSize] the Widget should respond to
  final ScreenSize breakpoint;

  /// When the context's [ScreenSize] > [breakpoint]; [EzSpacer.vertical] => false
  /// When the context's [ScreenSize] <= [breakpoint]; [EzSpacer.horizontal] => false
  /// If [EzScreenSize] is not in the Widget tree; [EzSpacer.horizontal] => false
  const EzSwapSpacer(this.space, {super.key, this.breakpoint = ScreenSize.small});

  @override
  Widget build(BuildContext context) {
    final ScreenSize? size = EzScreenSize.of(context)?.screenSize;

    return (size == null || size.order <= breakpoint.order)
        ? EzSpacer(space, horizontal: false)
        : EzSpacer(space, vertical: false);
  }
}

// Dividers //

Widget _ezDividerFill(EzSwitchColor fill, Widget divider) => (fill.gradient == null)
    ? divider
    : ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) => fill.gradient!.createShader(bounds),
        child: divider,
      );

class EzDivider extends StatelessWidget {
  final EzCP config;

  /// Defaults to [EzCP.spacing] * 3
  final double? height;

  final double width;
  final double? thickness;

  /// Defaults to [EzCP.secondaryFill]
  final EzSwitchColor? fill;

  final BorderRadius? radius;

  const EzDivider(
    this.config, {
    super.key,
    this.height,
    this.width = 175.0,
    this.thickness,
    this.fill,
    this.radius,
  });

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width),
        child: _ezDividerFill(
          fill ?? config.secondaryFill,
          Divider(
            height: height ?? (config.spacing * 3),
            thickness: thickness,
            color: (fill ?? config.secondaryFill).color,
            radius: radius,
          ),
        ),
      );
}

class EzVerticalDivider extends StatelessWidget {
  final EzCP config;
  final double width;
  final double height;
  final double? thickness;

  /// Defaults to [EzCP.secondaryFill]
  final EzSwitchColor? fill;

  final BorderRadius? radius;

  const EzVerticalDivider(
    this.config, {
    super.key,
    required this.width,
    this.height = 175.0,
    this.thickness,
    this.fill,
    this.radius,
  });

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height),
        child: _ezDividerFill(
          fill ?? config.secondaryFill,
          VerticalDivider(
            width: width,
            thickness: thickness,
            color: (fill ?? config.secondaryFill).color,
            radius: radius,
          ),
        ),
      );
}

class EzTitledDivider extends StatelessWidget {
  final EzCP config;
  final Widget title;

  /// When true, [title] is above the [Divider] line
  /// Default false, aka [title] below the [Divider] line
  final bool header;

  final double height;
  final double width;
  final double? thickness;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  /// Defaults to [EzCP.secondaryFill]
  final EzSwitchColor? fill;

  final BorderRadius? radius;

  /// An [EzDivider] with a [title]
  const EzTitledDivider(
    this.config, {
    super.key,
    required this.title,
    this.header = false,
    required this.height,
    this.width = 175.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.thickness,
    this.fill,
    this.radius,
  });

  @override
  Widget build(BuildContext context) => EzCol(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          EzSpacer(height / 2),
          if (header) title,
          EzDivider(
            config,
            height: config.marginVal,
            width: width * ezIconRatio(config),
            thickness: thickness,
            fill: fill,
            radius: radius,
          ),
          if (!header) title,
          EzSpacer(height / 2),
        ],
      );
}

// Trimming //

class EzHeader extends StatelessWidget {
  final EzCP config;

  /// [EzCP.spacing] - [EzCP.marginVal], unless margin is larger
  const EzHeader(this.config, {super.key});

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: SizedBox.square(
          dimension: (config.spacing > config.marginVal) ? config.spacing - config.marginVal : 0.0,
        ),
      );
}

class EzFooter extends StatelessWidget {
  final EzCP config;

  /// Just [EzCP.separator] when true
  final bool blank;

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

  const EzFooter(
    this.config, {
    super.key,
    this.blank = false,
    this.defaultLocale = english,
    this.human = false,
    this.contributeMessage,
    this.translateMessage,
    required this.a11howPath,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) => blank
      ? config.separator
      : Padding(
          padding: EdgeInsets.only(top: config.spacing * 4, bottom: config.spacing),
          child: (human || (config.locale.languageCode == defaultLocale.languageCode))
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
                  ),
        );
}
