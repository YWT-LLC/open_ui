/* empathetech_flutter_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EzImageLink extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [Image.image] passthrough
  final ImageProvider<Object> image;

  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// [Semantics] label; What is it?
  final String label;

  /// [Semantics] hint; what does it do?
  final String hint;

  /// [Tooltip.message] for on hover/focus
  final String tooltip;

  /// [Image.width] passthrough
  final double? width;

  /// [Image.height] passthrough
  final double? height;

  /// [Image.fit] passthrough
  final BoxFit? fit;

  /// [Image.alignment] passthrough
  final AlignmentGeometry alignment;

  /// [Image] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  const EzImageLink(
    this.config, {
    super.key,
    required this.label,
    required this.hint,
    required this.tooltip,
    this.onTap,
    this.url,

    // Image
    required this.image,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  Widget build(BuildContext context) {
    final Color focusColor = config.colors.primary.withValues(alpha: focusOpacity);

    final Image child = Image(
      image: image,
      excludeFromSemantics: true,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );

    return Tooltip(
      message: tooltip,
      excludeFromSemantics: true,
      child: Semantics(
        label: label,
        link: true,
        image: true,
        hint: hint,
        child: ExcludeSemantics(
          child: (onTap != null)
              ? InkWell(focusColor: focusColor, onTap: onTap, child: child)
              : Link(
                  uri: url,
                  builder: (_, FollowLink? followLink) => InkWell(
                    focusColor: focusColor,
                    onTap: followLink,
                    child: child,
                  ),
                ),
        ),
      ),
    );
  }
}
