/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class EzMenuLink extends StatelessWidget {
  final EzCP config;

  /// [Link.uri] to open
  final Uri uri;

  final String? semanticsLabel;

  final Widget? icon;

  final String? label;

  final TextStyle? textStyle;

  final TextAlign? textAlign;

  /// [EzMenuButton] wrapped in a [Link]
  const EzMenuLink(
    this.config, {
    super.key,
    required this.uri,
    this.semanticsLabel,
    this.icon,
    this.label,
    this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) => Link(
        uri: uri,
        builder: (_, FollowLink? followLink) => EzMenuButton(
          config,
          onPressed: () => launchUrl(uri),
          semanticsLabel: semanticsLabel,
          icon: icon,
          label: label,
          textStyle: textStyle,
          textAlign: textAlign,
        ),
      );
}
