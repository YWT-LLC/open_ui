/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EzSwitchPair extends StatefulWidget {
  /// Easily disable the button
  /// Useful if the functionality is async
  final bool enabled;

  /// Switches to disabled styling when true
  /// The switch is unchanged
  final bool fauxDisabled;

  /// [EzRow.reverseHands] passthrough
  final bool reverseHands;

  /// [EzRow.mainAxisSize] passthrough
  final MainAxisSize mainAxisSize;

  /// [EzRow.mainAxisAlignment] passthrough
  final MainAxisAlignment mainAxisAlignment;

  /// [EzRow.crossAxisAlignment] passthrough
  final CrossAxisAlignment crossAxisAlignment;

  /// [EzText.data] passthrough
  final String text;

  /// When true, the [text] will be a clickable link (toggles the switch)
  final bool clickable;

  /// [EzText.textAlign] passthrough
  final TextAlign? textAlign;

  /// [EzText.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [Switch.value] passthrough
  /// Provide [value] OR [valueKey]
  /// Must pair with [onChanged]
  final bool? value;

  /// Optional pre-requisite to [onChanged]
  /// Only for when using [valueKey]
  final Future<bool> Function(bool)? canChange;

  /// [EzConfig] key to provide to [Switch.value]
  /// And update in [Switch.onChanged]
  /// Provide [valueKey] OR [value]
  /// Optionally provide [afterChanged]
  final String? valueKey;

  /// Whether the key should use [FlutterSecureStorage]
  final bool secureKey;

  /// [Switch.onChanged] passthrough
  /// Provide [onChanged] OR [afterChanged]
  /// Pairs with [value]
  final void Function(bool?)? onChanged;

  /// If you want to do more than just update [valueKey] in [Switch.onChanged]
  /// Provide [afterChanged] OR [onChanged]
  /// Pairs with [valueKey]
  final void Function(bool?)? afterChanged;

  /// [Switch.trackOutlineWidth] passthrough
  final WidgetStateProperty<double?>? trackOutlineWidth;

  /// [EzRow] with flexible [EzText] and a [Switch]
  /// Provide the traditional [value] and [onChanged]
  /// Or and EzConfig optimized [valueKey] and optional [afterChanged]
  const EzSwitchPair({
    super.key,
    this.enabled = true,
    this.fauxDisabled = false,

    // Row
    this.reverseHands = true,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,

    // Text
    required this.text,
    this.clickable = false,
    this.textAlign,
    this.semanticsLabel,

    // Switch
    this.value,
    this.valueKey,
    this.secureKey = false,
    this.onChanged,
    this.canChange,
    this.afterChanged,
    this.trackOutlineWidth,
  })  : assert((value == null) != (valueKey == null), 'Provide value OR valueKey, but not both'),
        assert((value == null) == (onChanged == null), 'Must pair value and onChanged'),
        assert((valueKey == null) != (onChanged == null), 'Cannot use onChanged with valueKey'),
        assert(
            ((afterChanged == null) && (value == null) ||
                ((afterChanged == null) != (value == null))),
            'Cannot use afterChanged with value');

  @override
  State<EzSwitchPair> createState() => _EzSwitchPairState();
}

class _EzSwitchPairState extends State<EzSwitchPair> {
  // Define the build data //

  late bool value = widget.value ?? false;

  // Define custom functions //

  void onChanged(bool? choice) async {
    if (!widget.enabled) return;
    if (widget.onChanged != null) return widget.onChanged!.call(choice);
    if (choice == null) return;

    if (widget.canChange != null) {
      if (!await widget.canChange!(choice)) return;
    }

    if (widget.secureKey) {
      await EzConfig.secSet(widget.valueKey!, choice.toString());
    } else {
      await EzConfig.setBool(widget.valueKey!, choice);
    }
    setState(() => value = choice);

    widget.afterChanged?.call(choice);
  }

  // Init //

  void setValue() async {
    final bool newVal = widget.secureKey
        ? int.tryParse(await EzConfig.secGet(widget.valueKey!)) ?? false
        : EzConfig.get(widget.valueKey!);

    if (newVal != value) setState(() => value = newVal);
  }

  @override
  void initState() {
    super.initState();
    if (widget.value == null) setValue();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => EzRow(
        reverseHands: widget.reverseHands,
        mainAxisSize: widget.mainAxisSize,
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        children: <Widget>[
          Flexible(
            child: widget.clickable
                ? EzLink(
                    widget.text,
                    textColor: EzConfig.colors.onSurface,
                    style: EzConfig.styles.bodyLarge,
                    textAlign: widget.textAlign,
                    hint: widget.semanticsLabel ?? EzConfig.l10n.gSwitchHint,
                    onTap: () => onChanged(!value),
                  )
                : EzText(
                    widget.text,
                    style: EzConfig.styles.bodyLarge,
                    textAlign: widget.textAlign,
                    semanticsLabel: widget.semanticsLabel,
                  ),
          ),
          Transform.scale(
            scale: max(1.0, ezIconRatio()),
            // Could be PlatformSwitch
            // Dev's opinion: Material switches are better
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: widget.fauxDisabled ? EzConfig.colors.outline : null,
              inactiveThumbColor: EzConfig.colors.outline,
              trackOutlineColor: (!widget.enabled || widget.fauxDisabled)
                  ? WidgetStatePropertyAll<Color>(EzConfig.colors.outlineVariant)
                  : null,
              trackOutlineWidth: widget.trackOutlineWidth,
              padding: EzConfig.isLefty
                  ? EdgeInsets.only(right: EzConfig.marginVal)
                  : EdgeInsets.only(left: EzConfig.marginVal),
            ),
          ),
        ],
      );
}
