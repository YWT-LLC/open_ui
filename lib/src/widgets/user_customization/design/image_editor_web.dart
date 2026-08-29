/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class EzImageEditor extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Unsupported in web
  final String path;

  /// Unsupported in web
  final double? cropAspectRatio;

  /// Unsupported in web
  final double? initialCropAspectRatio;

  /// Unsupported in web
  final InitCropRectType initCropRectType;

  /// Unsupported in web
  const EzImageEditor(
    this.config, {
    super.key,
    required this.path,
    this.initCropRectType = InitCropRectType.imageRect,
    this.cropAspectRatio,
    this.initialCropAspectRatio,
  }) : assert(
         cropAspectRatio == null ||
             initialCropAspectRatio == null ||
             cropAspectRatio == initialCropAspectRatio,
         'If both cropAspectRatio and initialCropAspectRatio are provided, they must be equal.',
       );

  @override
  Widget build(BuildContext context) =>
      Text(config.ezL10n.dsNoWeb, style: config.bodyStyle, textAlign: TextAlign.center);
}
