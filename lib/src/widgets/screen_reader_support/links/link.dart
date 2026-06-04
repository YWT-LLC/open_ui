/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class EzLink extends StatefulWidget {
  /// The [TextButton.child] will be [Text] with [text] and all provided styling
  final String text;

  /// Dictates the padding (none for inline)
  final bool inline;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// Defaults to [ColorScheme.primary]
  final Color? textColor;

  /// Optional override for [TextButton.style]
  final Color? backgroundColor;

  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// Optional callback for hover events
  /// Will run in addition to the built-in [EzLink] hover effects
  final Function(bool hovering)? onHover;

  /// Message for screen readers
  /// Don't repeat [text] here, it is appended automatically
  final String hint;

  /// [Tooltip.message] passthrough
  /// On hover/focus hint
  /// Defaults to [hint]
  final String? tooltip;

  /// [TextButton] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Always has a [tooltip]; if one is not provided, it will default to [hint]
  /// Adds an [TextDecoration.underline] on hover/focus
  const EzLink(
    this.text, {
    super.key,
    this.inline = false,
    this.style,
    this.textColor,
    this.backgroundColor,
    this.textAlign,
    this.onTap,
    this.url,
    required this.hint,
    this.tooltip,
    this.onHover,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzLink> createState() => _EzLinkState();
}

class _EzLinkState extends State<EzLink> {
  // Define the build data //

  late final String semantics = '${widget.text}; ${widget.hint}';

  late TextStyle? textStyle = (widget.style ?? EzConfig.bodyStyle)?.copyWith(
    color: widget.textColor ?? EzConfig.colors.primary,
    decoration: EzConfig.lineLinks ? TextDecoration.underline : TextDecoration.none,
    decorationColor: EzConfig.colors.primary,
  );

  // Define custom functions //

  void underline(bool addIt) => (EzConfig.lineLinks)
      ? doNothing()
      : setState(() => textStyle =
          textStyle?.copyWith(decoration: addIt ? TextDecoration.underline : TextDecoration.none));

  // Return the build //
  @override
  Widget build(BuildContext context) => Tooltip(
        message: widget.tooltip ?? widget.hint,
        excludeFromSemantics: true,
        child: Semantics(
          link: true,
          hint: semantics,
          child: ExcludeSemantics(
            child: (widget.onTap != null)
                ? TextButton(
                    style: TextButton.styleFrom(
                      padding: widget.inline ? EdgeInsets.zero : EdgeInsets.all(EzConfig.marginVal),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      minimumSize: Size.zero,
                      backgroundColor: widget.backgroundColor,
                    ),
                    onPressed: widget.onTap,
                    onLongPress: null,
                    onHover: (bool isHovering) {
                      underline(isHovering);
                      widget.onHover?.call(isHovering);
                    },
                    onFocusChange: (bool hasFocus) => underline(hasFocus),
                    child: Text(
                      widget.text,
                      style: textStyle,
                      textAlign: widget.textAlign,
                    ),
                  )
                : Link(
                    uri: widget.url,
                    builder: (_, FollowLink? followLink) => TextButton(
                      style: TextButton.styleFrom(
                        padding:
                            widget.inline ? EdgeInsets.zero : EdgeInsets.all(EzConfig.marginVal),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        minimumSize: Size.zero,
                        backgroundColor: widget.backgroundColor,
                      ),
                      onPressed: followLink,
                      onLongPress: null,
                      onHover: (bool isHovering) {
                        underline(isHovering);
                        widget.onHover?.call(isHovering);
                      },
                      onFocusChange: (bool hasFocus) => underline(hasFocus),
                      child: Text(
                        widget.text,
                        style: textStyle,
                        textAlign: widget.textAlign,
                      ),
                    ),
                  ),
          ),
        ),
      );
}
