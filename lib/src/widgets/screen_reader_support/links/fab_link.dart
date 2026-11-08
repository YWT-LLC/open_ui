/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:url_launcher/link.dart';
import 'package:material_ui/material_ui.dart';

class EzFABLink extends StatelessWidget {
  final Uri uri;

  final String? tooltip;

  final Color? foregroundColor;

  final Color? backgroundColor;

  final Object? heroTag;

  final Widget? child;

  /// [FloatingActionButton] wrapped in a [Link]
  const EzFABLink({
    super.key,
    required this.uri,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.heroTag,
    this.child,
  });

  @override
  Widget build(BuildContext context) => Link(
        uri: uri,
        builder: (_, FollowLink? followLink) => FloatingActionButton(
          tooltip: tooltip,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          heroTag: heroTag,
          onPressed: followLink,
          child: child,
        ),
      );
}
