/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

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
  Widget build(BuildContext context) => IconButtonTheme(
        data: IconButtonThemeData(
          style: IconButton.styleFrom(
            backgroundColor: config.surfaceDim,
            iconSize: config.headlineStyle!.fontSize,
            padding: EzInsets.wrap(config.marginVal),
            side: BorderSide.none,
          ),
        ),
        child: AppBar(
          excludeHeaderSemantics: true,
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
