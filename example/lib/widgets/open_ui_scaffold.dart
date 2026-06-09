/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';
import './export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class OpenUIScaffold extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

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

  /// For [EzCP.backFABs]
  final bool isHome;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const OpenUIScaffold(
    this.config, {
    super.key,
    this.title = thisAppName,
    this.running = false,
    this.showSettings = true,
    this.onUpload,
    required this.body,
    this.fabs,
    this.isHome = false,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final double toolbarHeight = ezToolbarHeight(config, context: context, title: title);

    // Define custom widgets //

    final Widget options = MenuAnchor(
      builder: (_, MenuController controller, ___) => EzIconButton(
        config,
        onPressed: () => (controller.isOpen) ? controller.close() : controller.open(),
        tooltip: config.ezL10n.gOptions,
        icon: Icon(
          Icons.more_vert,
          semanticLabel: config.ezL10n.gOptions,
          size: config.titleStyle!.fontSize,
        ),
      ),
      menuChildren: <Widget>[
        if (showSettings) SettingsButton(config, parentContext: context),
        if (onUpload != null) UploadButton(config, onUpload: onUpload!),
        OpenSourceButton(config),
      ],
    );

    // Return the build //

    return EzAdaptiveParent(
      small: EzScaffold(
        config,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, toolbarHeight),
          child: EzAppBar(
            config,
            height: toolbarHeight,
            leading: running
                ? const SizedBox.shrink()
                : (config.isLefty ? options : EzBackAction(config)),
            leadingWidth: toolbarHeight,
            title: Text(title, textAlign: TextAlign.center),
            actions: <Widget>[
              running ? const SizedBox.shrink() : (config.isLefty ? EzBackAction(config) : options)
            ],
          ),
        ),
        body: body,
        fabs: <Widget>[
          updater(config),
          if (fabs != null) ...fabs!,
          ...config.backFABs(isHome),
        ],
      ),
    );
  }
}
