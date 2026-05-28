/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class AdvancedColorSettings extends StatelessWidget {
  final List<String>? extraDark;
  final List<String>? extraLight;
  final Widget resetSpacer;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  final List<String> _keys;

  AdvancedColorSettings({
    super.key,
    required this.extraDark,
    required this.extraLight,
    required this.resetSpacer,
    required this.resetSkip,
    required this.saveSkip,
  }) : _keys = (EzConfig.isDark
            ? (extraDark == null ? darkColorOrder : <String>[...extraDark, ...darkColorOrder])
            : (extraLight == null ? lightColorOrder : <String>[...extraLight, ...lightColorOrder]));

  @override
  Widget build(BuildContext context) => EzCol(children: <Widget>[
        // Dynamic color settings
        EzSwapWidget(
          expanded: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: widthOf(context) * 0.8),
            child: EzWrap(
                children: _keys
                    .map((String key) => Padding(
                          padding: EzInsets.wrap(EzConfig.spacing),
                          child: EzColorSetting(key: ValueKey<String>(key), configKey: key),
                        ))
                    .toList()),
          ),
          restricted: EzCol(
              children: _keys
                  .map((String key) => Padding(
                        padding: EzInsets.wrap(EzConfig.spacing),
                        child: EzColorSetting(key: ValueKey<String>(key), configKey: key),
                      ))
                  .toList()),
        ),

        // Local reset
        resetSpacer,
        EzResetButton(
          all: false,
          dynamicTitle: () => EzConfig.l10n.csReset(ezThemeString(false)),
          resetSkip: resetSkip,
          onConfirm: () async {
            if (EzConfig.isDark) {
              await EzConfig.removeKeys(darkColorKeys.keys.toSet());
              if (extraDark != null) {
                await EzConfig.removeKeys(extraDark!.toSet());
              }
            } else {
              await EzConfig.removeKeys(lightColorKeys.keys.toSet());
              if (extraLight != null) {
                await EzConfig.removeKeys(extraLight!.toSet());
              }
            }
          },
        ),
      ]);
}
