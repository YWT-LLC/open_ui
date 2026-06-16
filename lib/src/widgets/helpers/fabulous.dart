/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class EzBackFAB extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [FloatingActionButton] that goes back; [Navigator.pop]
  const EzBackFAB(this.config, {super.key});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        heroTag: 'back_fab',
        tooltip: config.ezL10n.gBack,
        onPressed: () => Navigator.of(context).maybePop(),
        child: EzIcon(config, Icons.arrow_back),
      );
}

class EzConfigFAB extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Dumps everything (except the current [Locale]) by default
  final Set<String>? skip;

  /// [FloatingActionButton] that saves/loads config to/from JSON file(s)
  const EzConfigFAB(this.config, {super.key, this.skip});

  @override
  Widget build(BuildContext context) => MenuAnchor(
        builder: (_, MenuController controller, __) {
          return FloatingActionButton(
            heroTag: 'config_fab',
            tooltip: config.ezL10n.ssConfigTip,
            onPressed: () => (controller.isOpen) ? controller.close() : controller.open(),
            child: EzIcon(config, Icons.save),
          );
        },
        menuChildren: <Widget>[
          // Save config
          EzMenuButton(
            config,
            label: config.ezL10n.ssSaveConfig,
            onPressed: () => EzCM.saveConfig(config, context: context, skip: skip),
          ),

          // Load config
          EzMenuButton(
            config,
            label: config.ezL10n.ssLoadConfig,
            onPressed: () => ezConfigLoader(config, context: context),
          ),
        ],
      );
}

class EzUpdaterFAB extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Local app version
  final String appVersion;

  /// Remote app version (truth)
  final String versionSource;

  /// Whether this is a web app
  /// If true, [gPlay], [appStore], and [github] are ignored
  /// An [EzAlertDialog] will appear telling the user to hard refresh
  final bool isWeb;

  /// Google Play Store URL
  /// Fallback to GitHub if null
  final String? gPlay;

  /// Apple App Store URL
  /// Fallback to GitHub if null
  final String? appStore;

  /// GitHub Releases URL
  /// Cannot be null when [isWeb] is false
  final String? github;

  /// [Visibility] wrapped [FloatingActionButton] that links to the latest version if/when there is a mismatch
  const EzUpdaterFAB(
    this.config, {
    super.key,
    required this.appVersion,
    required this.versionSource,
    this.isWeb = false,
    this.gPlay,
    this.appStore,
    this.github,
  }) : assert(
          isWeb || github != null,
          'GitHub URL must be provided when isWeb is false',
        );

  @override
  State<EzUpdaterFAB> createState() => _EzUpdaterState();
}

class _EzUpdaterState extends State<EzUpdaterFAB> {
  // Define the build data //

  bool isLatest = true; // True to start to prevent flickering

  String? url;

  /// Platform aware instructions
  String hardRefresh() => switch (EzCM.platform) {
        TargetPlatform.android || TargetPlatform.iOS => widget.config.ezL10n.gHardRefreshMobile,
        TargetPlatform.macOS => widget.config.ezL10n.gHardRefreshMac,
        _ => widget.config.ezL10n.gHardRefresh,
      };

  // Init //

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  /// Check for Open UI updates
  Future<void> asyncInit() async {
    final bool isGPlay = await isGPlayInstall();

    if (EzCM.onMobile && (isGPlay || EzCM.platform == TargetPlatform.iOS)) {
      return; // Don't show for store installs, they will auto-update
    }

    final http.Response response = await http.get(Uri.parse(widget.versionSource));

    if (response.statusCode != 200) return;
    // Skip on failure - otherwise no internet would return a false positive

    final String latestVersion = response.body;
    if (latestVersion != widget.appVersion) {
      final List<int> latestDigits = latestVersion.split('.').map(int.parse).toList();

      if (latestDigits.length != 3) return; // Ditto

      final List<int> appDigits = widget.appVersion.split('.').map(int.parse).toList();

      for (int i = 0; i < latestDigits.length; i++) {
        if (latestDigits[i] > appDigits[i]) {
          setState(() => isLatest = false);
          return;
        } else if (latestDigits[i] < appDigits[i]) {
          return;
        } // else, continue
      }
    }

    switch (EzCM.platform) {
      case TargetPlatform.android:
        url = isGPlay ? (widget.gPlay ?? widget.github) : widget.github;
      case TargetPlatform.iOS:
        url = widget.appStore ?? widget.github;
      default:
        url = widget.github;
    }
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => Visibility(
        visible: !isLatest,
        child: widget.isWeb // Trinary required, if/else breaks iOS web links
            ? FloatingActionButton(
                heroTag: 'updater_fab',
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => EzAlertDialog(
                    widget.config,
                    title: Text(
                      widget.config.ezL10n.gUpdates,
                      textAlign: TextAlign.center,
                    ),
                    content: Text(hardRefresh(), textAlign: TextAlign.center),
                  ),
                ),
                tooltip: widget.config.ezL10n.gUpdates,
                backgroundColor: widget.config.colors.secondary,
                foregroundColor: widget.config.colors.onSecondary,
                child: EzIcon(widget.config, Icons.update),
              )
            : FloatingActionButton(
                heroTag: 'updater_fab',
                onPressed: () => launchUrl(Uri.parse(url ?? widget.github!)),
                tooltip: widget.config.ezL10n.gUpdates,
                backgroundColor: widget.config.colors.secondary,
                foregroundColor: widget.config.colors.onSecondary,
                child: EzIcon(widget.config, Icons.update),
              ),
      );
}

class EzRebuildFAB extends StatelessWidget {
  /// EzConfig provider
  final EzCP config;

  /// [FloatingActionButton] that rebuilds the app when pressed
  const EzRebuildFAB(this.config, {super.key});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        heroTag: 'rebuild_fab',
        onPressed: () => config.rebuildUI(allECT),
        tooltip: config.ezL10n.gApplyChanges,
        backgroundColor: config.colors.secondary,
        foregroundColor: config.colors.onSecondary,
        child: EzIcon(config, Icons.build),
      );
}
