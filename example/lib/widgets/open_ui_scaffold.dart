/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';
import './export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class OpenUIScaffold extends StatelessWidget {
  /// [Scaffold.body] passthrough
  final Widget body;

  /// [AppBar.title] passthrough (via [Text] widget)
  final String title;

  /// For generator pages; whether there are things running
  final bool running;

  /// Whether to include [SettingsButton] in the [MenuAnchor]
  final bool showSettings;

  /// Whether to include [UploadButton] in the [MenuAnchor]
  final Future<void> Function(EAGConfig)? onUpload;

  /// [FloatingActionButton]s to add on top of the [EzUpdaterFAB]
  /// BYO spacing widgets
  final List<Widget>? fabs;

  /// For [EzConfig.backFABs]
  final bool home;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const OpenUIScaffold(
    this.body, {
    super.key,
    this.title = thisAppName,
    this.running = false,
    this.showSettings = true,
    this.onUpload,
    this.fabs,
    this.home = false,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final double toolbarHeight = ezToolbarHeight(context: context, title: title);

    // Define custom widgets //

    final Widget options = MenuAnchor(
      builder: (_, MenuController controller, ___) => EzIconButton(
        onPressed: () => (controller.isOpen) ? controller.close() : controller.open(),
        tooltip: EzConfig.l10n.gOptions,
        icon: Icon(
          Icons.more_vert,
          semanticLabel: EzConfig.l10n.gOptions,
          size: EzConfig.styles.titleLarge!.fontSize,
        ),
      ),
      menuChildren: <Widget>[
        if (showSettings) SettingsButton(context),
        if (onUpload != null) UploadButton(onUpload!),
        const OpenSourceButton(),
      ],
    );

    // Return the build //

    return EzAdaptiveParent(
      small: EzScaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, toolbarHeight),
          child: EzAppBar(
            height: toolbarHeight,
            leading: running
                ? const SizedBox.shrink()
                : (EzConfig.isLefty ? options : const EzBackAction()),
            leadingWidth: toolbarHeight,
            title: Text(title, textAlign: TextAlign.center),
            actions: <Widget>[
              running
                  ? const SizedBox.shrink()
                  : (EzConfig.isLefty ? const EzBackAction() : options)
            ],
          ),
        ),
        body: body,
        fabs: <Widget>[
          updater,
          if (fabs != null) ...fabs!,
          ...EzConfig.backFABs(home),
        ],
      ),
    );
  }
}
