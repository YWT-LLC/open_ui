/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

class EzBigButtonsConfig extends StatelessWidget {
  final EzProvider config;

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

  static Future<void> onPressed(EzProvider config, bool updateBoth) async {
    // Don't reset //

    if (updateBoth || config.isDark) {
      // Design settings //

      await EzManager.setDouble(darkMarginKey, 12.0);
      if (EzManager.onMobile) {
        await EzManager.setDouble(darkPaddingKey, 21.0);
        await EzManager.setDouble(darkSpacingKey, 30.0);
      } else {
        await EzManager.setDouble(darkPaddingKey, 24.0);
        await EzManager.setDouble(darkSpacingKey, 36.0);
      }

      await EzManager.setBool(darkShowBackFABKey, true);

      await EzManager.setString(darkButtonShapeKey, EzButtonShape.roundRect.value);

      await EzManager.setBool(darkShowScrollKey, true);

      // Text settings //

      if (config.iconSize < 25.0) {
        await EzManager.setDouble(darkIconSizeKey, 25.0);
      }
    }

    if (updateBoth || !config.isDark) {
      // Design settings //

      await EzManager.setDouble(lightMarginKey, 12.0);
      if (EzManager.onMobile) {
        await EzManager.setDouble(lightPaddingKey, 21.0);
        await EzManager.setDouble(lightSpacingKey, 30.0);
      } else {
        await EzManager.setDouble(lightPaddingKey, 24.0);
        await EzManager.setDouble(lightSpacingKey, 36.0);
      }

      await EzManager.setBool(lightShowBackFABKey, true);

      await EzManager.setString(lightButtonShapeKey, EzButtonShape.roundRect.value);

      await EzManager.setBool(lightShowScrollKey, true);

      // Text settings //

      if (config.iconSize < 25.0) {
        await EzManager.setDouble(lightIconSizeKey, 25.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) => EzElevatedButton(
        config,
        style: ElevatedButton.styleFrom(
          backgroundBuilder: ezSelfBuilder,
          padding: EdgeInsets.all(EzManager.onMobile ? 22.5 : 25.0),
          shape: EzButtonShape.roundRect.shape,
        ),
        onPressed: () => config.rebuildUI(changes: () async {
          await onPressed(config, updateBoth);
          await extra?.call(updateBoth);
        }),
        text: config.ezL10n.ssBigButtons,
      );
}
