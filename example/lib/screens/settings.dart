/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsHubScreen extends StatelessWidget {
  /// Optionally override the starting position
  final int? targetPass;

  const SettingsHubScreen({super.key, this.targetPass});

  @override
  Widget build(BuildContext context) {
    return Consumer<EzCP>(
      builder: (_, EzCP config, __) => OpenUIScaffold(
        EzScreen(EzSettingsHub(
          pages: <EzSettingsSection>[
            // Global //

            EzSettingsSection(
              position: 0,
              title: config.l10n.gGlobal,
              icon: EzIcon(
                EzCM.onMobile
                    ? EzCM.platform == TargetPlatform.iOS
                        ? Icons.phone_iphone
                        : Icons.phone_android
                    : Icons.computer,
                semanticLabel: config.l10n.gGlobal,
              ),
              subSettings: <EzSubSetting>[],
              fromStorage: () => EzSubSetting.blank,
              build: (_) => const EzGlobalSettings(),
            ),

            // Color //

            EzSettingsSection(
              position: 1,
              title: config.l10n.gColor,
              icon: EzIcon(
                Icons.palette,
                semanticLabel: config.l10n.gColor,
              ),
              subSettings: <EzSubSetting>[
                EzSubSetting.qckColor,
                EzSubSetting.advColor,
              ],
              fromStorage: () => EzCM.get(advancedColorsKey) == true
                  ? EzSubSetting.advColor
                  : EzSubSetting.qckColor,
              build: (EzSubSetting subSec) => EzColorSettings(target: subSec),
            ),

            // Design //

            EzSettingsSection(
              position: 2,
              title: config.l10n.gDesign,
              icon: EzIcon(
                Icons.design_services,
                semanticLabel: config.l10n.gDesign,
              ),
              subSettings: <EzSubSetting>[
                EzSubSetting.butDesign,
                EzSubSetting.pagDesign,
              ],
              fromStorage: () =>
                  EzCM.get(pageTabKey) == true ? EzSubSetting.pagDesign : EzSubSetting.butDesign,
              build: (EzSubSetting subSec) => EzDesignSettings(target: subSec),
            ),

            // Text //

            EzSettingsSection(
              position: 3,
              title: config.l10n.gText,
              icon: EzIcon(
                Icons.text_format,
                semanticLabel: config.l10n.gText,
              ),
              subSettings: <EzSubSetting>[
                EzSubSetting.qckText,
                EzSubSetting.advText,
              ],
              fromStorage: () =>
                  EzCM.get(advancedTextKey) == true ? EzSubSetting.advText : EzSubSetting.qckText,
              build: (EzSubSetting subSec) => EzTextSettings(target: subSec),
            ),
          ],
          target: targetPass,
        )),
        title: config.l10n.gSettings,
        showSettings: false,
        fabs: <Widget>[
          // Rebuild (conditional)
          if (config.needsRebuild) ...<Widget>[
            config.spacer,
            const EzRebuildFAB(),
          ],

          // Save/upload config
          config.spacer,
          const EzConfigFAB(),
        ],
      ),
    );
  }
}
