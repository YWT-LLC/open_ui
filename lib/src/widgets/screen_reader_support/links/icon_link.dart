/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EzIconLink extends StatefulWidget {
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
  const EzIconLink({
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
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzIconLink> createState() => _EzIconLinkState();
}

class _EzIconLinkState extends State<EzIconLink> {
  // Define the build data //

  late final String semantics = '${widget.label}; ${widget.hint}';

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    TextStyle? textStyle = (widget.style ?? EzConfig.styles.bodyLarge)?.copyWith(
      color: widget.textColor ?? EzConfig.colors.onSurface,
      decoration: TextDecoration.none,
      decorationColor: EzConfig.colors.primary,
    );

    // Define custom functions //

    void underline(bool addIt) {
      textStyle = textStyle?.copyWith(
        decoration: addIt ? TextDecoration.underline : TextDecoration.none,
      );
      setState(() {});
    }

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
                  onLongPress: null,
                  onHover: (bool isHovering) => underline(isHovering),
                  onFocusChange: (bool hasFocus) => underline(hasFocus),
                  icon: widget.icon,
                  iconAlignment: EzConfig.isLefty ? IconAlignment.start : IconAlignment.end,
                  label: Text(
                    widget.label,
                    style: textStyle,
                    textAlign: widget.textAlign,
                  ),
                )
              : Link(
                  uri: widget.url,
                  builder: (_, FollowLink? followLink) => TextButton.icon(
                    onPressed: followLink,
                    onLongPress: null,
                    onHover: (bool isHovering) => underline(isHovering),
                    onFocusChange: (bool hasFocus) => underline(hasFocus),
                    icon: widget.icon,
                    iconAlignment: EzConfig.isLefty ? IconAlignment.start : IconAlignment.end,
                    label: Text(
                      widget.label,
                      style: textStyle,
                      textAlign: widget.textAlign,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
