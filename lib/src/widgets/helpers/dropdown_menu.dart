/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzDropdownMenu<T> extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [EzScrollView.reverseHands] passthrough
  final bool reverseHands;

  /// [EzScrollView.showScrollHint] passthrough
  final bool showScrollHint;

  /// Will be used in an [EzText] widget
  final String? label;

  /// Defaults to [EzCP.labelStyle]
  final TextStyle? labelStyle;

  /// Defaults to [TextAlign.center]
  final TextAlign labelAlign;

  /// [DropdownMenu.enabled] passthrough
  final bool enabled;

  /// [ezDropdownWidth] passthrough
  final String widthEntry;

  /// [DropdownMenu.enableSearch] passthrough
  final bool enableSearch;

  /// [DropdownMenu.keyboardType] passthrough
  final TextInputType? keyboardType;

  /// Defaults to [EzCP.bodyStyle]
  final TextStyle? menuStyle;

  /// Defaults to [TextAlign.start]
  final TextAlign menuAlign;

  /// [DropdownMenu.initialSelection] passthrough
  final T? initialSelection;

  /// [DropdownMenu.onSelected] passthrough
  final ValueChanged<T?>? onSelected;

  /// [DropdownMenu.dropdownMenuEntries] passthrough
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  /// [DropdownMenu] with custom styling
  const EzDropdownMenu(
    this.config, {
    super.key,

    // ScrollView
    this.reverseHands = true,
    this.showScrollHint = true,

    // Label
    required this.label,
    this.labelStyle,
    this.labelAlign = TextAlign.center,

    // Menu
    this.enabled = true,
    this.enableSearch = true,
    this.keyboardType,
    this.menuStyle,
    this.menuAlign = TextAlign.start,
    this.initialSelection,
    this.onSelected,
    required this.dropdownMenuEntries,
    required this.widthEntry,
  });

  @override
  Widget build(BuildContext context) => EzScrollView(
        config,
        thumbVisibility: false,
        reverseHands: reverseHands,
        showScrollHint: showScrollHint,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          if (label != null) ...<Widget>[
            // Label
            EzText(
              config,
              text: label!,
              style: (labelStyle ?? config.labelStyle),
              textAlign: labelAlign,
            ),
            config.rowMargin,
          ],

          // Menu
          IconButtonTheme(
            data: IconButtonThemeData(style: IconButton.styleFrom(side: (BorderSide.none))),
            child: DropdownMenu<T>(
              enabled: enabled,
              width: ezDropdownWidth(config, context: context, entry: widthEntry),
              trailingIcon: EzIcon(config, Icons.arrow_drop_down),
              selectedTrailingIcon: EzIcon(config, Icons.arrow_drop_up),
              enableSearch: enableSearch,
              keyboardType: keyboardType,
              textStyle: (menuStyle ?? config.bodyStyle),
              textAlign: menuAlign,
              initialSelection: initialSelection,
              onSelected: onSelected,
              dropdownMenuEntries: dropdownMenuEntries,
            ),
          ),
        ],
      );
}
