/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:http/http.dart' as http;
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class EzBackFAB extends StatelessWidget {
  final EzCP config;

  /// [FloatingActionButton] that goes back; [Navigator.pop]
  const EzBackFAB(this.config, {super.key});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        heroTag: 'back_FAB',
        tooltip: config.ezL10n.gBack,
        onPressed: () => Navigator.of(context).maybePop(),
        child: EzIcon(config, Icons.arrow_back),
      );
}

class EzConfigFAB extends StatelessWidget {
  final EzCP config;

  /// Dumps everything (except the current [Locale]) by default
  final Set<String>? skip;

  /// [FloatingActionButton] that saves/loads config to/from JSON file(s)
  const EzConfigFAB(this.config, {super.key, this.skip});

  @override
  Widget build(BuildContext context) => MenuAnchor(
        builder: (_, MenuController controller, __) => FloatingActionButton(
          heroTag: 'config_FAB',
          tooltip: config.ezL10n.ssConfigTip,
          onPressed: () => toggleMenu(controller),
          child: EzIcon(config, Icons.save),
        ),
        menuChildren: <Widget>[
          EzMenuButton(
            config,
            label: config.ezL10n.ssSaveConfig,
            icon: EzIcon(config, Icons.download),
            onPressed: () => EzCM.saveConfig(config, context: context, skip: skip),
          ),
          EzMenuButton(
            config,
            label: config.ezL10n.ssLoadConfig,
            icon: EzIcon(config, Icons.upload),
            onPressed: () => ezConfigLoader(config, context: context),
          ),
        ],
      );
}

class EzUpdaterFAB extends StatefulWidget {
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
  }) : assert(isWeb || github != null, 'GitHub URL must be provided when isWeb is false');

  @override
  State<EzUpdaterFAB> createState() => _EzUpdaterState();
}

class _EzUpdaterState extends State<EzUpdaterFAB> {
  // Define the build data //

  String? url;
  String? latestVersion;
  bool isLatest = true; // True to start to prevent flickering

  /// Platform aware instructions
  String hardRefresh() => switch (EzCM.platform) {
        TargetPlatform.android || TargetPlatform.iOS => widget.config.ezL10n.gHardRefreshMobile,
        TargetPlatform.macOS => widget.config.ezL10n.gHardRefreshMac,
        _ => widget.config.ezL10n.gHardRefresh,
      };

  List<int>? parseVersion(String version) {
    final List<int?> digits = version.trim().split('.').map(int.tryParse).toList();
    if (digits.length != 3 || digits.contains(null)) return null;
    return digits.cast<int>();
  }

  /// is [a] higher than [b]?
  bool isNewer(List<int> a, List<int> b) {
    for (int i = 0; i < a.length; i++) {
      if (a[i] > b[i]) return true;
      if (a[i] < b[i]) return false;
    } // else, continue
    return false;
  }

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

    final String latest = response.body.trim();
    final List<int>? latestDigits = parseVersion(latest);
    if (latestDigits == null) return; // Ditto

    final List<int>? appDigits = parseVersion(widget.appVersion);
    if (appDigits == null || !isNewer(latestDigits, appDigits)) return;

    // Respect the user's ignored version (if any)
    final String? ignored = EzCM.ignoreVersion;
    if (ignored != null) {
      final List<int>? ignoredDigits = parseVersion(ignored);
      if (ignoredDigits != null && !isNewer(latestDigits, ignoredDigits)) return;
    }

    switch (EzCM.platform) {
      case TargetPlatform.android:
        url = isGPlay ? (widget.gPlay ?? widget.github) : widget.github;
      case TargetPlatform.iOS:
        url = widget.appStore ?? widget.github;
      default:
        url = widget.github;
    }

    if (!mounted) return;
    setState(() {
      latestVersion = latest;
      isLatest = false;
    });
  }

  /// Offer to ignore [latestVersion]
  Future<void> ignoreDialog() async {
    if (latestVersion == null) return;
    final String version = latestVersion!;

    final bool? ignore = await showDialog<bool>(
      context: context,
      builder: (BuildContext dCon) => EzAlertDialog(
        widget.config,
        title: Text(widget.config.ezL10n.gUpdates, textAlign: TextAlign.center),
        content: Text(
          widget.config.ezL10n.gIgnoreUpdate(widget.appVersion, version),
          textAlign: TextAlign.center,
        ),
        actions: ezActionPair(
          widget.config,
          confirmMsg: widget.config.ezL10n.gYes,
          onConfirm: () => Navigator.of(dCon).pop(true),
          denyMsg: widget.config.ezL10n.gCancel,
          onDeny: () => Navigator.of(dCon).pop(false),
        ),
        needsClose: false,
      ),
    );
    if (ignore != true) return;

    await EzCM.setString(ignoreVersionKey, version);
    if (mounted) setState(() => isLatest = true);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => EzAnimVis(
        widget.config,
        forceFade: true,
        forceType: EzTransitionType.none,
        visible: !isLatest,
        kid: Tooltip(
          message: widget.config.ezL10n.gUpdates,
          triggerMode: TooltipTriggerMode.manual,
          child: GestureDetector(
            onLongPress: ignoreDialog,
            child: widget.isWeb // Trinary required, if/else breaks iOS web links
                ? FloatingActionButton(
                    heroTag: 'updater_FAB',
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => EzAlertDialog(
                        widget.config,
                        title: Text(widget.config.ezL10n.gUpdates, textAlign: TextAlign.center),
                        content: Text(hardRefresh(), textAlign: TextAlign.center),
                      ),
                    ),
                    backgroundColor: widget.config.secondaryFill.asColor,
                    foregroundColor: widget.config.onSecondary,
                    child: EzIcon(widget.config, Icons.update),
                  )
                : FloatingActionButton(
                    heroTag: 'updater_FAB',
                    onPressed: () => launchUrl(Uri.parse(url ?? widget.github!)),
                    backgroundColor: widget.config.secondaryFill.asColor,
                    foregroundColor: widget.config.onSecondary,
                    child: EzIcon(widget.config, Icons.update),
                  ),
          ),
        ),
      );
}

class EzRebuildFAB extends StatelessWidget {
  final EzCP config;

  /// [FloatingActionButton] that rebuilds the app when pressed
  const EzRebuildFAB(this.config, {super.key});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        heroTag: 'rebuild_FAB',
        onPressed: () => config.rebuildUI(),
        tooltip: config.ezL10n.gApplyChanges,
        backgroundColor: config.secondaryFill.asColor,
        foregroundColor: config.onSecondary,
        child: EzIcon(config, Icons.build),
      );
}
