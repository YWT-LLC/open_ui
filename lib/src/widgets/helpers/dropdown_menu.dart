/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzDropdownMenu<T> extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [DropdownMenu.enabled] passthrough
  final bool enabled;

  /// [ezDropdownWidth] passthrough
  final String widthEntry;

  /// [DropdownMenu.label] passthrough
  final Widget? label;

  /// [DropdownMenu.hintText] passthrough
  final String? hintText;

  /// [DropdownMenu.enableFilter] passthrough
  final bool enableFilter;

  /// [DropdownMenu.enableSearch] passthrough
  final bool enableSearch;

  /// [DropdownMenu.keyboardType] passthrough
  final TextInputType? keyboardType;

  /// [DropdownMenu.textStyle] passthrough
  final TextStyle? textStyle;

  /// [DropdownMenu.textAlign] passthrough
  final TextAlign textAlign;

  /// [DropdownMenu.controller] passthrough
  final TextEditingController? controller;

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
    this.enabled = true,
    this.label,
    this.hintText,
    this.enableFilter = false,
    this.enableSearch = true,
    this.keyboardType,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.controller,
    this.initialSelection,
    this.onSelected,
    required this.dropdownMenuEntries,
    required this.widthEntry,
  });

  @override
  Widget build(BuildContext context) => IconButtonTheme(
    data: IconButtonThemeData(style: IconButton.styleFrom(side: (BorderSide.none))),
    child: DropdownMenu<T>(
      enabled: enabled,
      width: ezDropdownWidth(config, context: context, entry: widthEntry),
      trailingIcon: EzIcon(config, Icons.arrow_drop_down),
      label: label,
      hintText: hintText,
      selectedTrailingIcon: EzIcon(config, Icons.arrow_drop_up),
      enableFilter: enableFilter,
      enableSearch: enableSearch,
      keyboardType: keyboardType,
      textStyle: textStyle,
      textAlign: textAlign,
      controller: controller,
      initialSelection: initialSelection,
      onSelected: onSelected,
      dropdownMenuEntries: dropdownMenuEntries,
    ),
  );
}
