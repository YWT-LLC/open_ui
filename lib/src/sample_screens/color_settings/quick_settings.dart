/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class QuickColorSettings extends StatelessWidget {
  final EzCP config;

  final List<Widget>? quickHeader;
  final List<Widget>? quickFooter;
  final Widget resetSpacer;
  final Set<String>? resetExtraDark;
  final Set<String>? resetExtraLight;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  const QuickColorSettings(
    this.config, {
    super.key,
    required this.quickHeader,
    required this.quickFooter,
    required this.resetSpacer,
    required this.resetExtraDark,
    required this.resetExtraLight,
    required this.resetSkip,
    required this.saveSkip,
  });

  @override
  Widget build(BuildContext context) => EzCol(
    children: <Widget>[
      if (quickHeader != null) ...quickHeader!,

      // From image
      Semantics(
        label: config.ezL10n.csSchemeBase.replaceAll('\n', ' '),
        value: config.ezL10n.gOptional,
        button: true,
        hint: config.ezL10n.csFromImage,
        child: ExcludeSemantics(
          child: EzImageSetting(
            config,
            pathKey: config.isDark ? darkColorSchemeImageKey : lightColorSchemeImageKey,
            fitKey: null,
            label: config.ezL10n.csSchemeBase,
            setColors: true,
            showEditor: false,
            showFitOption: false,
          ),
        ),
      ),
      config.separator,

      // High contrast
      EzHighContrastColorsSetting(config),
      config.spacer,

      // MonoChrome
      EzMonoChromeColorsSetting(config),

      // Additional settings
      if (quickFooter != null) ...quickFooter!,

      // Local reset
      resetSpacer,
      EzResetButton(
        config,
        all: false,
        dynamicTitle: () => config.ezL10n.csReset(ezThemeString(config, bothable: true)),
        resetSkip: resetSkip,
        onConfirm: () async {
          if (EzCM.updateBoth) {
            await EzCM.removeKeys(allColorKeys.keys.toSet());
            if (resetExtraDark != null) {
              await EzCM.removeKeys(resetExtraDark!);
            }
            if (resetExtraLight != null) {
              await EzCM.removeKeys(resetExtraLight!);
            }
          } else {
            if (config.isDark) {
              await EzCM.removeKeys(darkColorKeys.keys.toSet());
              if (resetExtraDark != null) {
                await EzCM.removeKeys(resetExtraDark!);
              }
            } else {
              await EzCM.removeKeys(lightColorKeys.keys.toSet());
              if (resetExtraLight != null) {
                await EzCM.removeKeys(resetExtraLight!);
              }
            }
          }
        },
      ),
      config.separator,
    ],
  );
}
