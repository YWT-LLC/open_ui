/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class EzAppBar extends StatelessWidget {
  final double height;
  final Widget? leading;
  final double? leadingWidth;
  final Widget title;
  final List<Widget>? actions;

  /// [AppBar] wrapped in a [PreferredSize] and local [IconButtonTheme]
  const EzAppBar({
    super.key,
    required this.height,
    this.leading,
    this.leadingWidth,
    required this.title,
    required this.actions,
  }) : assert((leading == null) == (leadingWidth == null),
            'If you provide leading you must provide leadingWidth, vice versa');

  @override
  Widget build(BuildContext context) => IconButtonTheme(
        data: IconButtonThemeData(
          style: IconButton.styleFrom(
            side: BorderSide.none,
            padding: EzInsets.wrap(EzConfig.marginVal),
            iconSize: EzConfig.styles.headlineLarge!.fontSize,
            backgroundColor: EzConfig.colors.surfaceDim,
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
