/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

// TODO: gradient dots in horizontal reorderable scroll
// on tap still removes, add an undo pop-up

class EzColorSetting extends StatefulWidget {
  final EzCP config;

  /// [config] key whose [Color] will be updated
  final String configKey;

  const EzColorSetting(
    this.config, {
    super.key,
    required this.configKey,
  });

  @override
  State<EzColorSetting> createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  // Define the build data //

  late String currValue;
  late EzSwitchColor currPreview;

  // Define custom functions //

  Future<void> pickAColor({bool allowGradient = true}) async {
    final String? picked = await ezColorPicker(
      widget.config,
      context: context,
      picking: currValue,
      allowGradient: allowGradient,
    );

    if (picked != null) {
      await EzCM.setString(widget.configKey, picked);

      if (ezTextMirrors.containsKey(widget.configKey)) {
        await EzCM.setString(
          ezTextMirrors[widget.configKey]!,
          ezTextColor(ezFirstColor(picked)!).toARGB32().toString(),
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
      return pickAColor(allowGradient: !noGradientKeys.contains(widget.configKey));
    }
    // 'on' (aka text) color...
    // Get its background pair
    final String backgroundKey = widget.configKey.replaceAll(textColorPrefix, '');

    // Find the recommended contrast color for the background
    final String? backgroundColorValue = EzCM.get(backgroundKey);
    final Color backgroundColor = (backgroundColorValue == null)
        ? getLiveColor(widget.config.theme.colorScheme, backgroundKey)
        : ezFirstColor(backgroundColorValue) ??
            (widget.config.isDark ? Colors.black : Colors.white);

    final int recommended = ezTextColor(backgroundColor).toARGB32();

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
              border: Border.all(color: backgroundColor, width: widget.config.borderWidth),
              shape: BoxShape.circle,
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
              await pickAColor(allowGradient: false);
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
          final String currColorLabel =
              currPreview.asColor.toARGB32().toRadixString(16).toUpperCase();

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

  EzSwitchColor _buildPreview(String value) => value.contains(colorSplit)
      ? EzSwitchColor(gradient: ezLGFromString(value))
      : EzSwitchColor(color: Color(int.parse(value)));

  void updatePreview(String value) => setState(() => currPreview = _buildPreview(value));

  // Init //

  @override
  void initState() {
    super.initState();

    final dynamic stored = EzCM.get(widget.configKey);

    if (stored == null) {
      final Color liveColor = getLiveColor(widget.config.theme.colorScheme, widget.configKey);
      currValue = liveColor.toARGB32().toString();
      currPreview = EzSwitchColor(color: liveColor);
    } else {
      currValue = stored.toString();
      currPreview = _buildPreview(currValue);
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
            decoration: widget.config.boxDecoration(
              shape: BoxShape.circle,
              fill: widget.config.primaryContainerFill,
            ),
            child: currValue == ywt.transparentString
                ? EzAvatar(
                    widget.config,
                    fill: widget.config.surfaceFill,
                    foregroundColor: widget.config.onSurface,
                    radius: iconRadius + widget.config.padding,
                    child: EzIcon(widget.config, Icons.visibility_off),
                  )
                : EzAvatar(
                    widget.config,
                    fill: currPreview,
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
