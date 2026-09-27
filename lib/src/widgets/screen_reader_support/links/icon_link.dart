/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EzIconLink extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// The [TextButton.icon] label will be [Text] with [label] and all provided styling
  final String label;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [TextButton.icon] passthrough
  final Widget icon;

  /// Defaults to [ColorScheme.onSurface]
  final Color? textColor;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// Message for screen readers
  /// Don't repeat [label] here, it is appended automatically
  final String hint;

  /// [Tooltip.message] passthrough
  /// On hover/focus hint
  /// Defaults to [hint]
  final String? tooltip;

  /// [TextButton.icon] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Always has a tool [tooltip]; if one is not provided, it will default to [hint]
  /// Highlights [label] with [decorationColor] and adds an [TextDecoration.underline] on hover/focus
  const EzIconLink(
    this.config, {
    super.key,
    required this.label,
    this.style,
    required this.icon,
    this.textColor,
    this.textAlign,
    this.onTap,
    this.url,
    required this.hint,
    this.tooltip,
  }) : assert(
          (onTap == null) != (url == null),
          'Either onTap or url should be provided, but not both.',
        );

  @override
  State<EzIconLink> createState() => _EzIconLinkState();
}

class _EzIconLinkState extends State<EzIconLink> {
  late final String semantics = '${widget.label}; ${widget.hint}';

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = (widget.style ?? widget.config.bodyStyle)?.copyWith(
      color: widget.textColor ?? widget.config.colors.onSurface,
      decoration: TextDecoration.none,
      decorationColor: widget.config.colors.primary,
    );

    void underline(bool addIt) => setState(
          () => textStyle = textStyle?.copyWith(
            decoration: addIt ? TextDecoration.underline : TextDecoration.none,
          ),
        );

    // Return the build //

    return Tooltip(
      message: widget.tooltip ?? widget.hint,
      excludeFromSemantics: true,
      child: Semantics(
        link: true,
        hint: semantics,
        child: ExcludeSemantics(
          child: (widget.onTap != null)
              ? TextButton.icon(
                  onPressed: widget.onTap,
                  onHover: (bool isHovering) => underline(isHovering),
                  onFocusChange: (bool hasFocus) => underline(hasFocus),
                  icon: widget.icon,
                  iconAlignment: widget.config.isLefty ? IconAlignment.start : IconAlignment.end,
                  label: Text(widget.label, style: textStyle, textAlign: widget.textAlign),
                )
              : Link(
                  uri: widget.url,
                  builder: (_, FollowLink? followLink) => TextButton.icon(
                    onPressed: followLink,
                    onHover: (bool isHovering) => underline(isHovering),
                    onFocusChange: (bool hasFocus) => underline(hasFocus),
                    icon: widget.icon,
                    iconAlignment: widget.config.isLefty ? IconAlignment.start : IconAlignment.end,
                    label: Text(widget.label, style: textStyle, textAlign: widget.textAlign),
                  ),
                ),
        ),
      ),
    );
  }
}
