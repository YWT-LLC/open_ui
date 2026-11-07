/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:open_ui/open_ui.dart';

class EzAppBar extends StatelessWidget {
  final EzCP config;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final double? leadingWidth;
  final double? height;

  const EzAppBar(
    this.config, {
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.height,
  }) : assert(
          (leading == null) == (leadingWidth == null),
          'If you provide leading you must provide leadingWidth, vice versa',
        );

  @override
  Widget build(BuildContext context) {
    final EzSwitchColor fill = config.surfaceDimFill;
    final LinearGradient? gradient = fill.gradient;

    return IconButtonTheme(
      data: IconButtonThemeData(
        style: IconButton.styleFrom(
          side: BorderSide.none,
          padding: EzInsets.wrap(config.marginVal),
          iconSize: config.headlineStyle!.fontSize,
          backgroundColor: fill.color ?? Colors.transparent,
        ),
      ),
      child: AppBar(
        excludeHeaderSemantics: true,
        backgroundColor: fill.color ?? Colors.transparent,
        surfaceTintColor: (gradient == null) ? null : Colors.transparent,
        flexibleSpace:
            (gradient == null) ? null : DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
        toolbarHeight: height,
        leading: leading,
        leadingWidth: leadingWidth,
        title: title,
        centerTitle: true,
        titleSpacing: 0,
        actions: actions,
      ),
    );
  }
}
