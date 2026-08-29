/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EzLinkWidget extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// [Semantics] label; What is it?
  final String label;

  /// Is this an image?
  final bool isImage;

  /// [Semantics] hint; what does it do?
  final String hint;

  /// [Tooltip.message] passthrough
  final String tooltip;

  /// [InkWell.child] passthrough
  final Widget child;

  /// [InkWell] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  const EzLinkWidget(
    this.config, {
    super.key,
    this.onTap,
    this.url,
    required this.tooltip,
    required this.label,
    this.isImage = false,
    required this.hint,
    required this.child,
  }) : assert(
         (onTap == null) != (url == null),
         'Either onTap or url should be provided, but not both.',
       );

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    excludeFromSemantics: true,
    child: Semantics(
      label: label,
      link: true,
      image: isImage,
      hint: hint,
      child: ExcludeSemantics(
        child: onTap != null
            ? InkWell(
                focusColor: config.colors.primary.withValues(alpha: focusOpacity),
                onTap: onTap,
                child: child,
              )
            : Link(
                uri: url,
                builder: (_, FollowLink? followLink) => InkWell(
                  focusColor: config.colors.primary.withValues(alpha: focusOpacity),
                  onTap: followLink,
                  child: child,
                ),
              ),
      ),
    ),
  );
}
