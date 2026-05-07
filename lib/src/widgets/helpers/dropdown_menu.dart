/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzDropdownMenu<T> extends StatelessWidget {
  /// [DropdownMenu.enabled] passthrough
  final bool enabled;

  /// [ezDropdownWidth] passthrough
  final String widthEntry;

  /// [DropdownMenu.leadingIcon] passthrough
  final Widget? leadingIcon;

  /// [DropdownMenu.trailingIcon] passthrough
  final Widget? trailingIcon;

  /// [DropdownMenu.label] passthrough
  final Widget? label;

  /// [DropdownMenu.hintText] passthrough
  final String? hintText;

  /// [DropdownMenu.selectedTrailingIcon] passthrough
  final Widget? selectedTrailingIcon;

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
  const EzDropdownMenu({
    super.key,
    this.enabled = true,
    this.leadingIcon,
    this.trailingIcon,
    this.label,
    this.hintText,
    this.selectedTrailingIcon,
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
        data: IconButtonThemeData(
          style: IconButton.styleFrom(
            backgroundColor: EzConfig.colors.surface,
            foregroundColor: EzConfig.colors.primary,
            disabledForegroundColor: EzConfig.colors.outline,
            overlayColor: EzConfig.colors.primary,
            side: null,
            shape: EzConfig.buttonShape.shape,
            iconSize: EzConfig.iconSize,
            alignment: Alignment.center,
            padding: EzInsets.wrap(EzConfig.padding),
          ),
        ),
        child: DropdownMenu<T>(
          enabled: enabled,
          width: ezDropdownWidth(context, widthEntry),
          leadingIcon: leadingIcon,
          trailingIcon: trailingIcon ??
              Icon(
                Icons.arrow_drop_down,
                size: EzConfig.iconSize,
              ),
          label: label,
          hintText: hintText,
          selectedTrailingIcon: selectedTrailingIcon ??
              Icon(
                Icons.arrow_drop_up,
                size: EzConfig.iconSize,
              ),
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
