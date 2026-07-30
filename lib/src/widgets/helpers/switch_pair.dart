/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzSwitchPair extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

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

  /// [EzText.text] passthrough
  final String text;

  /// [Text.semanticsLabel] passthrough
  final String? textFix;

  /// [EzText.textAlign] passthrough
  final TextAlign? textAlign;

  /// If provided, an [EzToolTipper] will appear next to the [Switch]
  final String? tipper;

  /// If provided, an [EzToolTipper] will appear next to the [Switch]
  final InlineSpan? bigTipper;

  /// [Switch.value] passthrough
  /// Provide [value] OR [valueKey]
  /// Must pair with [onChanged]
  final bool? value;

  /// Optional pre-requisite to [onChanged]
  /// Only for when using [valueKey]
  final Future<bool> Function(bool)? canChange;

  /// [EzCM] key to provide to [Switch.value]
  /// And update in [Switch.onChanged]
  /// Provide [valueKey] OR [value]
  /// Optionally provide [afterChanged]
  final String? valueKey;

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
  const EzSwitchPair(
    this.config, {
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
    this.textFix,
    this.textAlign,

    // Tool tip(per)
    this.tipper,
    this.bigTipper,

    // Switch
    this.value,
    this.valueKey,
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
          'Cannot use afterChanged with value',
        );

  @override
  State<EzSwitchPair> createState() => _EzSwitchPairState();
}

class _EzSwitchPairState extends State<EzSwitchPair> {
  // Define the build data //

  late bool value = widget.value ?? false;

  // Define custom functions //

  Future<void> onChanged(bool? choice) async {
    if (!widget.enabled) return;
    if (widget.onChanged != null) return widget.onChanged!.call(choice);

    if (choice == null) return;
    if (widget.canChange != null) {
      if (!(await widget.canChange!(choice))) return;
    }

    await EzCM.setBool(widget.valueKey!, choice);
    setState(() => value = choice);

    widget.afterChanged?.call(choice);
  }

  // Init //

  @override
  void initState() {
    super.initState();
    if (widget.value == null) setState(() => value = EzCM.get(widget.valueKey!));
  }

  // Return the build //

  TextButton core() => TextButton.icon(
        style: (widget.enabled && !widget.fauxDisabled)
            ? TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: widget.config.marginVal),
                backgroundColor: widget.config.colors.surface,
                side: widget.config.borderSide(
                    color: widget.config.colors.primary.withValues(alpha: focusOpacity)),
              )
            : TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: widget.config.marginVal),
                backgroundColor: widget.config.colors.surface,
                side: widget.config.borderSide(color: widget.config.colors.outlineVariant),
                overlayColor: widget.config.colors.outline,
                shadowColor: Colors.transparent,
              ),
        onPressed: () => widget.enabled ? onChanged(!value) : doNothing(),
        label: Text(
          widget.text,
          textAlign: widget.textAlign,
          semanticsLabel: widget.textFix,
          style: widget.config.bodyStyle?.copyWith(
            decorationColor: widget.config.colors.primary,
            decoration: widget.config.lineLinks ? TextDecoration.underline : null,
          ),
        ),
        icon: Transform.scale(
          scale: max(1.0, ezIconRatio(widget.config)),
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: widget.fauxDisabled ? widget.config.colors.outline : null,
            inactiveThumbColor: widget.config.colors.outline,
            trackOutlineColor: (!widget.enabled || widget.fauxDisabled)
                ? WidgetStatePropertyAll<Color>(widget.config.colors.outlineVariant)
                : null,
            trackOutlineWidth: widget.trackOutlineWidth,
            padding: EdgeInsets.zero,
          ),
        ),
        iconAlignment: widget.config.isLefty ? IconAlignment.start : IconAlignment.end,
      );

  @override
  Widget build(BuildContext context) => (widget.tipper != null || widget.bigTipper != null)
      ? EzScrollView(
          widget.config,
          showScrollHint: true,
          scrollDirection: Axis.horizontal,
          reverseHands: widget.reverseHands,
          mainAxisSize: widget.mainAxisSize,
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: <Widget>[
            core(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.config.marginVal),
              child: EzToolTipper(
                widget.config,
                message: widget.tipper,
                richMessage: widget.bigTipper,
              ),
            ),
          ],
        )
      : core();
}

// TODO: think and/or test through lefty && LTR

class EzFlipFlop extends StatefulWidget {
  /// EzConfig provider
  final EzCP config;

  /// Initial state
  final bool init;

  /// aka true label
  final String onLabel;

  /// aka false label
  final String offLabel;

  /// Follow up function
  final void Function(bool choice) onChanged;

  /// Defaults to [MainAxisAlignment.center]
  final MainAxisAlignment mainAxisAlignment;

  /// Defaults to [config].bodyStyle
  final TextStyle? style;

  const EzFlipFlop(
    this.config, {
    super.key,
    required this.init,
    required this.onLabel,
    required this.offLabel,
    required this.onChanged,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.style,
  });

  @override
  State<EzFlipFlop> createState() => _EzFlipFlopState();
}

class _EzFlipFlopState extends State<EzFlipFlop> {
  late bool curr = widget.init;

  @override
  Widget build(BuildContext context) => EzRow(
        widget.config,
        mainAxisAlignment: widget.mainAxisAlignment,
        children: <Widget>[
          // Off/false
          EzTextButton(
            widget.config,
            text: widget.offLabel,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerRight,
              backgroundColor: widget.config.colors.surfaceContainer,
            ),
            textAlign: TextAlign.end,
            textStyle: widget.style ?? widget.config.bodyStyle,
            onPressed: () {
              setState(() => curr = false);
              widget.onChanged(false);
            },
          ),
          widget.config.rowSpacer,

          // Svvitch
          Switch(
            value: curr,
            onChanged: (bool choice) {
              setState(() => curr = choice);
              widget.onChanged(choice);
            },
            thumbColor: WidgetStatePropertyAll<Color>(widget.config.colors.primary),
            trackColor: WidgetStatePropertyAll<Color>(widget.config.colors.surface),
            trackOutlineColor: WidgetStatePropertyAll<Color>(
                widget.config.colors.primary.withValues(alpha: focusOpacity)),
            padding: EdgeInsets.zero,
          ),
          widget.config.rowSpacer,

          // On/true
          EzTextButton(
            widget.config,
            text: widget.onLabel,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              backgroundColor: widget.config.colors.surfaceContainer,
            ),
            textAlign: TextAlign.start,
            textStyle: widget.style ?? widget.config.bodyStyle,
            onPressed: () {
              setState(() => curr = true);
              widget.onChanged(true);
            },
          ),
        ],
      );
}
