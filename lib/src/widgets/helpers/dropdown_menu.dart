/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

class EzDropdownMenu<T> extends StatelessWidget {
  final EzCP config;
  final bool reverseHands;
  final bool showScrollHint;

  /// Will be used in an [EzText] widget
  final String? label;

  /// Defaults to [EzCP.labelStyle]
  final TextStyle? labelStyle;

  /// Defaults to [TextAlign.center]
  final TextAlign labelAlign;

  final bool enabled;
  final String widthEntry;
  final bool enableSearch;
  final TextInputType? keyboardType;

  /// Defaults to [EzCP.bodyStyle]
  final TextStyle? menuStyle;

  /// Defaults to [TextAlign.start]
  final TextAlign menuAlign;

  final T? initialSelection;
  final ValueChanged<T?>? onSelected;
  final List<EzDropMenuEntry<T>> dropdownMenuEntries;

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
              dropdownMenuEntries: dropdownMenuEntries,
              enabled: enabled,
              enableSearch: enableSearch,
              initialSelection: initialSelection,
              keyboardType: keyboardType,
              onSelected: onSelected,
              selectedTrailingIcon: EzIcon(config, Icons.arrow_drop_up),
              textStyle: (menuStyle ?? config.bodyStyle),
              textAlign: menuAlign,
              trailingIcon: EzIcon(config, Icons.arrow_drop_down),
              width: ezDropdownWidth(config, context: context, entry: widthEntry),
            ),
          ),
        ],
      );
}

class EzDropMenuEntry<T> extends DropdownMenuEntry<T> {
  /// [EzDropMenuEntry] wrapper that supports [Gradient]s via [EzSwitchColor]
  EzDropMenuEntry(
    EzCP config, {
    required super.value,
    required super.label,
    super.labelWidget,
    super.leadingIcon,
    super.trailingIcon,
    super.enabled,
    EzSwitchColor? fill,
    TextStyle? textStyle,
  }) : super(
          style: MenuItemButton.styleFrom(
            backgroundColor: (fill ?? config.surfaceFill).color,
            textStyle: textStyle,
          ).copyWith(
            backgroundBuilder: config.smartLayer(
              fill: fill ?? config.surfaceFill,
              borderRadius: config.buttonShape.textRadius,
            ),
          ),
        );
}
