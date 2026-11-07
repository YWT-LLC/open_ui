/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzScreen extends StatelessWidget {
  final EzCP config;

  /// Screen content
  final Widget child;

  final AlignmentGeometry? alignment;

  /// Margin around the screen content
  final EdgeInsetsGeometry? margin;

  /// Optional wrap [child] in a [SafeArea]
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

  Decoration? buildDecoration() {
    final String path = config.backgroundImagePath;
    if (path == noImageValue) {
      return (config.surfaceContainerFill.gradient == null)
          ? null
          : BoxDecoration(gradient: config.surfaceContainerFill.gradient);
    }

    final int? isColor = int.tryParse(path);
    if (isColor != null) return BoxDecoration(color: Color(isColor));

    final LinearGradient? isGradient =
        (path.split(colorSplit).length >= 4) ? ezLGFromString(path) : null;
    if (isGradient != null) return BoxDecoration(gradient: isGradient);

    return BoxDecoration(image: config.backgroundImage);
  }

  @override
  Widget build(BuildContext context) => safeArea
      ? Container(
          alignment: alignment,
          decoration: buildDecoration(),
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
          decoration: buildDecoration(),
          height: double.infinity,
          width: double.infinity,
          child: child,
        );
}
