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

  /// [EzMenuButton.semanticsLabel] passthrough
  final String? semanticsLabel;

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
    this.semanticsLabel,
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
          semanticsLabel: semanticsLabel,
          icon: icon,
          label: label,
          textStyle: textStyle,
          textAlign: textAlign,
        ),
      );
}
