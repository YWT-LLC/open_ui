/* empathetech_flutter_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

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
  const EzSpacer(
    this.space, {
    super.key,
    this.vertical = true,
    this.horizontal = true,
  });

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: SizedBox(
          height: vertical ? space : null,
          width: horizontal ? space : null,
        ),
      );
}

class EzDivider extends StatelessWidget {
  /// Vertical space that should be occupied
  final double height;

  /// Bounds for the [Divider]
  final BoxConstraints constraints;

  /// [Divider.thickness] passthrough
  final double? thickness;

  /// [Divider.color] passthrough
  final Color? color;

  /// [Divider.radius] passthrough
  final BorderRadius? radius;

  /// A [Divider] wrapped in a [ConstrainedBox]
  const EzDivider(
    this.height, {
    super.key,
    this.constraints = const BoxConstraints(maxWidth: 175),
    this.thickness,
    this.color,
    this.radius,
  });

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: constraints,
        child: Divider(
          height: height,
          thickness: thickness,
          color: color,
          radius: radius,
        ),
      );
}

class EzTitledDivider extends StatelessWidget {
  /// [Widget] to display just under the diving line
  final Widget title;

  /// Total vertical space that should be occupied
  final double height;

  /// Vertical space that the [Divider] specifically should occupy
  /// Recommend [EzCP.marginVal]
  final double margin;

  /// Bounds for the [Divider]
  final BoxConstraints constraints;

  /// [Divider.thickness] passthrough
  final double? thickness;

  /// [Divider.color] passthrough
  final Color? color;

  /// [Divider.radius] passthrough
  final BorderRadius? radius;

  /// A [Divider] wrapped in a [ConstrainedBox]
  const EzTitledDivider(
    this.title, {
    super.key,
    required this.height,
    required this.margin,
    this.constraints = const BoxConstraints(maxWidth: 175),
    this.thickness,
    this.color,
    this.radius,
  });

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: constraints,
        child: EzCol(children: <Widget>[
          EzSpacer(height / 2),
          Divider(
            height: margin,
            thickness: thickness,
            color: color,
            radius: radius,
          ),
          title,
          EzSpacer(height / 2),
        ]),
      );
}

class EzHeader extends StatelessWidget {
  final EzCP config;

  /// [EzCP.spacing] - [EzCP.marginVal], unless margin is larger
  const EzHeader(this.config, {super.key});

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: SizedBox.square(
            dimension:
                (config.spacing > config.marginVal) ? config.spacing - config.marginVal : 0.0),
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
              child: Text(
                config.ezL10n.gMachineTranslated,
                style: config.labelStyle,
                textAlign: textAlign,
              ),
            );
}
