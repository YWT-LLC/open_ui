/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

class EzScreen extends StatelessWidget {
  final EzCP config;
  final Widget child;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? margin;

  /// Optionally wrap [child] in a [SafeArea]
  final bool safeArea;

  /// Custom [Container] for the top layer of an (IRL) screen
  const EzScreen(
    this.config, {
    required this.child,
    super.key,
    this.alignment,
    this.margin,
    this.safeArea = false,
  });

  @override
  Widget build(BuildContext context) => safeArea
      ? Container(
          alignment: alignment,
          decoration: config.screenDecoration,
          height: double.infinity,
          width: double.infinity,
          child: SafeArea(
            child: Container(
              alignment: alignment,
              padding: margin ?? EdgeInsets.all(config.marginVal),
              height: double.infinity,
              width: double.infinity,
              child: child,
            ),
          ),
        )
      : Container(
          alignment: alignment,
          padding: margin ?? EdgeInsets.all(config.marginVal),
          decoration: config.screenDecoration,
          height: double.infinity,
          width: double.infinity,
          child: child,
        );
}
