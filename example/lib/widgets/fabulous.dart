/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';
import 'package:oui_bios/oui_bios.dart';

import 'package:flutter/material.dart';
import 'package:open_ui/open_ui.dart';

EzUpdaterFAB updater(EzCP config) => EzUpdaterFAB(
      config,
      appVersion: '4.0.0',
      versionSource:
          'https://raw.githubusercontent.com/YWT-LLC/open_ui/refs/heads/main/example/APP_VERSION',
      gPlay: 'https://play.google.com/store/apps/details?id=llc.ywt.open_ui',
      appStore: 'https://apps.apple.com/us/app/open-ui/id6499560244',
      github: 'https://github.com/YWT-LLC/open_ui/releases',
    );

class ResetFAB extends StatelessWidget {
  final EzCP config;
  final void Function() clear;
  final void Function() state;

  /// Opens an [EzAlertDialog] for resetting the form fields, app settings, both, or none
  const ResetFAB(this.config, {super.key, required this.clear, required this.state});

  @override
  Widget build(BuildContext context) => Tooltip(
        message: config.ezL10n.gReset,
        excludeFromSemantics: true,
        child: Semantics(
          label: config.ezL10n.gReset,
          button: true,
          hint: l10n(config).csResetHint,
          child: ExcludeSemantics(
            child: FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext dCon) => EzAlertDialog(
                  config,
                  title: Text('${config.ezL10n.gReset}...', textAlign: TextAlign.center),
                  actions: <Widget>[
                    // Builder/forms
                    EzAction(
                      config,
                      onPressed: () async {
                        clear();
                        await config.rebuildUI(noECT);
                        state();
                      },
                      text: l10n(config).csResetBuilder,
                      isDefaultAction: true,
                    ),

                    // App settings
                    EzAction(
                      config,
                      onPressed: () async {
                        await config.rebuildUI(
                          allECT,
                          changes: () => EzCM.reset(config.isDark, forceBoth: true),
                        );
                        state();
                      },
                      text: l10n(config).csResetApp,
                      isDestructiveAction: true,
                    ),

                    // Both
                    EzAction(
                      config,
                      onPressed: () async {
                        await config.rebuildUI(
                          allECT,
                          changes: () async {
                            clear();
                            await EzCM.reset(config.isDark, forceBoth: true);
                          },
                        );
                        state();
                      },
                      text: l10n(config).csResetBoth,
                      isDestructiveAction: true,
                    ),

                    // None
                    EzAction(
                      config,
                      onPressed: () => Navigator.of(dCon).pop(),
                      text: l10n(config).csResetNothing,
                    ),
                  ],
                  needsClose: false,
                ),
              ),
              child: EzIcon(config, Icons.refresh),
            ),
          ),
        ),
      );
}

/// When needed, add this an modify the main router
class MacStoreFAB extends StatelessWidget {
  final EzCP config;

  /// Opens an [EzAlertDialog] for resetting the form fields, app settings, both, or none
  const MacStoreFAB(this.config, {super.key});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        heroTag: 'mac_store_fab',
        tooltip: 'EoL',
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext dCon) => EzAlertDialog(
            config,
            contents: <Widget>[
              const Text(
                '''Good news: Open UI is now an app generator!

Bad news: the new features cannot be supported on the App Store.

The full (free and open source) app generator can be downloaded from the ''',
                textAlign: TextAlign.center,
              ),
              EzLink(
                config,
                text: 'GitHub releases',
                url: Uri.parse(openUIReleases),
                hint: openUIReleases,
              ),
            ],
          ),
        ),
        backgroundColor: config.colors.secondary,
        foregroundColor: config.colors.onSecondary,
        child: EzIcon(config, Icons.update),
      );
}
