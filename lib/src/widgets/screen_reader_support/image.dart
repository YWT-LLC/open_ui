/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:material_ui/material_ui.dart';

class EzImage extends Image {
  /// [Image] wrapper that makes [semanticLabel] required
  const EzImage({
    super.key,
    required super.image,
    super.alignment = Alignment.center,
    super.centerSlice,
    super.color,
    super.colorBlendMode,
    super.errorBuilder,
    super.excludeFromSemantics = false,
    super.fit,
    super.filterQuality = FilterQuality.low,
    super.frameBuilder,
    super.gaplessPlayback = false,
    super.height,
    super.isAntiAlias = false,
    super.loadingBuilder,
    super.matchTextDirection = false,
    super.opacity,
    super.repeat = ImageRepeat.noRepeat,
    required super.semanticLabel,
    super.width,
  });
}
