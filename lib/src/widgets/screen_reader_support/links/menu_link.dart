/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class EzMenuLink extends StatelessWidget {
  /// [Link.uri] to open
  final Uri uri;

  /// [EzMenuButton.requestFocusOnHover] passthrough
  final bool requestFocusOnHover;

  /// [EzMenuButton.onHover] passthrough
  final void Function(bool)? onHover;

  /// [EzMenuButton.onFocusChange] passthrough
  final void Function(bool)? onFocusChange;

  /// [EzMenuButton.underline] passthrough
  final bool underline;

  /// [EzMenuButton.autofocus] passthrough
  final bool autofocus;

  /// [EzMenuButton.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [EzMenuButton.style] passthrough
  final ButtonStyle? style;

  /// [EzMenuButton.icon] passthrough
  final Widget? icon;

  /// [EzMenuButton.label] passthrough
  final String label;

  /// [EzMenuButton.textStyle] passthrough
  final TextStyle? textStyle;

  /// [EzMenuButton.textAlign] passthrough
  final TextAlign? textAlign;

  /// [EzMenuButton] wrapped in a [Link]
  const EzMenuLink({
    super.key,
    required this.uri,
    this.requestFocusOnHover = true,
    this.onHover,
    this.onFocusChange,
    this.underline = false,
    this.autofocus = false,
    this.semanticsLabel,
    this.style,
    this.icon,
    required this.label,
    this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) => Link(
        uri: uri,
        builder: (_, FollowLink? followLink) => EzMenuButton(
          onPressed: () => launchUrl(uri),
          requestFocusOnHover: requestFocusOnHover,
          onHover: onHover,
          onFocusChange: onFocusChange,
          underline: underline,
          autofocus: autofocus,
          semanticsLabel: semanticsLabel,
          style: style,
          icon: icon,
          label: label,
          textStyle: textStyle,
          textAlign: textAlign,
        ),
      );
}
