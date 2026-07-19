/* empathetech_flutter_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzBigButtonsConfig extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Whether both themes should be updated
  final bool updateBoth;

  /// Optional extra changes
  final Future<void> Function(bool)? extra;

  /// Doesn't replace, only modifies: larger touch points from default
  /// Slight bump to all layout values, for easier tapping
  const EzBigButtonsConfig(
    this.config, {
    super.key,
    required this.updateBoth,
    this.extra,
  });

  static Future<void> onPressed(EzCP config, bool updateBoth) async {
    // Don't reset //

    if (updateBoth || config.isDark) {
      // Design settings //

      await EzCM.setDouble(darkMarginKey, 12.0);
      if (EzCM.onMobile) {
        await EzCM.setDouble(darkPaddingKey, 21.0);
        await EzCM.setDouble(darkSpacingKey, 30.0);
      } else {
        await EzCM.setDouble(darkPaddingKey, 24.0);
        await EzCM.setDouble(darkSpacingKey, 36.0);
      }

      await EzCM.setBool(darkShowBackFABKey, true);

      await EzCM.setString(darkButtonShapeKey, EzButtonShape.roundRect.value);

      await EzCM.setBool(darkShowScrollKey, true);

      // Text settings //

      if (config.iconSize < 25.0) {
        await EzCM.setDouble(darkIconSizeKey, 25.0);
      }
    }

    if (updateBoth || !config.isDark) {
      // Design settings //

      await EzCM.setDouble(lightMarginKey, 12.0);
      if (EzCM.onMobile) {
        await EzCM.setDouble(lightPaddingKey, 21.0);
        await EzCM.setDouble(lightSpacingKey, 30.0);
      } else {
        await EzCM.setDouble(lightPaddingKey, 24.0);
        await EzCM.setDouble(lightSpacingKey, 36.0);
      }

      await EzCM.setBool(lightShowBackFABKey, true);

      await EzCM.setString(lightButtonShapeKey, EzButtonShape.roundRect.value);

      await EzCM.setBool(lightShowScrollKey, true);

      // Text settings //

      if (config.iconSize < 25.0) {
        await EzCM.setDouble(lightIconSizeKey, 25.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) => EzElevatedButton(
        config,
        style: ElevatedButton.styleFrom(
          shape: EzButtonShape.roundRect.shape,
          padding: EdgeInsets.all(EzCM.onMobile ? 22.5 : 25.0),
        ),
        onPressed: () => config.rebuildUI(allECT, changes: () async {
          await onPressed(config, updateBoth);
          await extra?.call(updateBoth);
        }),
        text: config.ezL10n.ssBigButtons,
      );
}
