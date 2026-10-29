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

  const EzColorSetting(this.config, {super.key, required this.configKey});

  @override
  State<EzColorSetting> createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  // Define the build data //

  late String currValue;
  late dynamic currPreview;

  // Define custom functions //

  Future<void> pickAColor({bool allowGradient = true}) async {
    final String? picked = await ezColorPicker(
      widget.config,
      context: context,
      picking: currValue,
      allowGradient: allowGradient,
      onColorChange: (Color chosenColor) => setState(() => currPreview = chosenColor),
    );

    if (picked != null) {
      await EzCM.setString(widget.configKey, picked);

      if (ezTextMirrors.containsKey(widget.configKey)) {
        await EzCM.setString(
          ezTextMirrors[widget.configKey]!,
          getTextColor(
                  picked.contains(colorSplit) ? ezFirstColor(picked) : Color(int.parse(picked)))
              .toARGB32()
              .toString(),
        );
      }

      currValue = picked;
      updatePreview(picked);

      await widget.config.rebuildUI();
    }
  }

  Future<dynamic> changeColor() {
    if (!widget.configKey.contains(textColorPrefix)) {
      // Base color ...
      // Just open a color picker
      return pickAColor();
    }
    // 'on' (aka text) color...
    // Get its background pair
    final String backgroundKey = widget.configKey.replaceAll(textColorPrefix, '');

    // Find the recommended contrast color for the background
    final String? backgroundColorValue = EzCM.get(backgroundKey);
    final Color backgroundColor = (backgroundColorValue == null)
        ? getLiveColor(widget.config.colors, backgroundKey)
        : backgroundColorValue.contains(colorSplit)
            ? ezFirstColor(backgroundColorValue)
            : Color(int.parse(backgroundColorValue));

    final int recommended = getTextColor(backgroundColor).toARGB32();

    // Just open a color picker if the value is already what's recommended
    if (recommended == int.tryParse(currValue)) return pickAColor(allowGradient: false);

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
              await EzCM.setString(widget.configKey, recommended.toString());

              currValue = recommended.toString();
              updatePreview(recommended.toString());

              await widget.config.rebuildUI();
            },
            isDefaultAction: true,
          ),
          EzAction(
            widget.config,
            text: widget.config.ezL10n.csUseCustom,
            onPressed: () async {
              await pickAColor();
              if (dCon.mounted) Navigator.of(dCon).pop();
            },
            isDestructiveAction: true,
          ),
        ],
      ),
    );
  }

  Future<dynamic> reset() => showDialog(
        context: context,
        builder: (BuildContext dCon) {
          final int? resetValue = EzCM.getDefault(widget.configKey);
          final String currColorLabel = (currValue.contains(colorSplit)
                  ? (currPreview as LinearGradient).colors.first
                  : currPreview as Color)
              .toARGB32()
              .toRadixString(16)
              .toUpperCase();

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
                  currValue = resetValue.toString();
                  updatePreview(resetValue.toString());
                }
                await widget.config.rebuildUI();
              },
              confirmIsDestructive: true,
              onDeny: () => Navigator.of(dCon).pop(),
            ),
            needsClose: false,
          );
        },
      );

  void updatePreview(String value) => setState(() => currPreview = ezGradientFromString(value));

  // Init //

  @override
  void initState() {
    super.initState();

    final String? stored = EzCM.get(widget.configKey);

    if (stored == null) {
      final Color liveColor = getLiveColor(widget.config.colors, widget.configKey);
      currValue = liveColor.toARGB32().toString();
      currPreview = liveColor;
    } else if (stored.contains(colorSplit)) {
      currValue = stored;
      currPreview = ezGradientFromString(currValue);
    } else {
      currValue = stored;
      currPreview = Color(int.parse(currValue));
    }

    setState(() {});
  }

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
            child: currValue == transparentString
                ? CircleAvatar(
                    backgroundColor: widget.config.colors.surface,
                    foregroundColor: widget.config.colors.onSurface,
                    radius: iconRadius + widget.config.padding,
                    child: EzIcon(widget.config, Icons.visibility_off),
                  )
                : (currPreview is Color)
                    ? CircleAvatar(
                        backgroundColor: currPreview,
                        radius: iconRadius + widget.config.padding,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          gradient: currPreview,
                          shape: BoxShape.circle,
                        ),
                        height: (iconRadius + widget.config.padding) * 2,
                        width: (iconRadius + widget.config.padding) * 2,
                      ),
          ),
          label: label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
