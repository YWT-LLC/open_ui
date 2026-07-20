/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EzColorSetting extends StatefulWidget {
  /// EzConfig provider
  final EzCP config;

  /// [config] key whose [Color] will be updated
  final String configKey;

  /// Creates a tool for [configKey] ColorScheme values via [config]
  /// When [configKey] is a text color (has [textColorPrefix]), the base color will be used to generate a recommendation via [getTextColor]
  /// [EzColorSetting] inherits styling from the [ElevatedButton] and [AlertDialog] values in your [ThemeData]
  const EzColorSetting(this.config, {super.key, required this.configKey});

  @override
  State<EzColorSetting> createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  // Define the build data //

  late Color currColor = (EzCM.get(widget.configKey) == null)
      ? getLiveColor(widget.config.colors, widget.configKey)
      : Color(EzCM.get(widget.configKey));

  // Define custom functions //

  /// Opens an [ezColorPicker] for updating [currColor]
  /// Returns the [Color] of what was chosen (null otherwise)
  Future<void> openColorPicker() {
    final Color backup = currColor;

    return ezColorPicker(
      widget.config,
      context: context,
      startColor: backup,
      onColorChange: (Color chosenColor) => setState(() => currColor = chosenColor),
      onConfirm: () async {
        await EzCM.setInt(widget.configKey, currColor.toARGB32());
        await widget.config.rebuildUI(<EzCacheType>{EzCacheType.color, EzCacheType.design});
      },
      onDeny: () => setState(() => currColor = backup),
    );
  }

  /// Opens an [EzAlertDialog] for users to chose how they want to update the color
  /// Returns the [Color] of what was chosen (null if none)
  Future<dynamic> changeColor() {
    if (!widget.configKey.contains(textColorPrefix)) {
      // Base color //
      // Just open a color picker

      return openColorPicker();
    }
    // 'on' (aka text) color //

    // Get its background pair
    final String backgroundKey = widget.configKey.replaceAll(textColorPrefix, '');

    // Find the recommended contrast color for the background
    final int? backgroundColorValue = EzCM.get(backgroundKey);
    final Color backgroundColor = (backgroundColorValue == null)
        ? getLiveColor(widget.config.colors, backgroundKey)
        : Color(backgroundColorValue);

    final int recommended = getTextColor(backgroundColor).toARGB32();

    // Just open a color picker if the value is already what's recommended
    if (recommended == currColor.toARGB32()) return openColorPicker();

    // Otherwise, let the user choose...
    // Recommended, custom, or cancel (close)
    return showDialog(
      context: context,
      builder: (BuildContext dCon) => EzAlertDialog(
        widget.config,
        title: Text(widget.config.ezL10n.csRecommended, textAlign: TextAlign.center),
        // Recommended color preview
        contents: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: backgroundColor, width: widget.config.borderWidth),
            ),
            child: CircleAvatar(
              backgroundColor: Color(recommended),
              radius: (widget.config.iconSize / 2) + widget.config.padding,
            ),
          ),
        ],
        actions: <EzAction>[
          EzAction(
            widget.config,
            text: widget.config.ezL10n.gYes,
            onPressed: () async {
              // Update the user's configKey
              await EzCM.setInt(widget.configKey, recommended);
              setState(() => currColor = Color(recommended));
              await widget.config.rebuildUI(<EzCacheType>{EzCacheType.color, EzCacheType.design});
            },
            isDefaultAction: true,
          ),
          EzAction(
            widget.config,
            text: widget.config.ezL10n.csUseCustom,
            onPressed: () async {
              await openColorPicker();
              if (dCon.mounted) Navigator.of(dCon).pop();
            },
            isDestructiveAction: true,
          ),
        ],
      ),
    );
  }

  /// Opens an [EzAlertDialog] for resetting [configKey] to default
  /// If there is no default value, the key will simply be removed from [EzCP]
  /// If a value is found, a preview of the reset color is shown and the user can confirm/deny
  Future<dynamic> reset() => showDialog(
    context: context,
    builder: (BuildContext dCon) {
      final int? resetValue = EzCM.getDefault(widget.configKey);
      final String currColorLabel = currColor.toARGB32().toRadixString(16).toUpperCase();

      return EzAlertDialog(
        widget.config,
        title: Text(
          widget.config.ezL10n.gResetValue(
            getColorName(widget.config.ezL10n, widget.configKey).toLowerCase(),
          ),
          textAlign: TextAlign.center,
        ),
        contents: <Widget>[
          // Label
          Text(widget.config.ezL10n.csCurrVal, textAlign: TextAlign.center),
          widget.config.margin,

          // Copy-able value
          EzTextIconButton(
            widget.config,
            onPressed: () => Clipboard.setData(ClipboardData(text: currColorLabel)),
            icon: EzIcon(widget.config, Icons.copy),
            label: currColorLabel,
          ),
        ],
        actions: ezActionPair(
          widget.config,
          onConfirm: () async {
            // Remove the user's configKey and reset the current state
            await EzCM.remove(widget.configKey);
            if (resetValue != null) {
              setState(() => currColor = Color(resetValue));
            }
            await widget.config.rebuildUI(<EzCacheType>{EzCacheType.color, EzCacheType.design});
          },
          confirmIsDestructive: true,
          onDeny: () => Navigator.of(dCon).pop(),
        ),
        needsClose: false,
      );
    },
  );

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final double iconRadius = widget.config.iconSize / 2;
    final String label = getColorName(widget.config.ezL10n, widget.configKey);

    return Semantics(
      label: label,
      button: true,
      hint: widget.config.ezL10n.csPickerHint,
      child: ExcludeSemantics(
        child: EzElevatedIconButton(
          widget.config,
          onPressed: changeColor,
          onLongPress: reset,
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.config.colors.primaryContainer,
                width: widget.config.borderWidth,
              ),
            ),
            child: currColor == Colors.transparent
                ? CircleAvatar(
                    backgroundColor: widget.config.colors.surface,
                    foregroundColor: widget.config.colors.onSurface,
                    radius: iconRadius + widget.config.padding,
                    child: EzIcon(widget.config, Icons.visibility_off),
                  )
                : CircleAvatar(
                    backgroundColor: currColor,
                    radius: iconRadius + widget.config.padding,
                  ),
          ),
          label: label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
