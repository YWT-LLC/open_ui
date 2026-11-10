/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'dart:math';
import 'package:material_ui/material_ui.dart';

// TODO: some of my icons are the wrong color - just eziconbutton?

/// Creates a [ThemeData] from [EzCM] values
ThemeData ezThemeData(
  Brightness brightness, {
  required bool ltr,
  required ColorScheme basicColors,
  required EzColorCache colors,
  required EzDesignCache design,
  required EzLayoutCache layout,
  required EzTextCache text,
}) {
  //* Setup *//

  // Color //

  final Color focusColor = colors.primary.asColor.withValues(alpha: focusOpacity);

  // Design (button) //

  const WidgetStateProperty<MouseCursor?> enabledClicks =
      WidgetStateProperty<MouseCursor?>.fromMap(<WidgetStatesConstraint, MouseCursor?>{
    WidgetState.dragged: SystemMouseCursors.click,
    WidgetState.focused: SystemMouseCursors.click,
    WidgetState.hovered: SystemMouseCursors.click,
    WidgetState.pressed: SystemMouseCursors.click,
    WidgetState.scrolledUnder: SystemMouseCursors.click,
    WidgetState.selected: SystemMouseCursors.click,
  });

  // Design (page) //

  final int threeQAnim = (design.animDur * 0.75).toInt();

  // Text //

  final TextTheme textTheme = ezTextTheme(colors.onSurface, isDark: brightness == Brightness.dark);

  final Color inputBackground =
      colors.surface.asColor.withValues(alpha: max(colors.surface.asColor.a, focusOpacity));

  final IconThemeData iconData = IconThemeData(
    color: colors.primary.asColor,
    size: text.iconSize,
    applyTextScaling: true,
  );
  final IconThemeData appBarIconData = IconThemeData(
    color: colors.primary.asColor,
    size: textTheme.headlineLarge!.fontSize,
    applyTextScaling: true,
  );

  //* Make it so *//

  return ThemeData(
    // UX //

    materialTapTargetSize: MaterialTapTargetSize.padded,

    // Color scheme //

    brightness: brightness,
    colorScheme: basicColors,

    dividerColor: colors.secondary.asColor,
    hoverColor: focusColor,
    scaffoldBackgroundColor: colors.surfaceContainer.asColor,

    // Transitions //

    pageTransitionsTheme:
        design.animDur > ywt.minAnimationDuration ? EzTransitions() : EzNoTransitions(),

    // Typography //

    iconTheme: iconData,
    primaryIconTheme: iconData,

    textTheme: textTheme,
    primaryTextTheme: textTheme,

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colors.secondary.asColor,
      selectionColor: colors.secondary.asColor.withValues(alpha: selectionOpacity),
      selectionHandleColor: colors.primary.asColor,
    ),

    // Widgets //

    // App bar
    appBarTheme: AppBarTheme(
      backgroundColor: colors.surfaceDim,
      foregroundColor: colors.onSurface,
      titleTextStyle: textTheme.headlineLarge,
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      centerTitle: true,
      titleSpacing: 0,
    ),

    // Bottom sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colors.surfaceContainer.asColor,
      clipBehavior: Clip.antiAlias,
      dragHandleColor: colors.onSurface,
      modalBackgroundColor: colors.surfaceContainer.asColor,
      showDragHandle: true,
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected) ? colors.primary : colors.surface).asColor,
      ),
      checkColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            states.contains(WidgetState.selected) ? colors.onPrimary : null,
      ),
      overlayColor: WidgetStateProperty.all(focusColor),
      side: ezBorderSide(colors.primaryContainer, width: design.borderWidth),
      shape: design.buttonShape.shape,
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      alignment: Alignment.center,
      backgroundColor: colors.surfaceDim,
      clipBehavior: Clip.antiAlias,
      contentTextStyle: textTheme.bodyLarge,
      titleTextStyle: textTheme.titleLarge,
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: colors.secondary.asColor,
      space: design.spacing * 3,
    ),

    // Drawer
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: colors.surfaceDim,
    ),

    // Dropdown menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: textTheme.bodyLarge,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface.asColor,
        prefixIconColor: colors.primary.asColor,
        iconColor: colors.primary.asColor,
        suffixIconColor: colors.primary.asColor,
        hintStyle: textTheme.bodyLarge?.copyWith(color: colors.outline),
        labelStyle: textTheme.labelLarge,
        helperStyle: textTheme.labelLarge,
        errorStyle: textTheme.labelLarge?.copyWith(color: colors.error.asColor),
        errorMaxLines: 1,
        border: ezOutInBorder(
          colors.primaryContainer,
          borderWidth: design.borderWidth,
          borderRadius: design.buttonShape.textRadius,
        ),
        disabledBorder: ezOutInBorder(
          colors.outlineVariant,
          borderWidth: design.borderWidth,
          borderRadius: design.buttonShape.textRadius,
        ),
        enabledBorder: ezOutInBorder(
          colors.primaryContainer,
          borderWidth: design.borderWidth,
          borderRadius: design.buttonShape.textRadius,
        ),
        errorBorder: ezOutInBorder(
          colors.errorContainer,
          borderWidth: design.borderWidth,
          borderRadius: design.buttonShape.textRadius,
        ),
        focusedBorder: ezOutInBorder(
          colors.secondaryContainer,
          borderWidth: design.borderWidth,
          borderRadius: design.buttonShape.textRadius,
        ),
        focusedErrorBorder: ezOutInBorder(
          colors.tertiaryContainer,
          borderWidth: design.borderWidth,
          borderRadius: design.buttonShape.textRadius,
        ),
      ),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        backgroundBuilder: ezButtonLayer(
          colors.surface,
          border: ezBoxBorder(colors.primaryContainer, width: design.borderWidth),
          borderRadius: design.buttonShape.radius,
        ),
        backgroundColor: colors.surface.asColor,
        disabledForegroundColor: colors.outline,
        disabledIconColor: colors.outline,
        enabledMouseCursor: SystemMouseCursors.click,
        foregroundColor: colors.onSurface,
        iconColor: colors.primary.asColor,
        overlayColor: colors.primary.asColor,
        padding: EdgeInsets.all(design.padding),
        shadowColor: colors.shadow.asColor,
        shape: design.buttonShape.shape,
        side: ezBorderSide(colors.primaryContainer, width: design.borderWidth),
        textStyle: textTheme.bodyLarge,
      ),
    ),

    // Expansion tile
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      iconColor: colors.primary.asColor,
      collapsedIconColor: colors.primary.asColor,
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.only(
        left: ltr ? design.margin * 2 : 0,
        right: ltr ? 0 : design.margin * 2,
      ),
      expandedAlignment: ltr ? Alignment.centerLeft : Alignment.centerRight,
      expansionAnimationStyle: AnimationStyle(
        curve: design.animCurve,
        reverseCurve: design.animCurve,
        duration: Duration(milliseconds: threeQAnim),
        reverseDuration: Duration(milliseconds: threeQAnim),
      ),
    ),

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colors.primary.asColor,
      foregroundColor: colors.onPrimary,
      hoverColor: focusColor,
      extendedPadding: EdgeInsets.zero,
      shape: design.buttonShape.shape,
      mouseCursor: enabledClicks,
      iconSize: text.iconSize,
      sizeConstraints: BoxConstraints(
        minWidth: text.iconSize + (design.padding * 1.1),
        maxWidth: text.iconSize + (design.padding * 1.1),
        minHeight: text.iconSize + (design.padding * 1.1),
        maxHeight: text.iconSize + (design.padding * 1.1),
      ),
    ),

    // Icon button
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: colors.surface.asColor,
        foregroundColor: colors.primary.asColor,
        disabledForegroundColor: colors.outline,
        overlayColor: colors.primary.asColor,
        side: ezBorderSide(colors.primaryContainer, width: design.borderWidth),
        enabledMouseCursor: SystemMouseCursors.click,
        shape: design.buttonShape.shape,
        iconSize: text.iconSize,
        alignment: Alignment.center,
        padding: EzInsets.wrap(design.padding),
      ),
    ),

    // Input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      contentPadding: EdgeInsets.all(design.margin),
      fillColor: inputBackground,
      prefixIconColor: colors.primary.asColor,
      iconColor: colors.primary.asColor,
      suffixIconColor: colors.primary.asColor,
      hintStyle: textTheme.bodyLarge?.copyWith(color: colors.outline),
      labelStyle: textTheme.labelLarge,
      helperStyle: textTheme.labelLarge,
      errorStyle: textTheme.labelLarge!.copyWith(color: colors.error.asColor),
      errorMaxLines: 1,
      border: ezUnderInBorder(
        colors.primaryContainer,
        borderWidth: design.borderWidth,
        borderRadius: design.buttonShape.textFieldRadius,
      ),
      disabledBorder: ezUnderInBorder(
        colors.outlineVariant,
        borderWidth: design.borderWidth,
        borderRadius: design.buttonShape.textFieldRadius,
      ),
      enabledBorder: ezUnderInBorder(
        colors.primaryContainer,
        borderWidth: design.borderWidth,
        borderRadius: design.buttonShape.textFieldRadius,
      ),
      errorBorder: ezUnderInBorder(
        colors.errorContainer,
        borderWidth: design.borderWidth,
        borderRadius: design.buttonShape.textFieldRadius,
      ),
      focusedBorder: ezUnderInBorder(
        colors.secondaryContainer,
        borderWidth: design.borderWidth,
        borderRadius: design.buttonShape.textFieldRadius,
      ),
      focusedErrorBorder: ezUnderInBorder(
        colors.tertiaryContainer,
        borderWidth: design.borderWidth,
        borderRadius: design.buttonShape.textFieldRadius,
      ),
    ),

    // Menu
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(colors.surface.asColor),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        side: WidgetStateProperty.all(ezBorderSide(
          colors.primaryContainer,
          width: design.borderWidth,
        )),
        alignment: Alignment.center,
      ),
    ),

    // Menu button
    menuButtonTheme: MenuButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: colors.surface.asColor,
        foregroundColor: colors.onSurface,
        disabledForegroundColor: colors.outline,
        iconColor: colors.primary.asColor,
        disabledIconColor: colors.outline,
        enabledMouseCursor: SystemMouseCursors.click,
        overlayColor: colors.primary.asColor,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(design.padding),
      ),
    ),

    // Progress indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colors.secondary.asColor,
    ),

    // Radio button
    radioTheme: RadioThemeData(
      overlayColor: WidgetStateProperty.all(focusColor),
      mouseCursor: enabledClicks,
    ),

    // Slider
    sliderTheme: SliderThemeData(
      thumbShape: RoundSliderThumbShape(
        enabledThumbRadius: text.iconSize / 2,
        disabledThumbRadius: text.iconSize / 2,
      ),
    ),

    // Segmented button
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        backgroundColor: colors.surface.asColor,
        selectedBackgroundColor: colors.primary.asColor,
        enabledMouseCursor: SystemMouseCursors.click,
        foregroundColor: colors.primary.asColor,
        selectedForegroundColor: colors.onPrimary,
        disabledForegroundColor: colors.outline,
        side: ezBorderSide(colors.primaryContainer, width: design.borderWidth),
        shape: design.buttonShape.shape,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(design.padding),
      ),
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: colors.surfaceDim,
      closeIconColor: colors.primary.asColor,
      shape: design.buttonShape.shape.copyWith(
        side: ezBorderSide(colors.secondary, width: design.borderWidth),
      ),
      contentTextStyle: textTheme.bodyLarge,
      insetPadding: EdgeInsets.all(design.margin),
      dismissDirection: DismissDirection.down,
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected) ? colors.primary.asColor : colors.outline),
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected) ? colors.primary.asColor : colors.outline)
                .withValues(alpha: focusOpacity),
      ),
      trackOutlineColor: WidgetStateProperty.all(colors.surface.asColor),
      overlayColor: WidgetStateProperty.all(focusColor),
    ),

    // Text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: colors.surface.asColor.withValues(alpha: text.backgroundOpacity),
        foregroundColor: colors.onSurface,
        disabledForegroundColor: colors.outline,
        iconColor: colors.primary.asColor,
        disabledIconColor: colors.outline,
        enabledMouseCursor: SystemMouseCursors.click,
        overlayColor: colors.primary.asColor,
        shape: design.buttonShape.shape,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(design.margin),
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: ezBoxDeco(
        EzSwitchColor(color: colors.surfaceDim),
        border: ezBoxBorder(colors.secondary, width: design.borderWidth),
        borderRadius: EzButtonShape.roundRect.radius,
      ),
      textStyle: textTheme.bodyLarge,
      textAlign: TextAlign.center,
      margin: EdgeInsets.all(design.margin),
      padding: EdgeInsets.all(design.padding),
      waitDuration: const Duration(milliseconds: 750),
    ),
  );
}
