/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzScreen extends StatelessWidget {
  /// Screen content
  final Widget child;

  /// [Container.alignment] passthrough
  final AlignmentGeometry? alignment;

  /// Margin around the screen content
  final EdgeInsetsGeometry? margin;

  /// Custom [Container] that creates a standard screen for [EzConfig] powered apps
  const EzScreen(
    this.child, {
    super.key,
    this.alignment,
    this.margin,
  });

  Decoration? buildDecoration() {
    final String path = EzConfig.backgroundImagePath;
    if (path == noImageValue) return null;

    final int? isColor = int.tryParse(path);
    if (isColor != null) return BoxDecoration(color: Color(isColor));

    debugPrint('CAW!');
    debugPrint('Path:  ${EzConfig.backgroundImagePath}');
    debugPrint('Fit:   ${EzConfig.backgroundImageFit.toString()}');
    debugPrint('CAW!');

    return BoxDecoration(image: EzConfig.backgroundImage);
  }

  @override
  Widget build(BuildContext context) => Container(
        alignment: alignment,
        padding: margin ?? EdgeInsets.all(EzConfig.marginVal),
        decoration: buildDecoration(),
        height: double.infinity,
        width: double.infinity,
        child: child,
      );
}
