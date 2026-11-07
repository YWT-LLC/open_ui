/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'dart:math';
import 'package:flutter/material.dart';

/// Creates a [ThemeData] from [EzCM] values
ThemeData ezThemeData(
  Brightness brightness, {
  required bool ltr,
  required ColorScheme basicColors,
  required EzColorCache color,
  required EzDesignCache design,
  required EzLayoutCache layout,
  required EzTextCache text,
}) {
  //* Setup *//

  // Color //

  final Color focusColor = color.primary.asColor.withValues(alpha: focusOpacity);

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

  BorderSide buildBorder(
    EzSwitchColor fill, {
    double? width,
    double? opacity,
  }) =>
      (width ?? design.borderWidth) == 0
          ? BorderSide.none
          : fill.color == null
              ? EzGradientBorderSide(
                  gradient: opacity == null ? fill.gradient! : fill.gradient!.withOpacity(opacity),
                  width: width ?? design.borderWidth,
                )
              : BorderSide(
                  color: opacity == null ? fill.color! : fill.color!.withValues(alpha: opacity),
                  width: width ?? design.borderWidth,
                );

  // Design (page) //

  final int threeQAnim = (design.animDur * 0.75).toInt();

  // Text //

  final TextTheme textTheme = ezTextTheme(color.onSurface, isDark: brightness == Brightness.dark);

  final Color linkTextBackground = color.surface.withValues(alpha: text.backgroundOpacity);
  final Color richTextBackground = color.surfaceContainer.withValues(alpha: text.backgroundOpacity);

  final Color inputBackground = color.surface.withValues(
    alpha: max(color.surface.a, crucialTextOpacity),
  );
  final Color crucialTextShadow = crucialTextOpacity < 1.0
      ? color.shadow.withValues(alpha: crucialTextOpacity * shadowMod)
      : color.shadow;

  final IconThemeData iconData = IconThemeData(
    color: color.primary,
    size: text.iconSize,
    applyTextScaling: true,
  );
  final IconThemeData appBarIconData = IconThemeData(
    color: color.primary,
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

    dividerColor: color.secondary,
    hoverColor: focusColor,
    scaffoldBackgroundColor: color.surfaceContainer,

    // Transitions //

    pageTransitionsTheme:
        design.animDur > ywt.minAnimationDuration ? EzTransitions() : EzNoTransitions(),

    // Typography //

    textTheme: textTheme,
    primaryTextTheme: textTheme,

    iconTheme: iconData,
    primaryIconTheme: iconData,

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: color.secondary,
      selectionColor: color.secondary.withValues(alpha: selectionOpacity),
      selectionHandleColor: color.primary,
    ),

    // Widgets //

    // App bar
    appBarTheme: AppBarTheme(
      backgroundColor: color.surfaceDim,
      foregroundColor: color.onSurface,
      titleTextStyle: textTheme.headlineLarge,
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      centerTitle: true,
      titleSpacing: 0,
    ),

    // Bottom sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: color.surfaceContainer,
      modalBackgroundColor: color.surfaceContainer,
      showDragHandle: true,
      dragHandleColor: color.onSurface,
    ),

    // Card
    cardTheme: CardThemeData(
      color: color.surfaceDim.withValues(alpha: crucialTextOpacity),
      shadowColor: crucialTextShadow,
      margin: EdgeInsets.zero,
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected)) ? color.primary : color.surface,
      ),
      checkColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected)) ? color.onPrimary : null,
      ),
      overlayColor: WidgetStateProperty.all(focusColor),
      side: buildBorder(color.primary),
      shape: design.buttonShape.shape,
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: color.surfaceDim,
      titleTextStyle: textTheme.titleLarge,
      contentTextStyle: textTheme.bodyLarge,
      alignment: Alignment.center,
    ),

    // Divider
    dividerTheme: DividerThemeData(color: color.secondary, space: design.spacing * 3),

    // Drawer
    navigationDrawerTheme: NavigationDrawerThemeData(backgroundColor: color.surfaceDim),

    // Dropdown menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: textTheme.bodyLarge,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: color.surface,
        prefixIconColor: color.primary,
        iconColor: color.primary,
        suffixIconColor: color.primary,
        hintStyle: textTheme.bodyLarge?.copyWith(color: color.outline),
        labelStyle: textTheme.labelLarge,
        helperStyle: textTheme.labelLarge,
        errorStyle: textTheme.labelLarge?.copyWith(color: color.error),
        errorMaxLines: 1,
        border: OutlineInputBorder(
          borderSide: buildBorder(color.primaryContainer),
          gapPadding: 0,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: buildBorder(color.outlineVariant),
          gapPadding: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: buildBorder(color.primaryContainer),
          gapPadding: 0,
        ),
        errorBorder: OutlineInputBorder(borderSide: buildBorder(color.error), gapPadding: 0),
        focusedBorder: OutlineInputBorder(
          borderSide: buildBorder(color.secondaryContainer),
          gapPadding: 0,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: buildBorder(color.error),
          gapPadding: 0,
        ),
      ),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.surface,
        foregroundColor: color.onSurface,
        shadowColor: color.shadow,
        disabledForegroundColor: color.outline,
        iconColor: color.primary,
        disabledIconColor: color.outline,
        overlayColor: color.primary,
        side: buildBorder(color.primaryContainer),
        enabledMouseCursor: SystemMouseCursors.click,
        shape: design.buttonShape.shape,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(design.padding),
      ),
    ),

    // Expansion tile
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: richTextBackground,
      collapsedBackgroundColor: richTextBackground,
      iconColor: color.primary,
      collapsedIconColor: color.primary,
      tilePadding: EdgeInsets.zero,
      childrenPadding:
          EdgeInsets.only(left: ltr ? design.margin * 2 : 0, right: ltr ? 0 : design.margin * 2),
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
      backgroundColor: crucialPrimaryBackground,
      foregroundColor: color.onPrimary,
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
        backgroundColor: color.surface,
        foregroundColor: color.primary,
        disabledForegroundColor: color.outline,
        overlayColor: color.primary,
        side: buildBorder(color.primaryContainer),
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
      prefixIconColor: color.primary,
      iconColor: color.primary,
      suffixIconColor: color.primary,
      hintStyle: textTheme.bodyLarge?.copyWith(color: color.outline),
      labelStyle: textTheme.labelLarge,
      helperStyle: textTheme.labelLarge,
      errorStyle: textTheme.labelLarge!.copyWith(color: color.error),
      errorMaxLines: 1,
      border: UnderlineInputBorder(borderSide: buildBorder(crucialPrimaryBorder)),
      disabledBorder: UnderlineInputBorder(borderSide: buildBorder(crucialDisabledBorder)),
      enabledBorder: UnderlineInputBorder(borderSide: buildBorder(crucialPrimaryBorder)),
      errorBorder: UnderlineInputBorder(borderSide: buildBorder(color.error)),
      focusedBorder: UnderlineInputBorder(borderSide: buildBorder(crucialSecondaryBorder)),
      focusedErrorBorder: UnderlineInputBorder(borderSide: buildBorder(color.error)),
    ),

    // Menu
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(crucialButtonBackground),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        side: WidgetStateProperty.all(buildBorder(color.primaryContainer)),
        alignment: Alignment.center,
      ),
    ),

    // Menu button
    menuButtonTheme: MenuButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: crucialButtonBackground,
        foregroundColor: color.onSurface,
        disabledForegroundColor: color.outline,
        iconColor: color.primary,
        disabledIconColor: color.outline,
        enabledMouseCursor: SystemMouseCursors.click,
        overlayColor: color.primary,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(design.padding),
      ),
    ),

    // Progress indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(color: color.secondary),

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
        backgroundColor: color.surface,
        selectedBackgroundColor: color.primary,
        enabledMouseCursor: SystemMouseCursors.click,
        foregroundColor: color.primary,
        selectedForegroundColor: color.onPrimary,
        disabledForegroundColor: color.outline,
        side: buildBorder(color.primaryContainer),
        shape: design.buttonShape.shape,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(design.padding),
      ),
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color.surfaceDim,
      closeIconColor: color.primary,
      shape: design.buttonShape.shape.copyWith(side: buildBorder(color.secondary)),
      contentTextStyle: textTheme.bodyLarge,
      insetPadding: EdgeInsets.all(design.margin),
      dismissDirection: DismissDirection.down,
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected)) ? color.primary : color.outline,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            ((states.contains(WidgetState.selected)) ? color.primary : color.outline)
                .withValues(alpha: focusOpacity),
      ),
      trackOutlineColor: WidgetStateProperty.all(color.surface),
      overlayColor: WidgetStateProperty.all(focusColor),
    ),

    // Text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: linkTextBackground,
        foregroundColor: color.onSurface,
        disabledForegroundColor: color.outline,
        iconColor: color.primary,
        disabledIconColor: color.outline,
        enabledMouseCursor: SystemMouseCursors.click,
        overlayColor: color.primary,
        shape: design.buttonShape.shape,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(design.margin),
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: color.surfaceDim,
        border: Border.all(color: color.secondary, width: design.borderWidth),
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
