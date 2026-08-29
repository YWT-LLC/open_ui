/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

// Default constructors //

class EzSpacer extends StatelessWidget {
  /// The final frontier
  final double space;

  /// Whether [space] should be provided to [SizedBox.height]
  final bool vertical;

  /// Whether [space] should be provided to [SizedBox.width]
  final bool horizontal;

  /// [SizedBox] with [space] dimensions for organizing your layout
  const EzSpacer(this.space, {super.key, this.vertical = true, this.horizontal = true});

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: SizedBox(height: vertical ? space : null, width: horizontal ? space : null),
      );
}

class EzDivider extends StatelessWidget {
  /// Vertical space that should be occupied
  final double height;

  /// [BoxConstraints.maxWidth] value for the [Divider]
  final double width;

  /// [Divider.thickness] passthrough
  final double? thickness;

  /// [Divider.color] passthrough
  final Color? color;

  /// [Divider.radius] passthrough
  final BorderRadius? radius;

  /// A [Divider] wrapped in a [ConstrainedBox]
  const EzDivider({
    super.key,
    required this.height,
    this.width = 175.0,
    this.thickness,
    this.color,
    this.radius,
  });

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width),
        child: Divider(
          height: height,
          thickness: thickness,
          color: color,
          radius: radius,
        ),
      );
}

class EzTitledDivider extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [Widget] to display just under the diving line
  final Widget title;

  /// When true, [title] is above the [Divider] line
  /// Default false, aka [title] below the [Divider] line
  final bool header;

  /// Total vertical space that should be occupied
  final double height;

  /// [BoxConstraints.maxWidth] value for the [Divider]
  final double width;

  /// [Divider.thickness] passthrough
  final double? thickness;

  /// [EzCol.mainAxisAlignment] passthrough
  final MainAxisAlignment mainAxisAlignment;

  /// [EzCol.crossAxisAlignment] passthrough
  final CrossAxisAlignment crossAxisAlignment;

  /// [Divider.color] passthrough
  final Color? color;

  /// [Divider.radius] passthrough
  final BorderRadius? radius;

  /// A [Divider] wrapped in a [ConstrainedBox]
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
    this.color,
    this.radius,
  });

  @override
  Widget build(BuildContext context) => EzCol(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          EzSpacer(height / 2),
          if (header) title,
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width * ezIconRatio(config)),
            child: Divider(
              height: config.marginVal,
              thickness: thickness,
              color: color,
              radius: radius,
            ),
          ),
          if (!header) title,
          EzSpacer(height / 2),
        ],
      );
}

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

class EzFooter extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Just an [EzCP.separator] for this [Locale]
  final Locale defaultLocale;

  /// Optional override
  final Widget? message;

  /// The current screen/page is human translated
  /// Just an [EzCP.separator] when true
  final bool human;

  /// Shout-out: [TextAlign.start] >> [TextAlign.left] || [TextAlign.right]
  final TextAlign textAlign;

  /// Optionally override [EzCP.spacing] * 2
  final double? spacing;

  const EzFooter(
    this.config, {
    super.key,
    this.defaultLocale = english,
    this.message,
    this.human = false,
    this.textAlign = TextAlign.center,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) =>
      (human || (config.locale.languageCode == defaultLocale.languageCode))
          ? config.separator
          : Padding(
              padding: EdgeInsets.only(top: spacing ?? (config.spacing * 2)),
              child: message ??
                  Text(
                    config.ezL10n.gMachineTranslated,
                    style: config.labelStyle,
                    textAlign: textAlign,
                  ),
            );
}
