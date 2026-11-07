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

  final TextTheme textTheme = ezTextTheme(colors.onSurface, isDark: brightness == Brightness.dark);

  final Color linkTextBackground = colors.surface.withValues(alpha: text.backgroundOpacity);
  final Color richTextBackground =
      colors.surfaceContainer.withValues(alpha: text.backgroundOpacity);

  final Color inputBackground = colors.surface.withValues(
    alpha: max(colors.surface.a, crucialTextOpacity),
  );
  final Color crucialTextShadow = crucialTextOpacity < 1.0
      ? colors.shadow.withValues(alpha: crucialTextOpacity * shadowMod)
      : colors.shadow;

  final IconThemeData iconData = IconThemeData(
    color: colors.primary,
    size: text.iconSize,
    applyTextScaling: true,
  );
  final IconThemeData appBarIconData = IconThemeData(
    color: colors.primary,
    size: textTheme.headlineLarge!.fontSize,
    applyTextScaling: true,
  );

  //* Make it so *//

  return ThemeData(
    // UX //

    materialTapTargetSize: MaterialTapTargetSize.padded,

    // Color scheme //

    brightness: brightness,
    colorScheme: colorScheme,

    dividerColor: colors.secondary,
    hoverColor: focusColor,
    scaffoldBackgroundColor: colors.surfaceContainer,

    // Transitions //

    pageTransitionsTheme:
        animDuration > ywt.minAnimationDuration ? EzTransitions() : EzNoTransitions(),

    // Typography //

    textTheme: textTheme,
    primaryTextTheme: textTheme,

    iconTheme: iconData,
    primaryIconTheme: iconData,

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colors.secondary,
      selectionColor: colors.secondary.withValues(alpha: selectionOpacity),
      selectionHandleColor: colors.primary,
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
      backgroundColor: colors.surfaceContainer,
      modalBackgroundColor: colors.surfaceContainer,
      showDragHandle: true,
      dragHandleColor: colors.onSurface,
    ),

    // Card
    cardTheme: CardThemeData(
      color: colors.surfaceDim.withValues(alpha: crucialTextOpacity),
      shadowColor: crucialTextShadow,
      margin: EdgeInsets.zero,
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected)) ? colors.primary : colors.surface,
      ),
      checkColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected)) ? colors.onPrimary : null,
      ),
      overlayColor: WidgetStateProperty.all(focusColor),
      side: buildBorder(colors.primary),
      shape: buttonShape,
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: colors.surfaceDim,
      titleTextStyle: textTheme.titleLarge,
      contentTextStyle: textTheme.bodyLarge,
      alignment: Alignment.center,
    ),

    // Divider
    dividerTheme: DividerThemeData(color: colors.secondary, space: spacing * 3),

    // Drawer
    navigationDrawerTheme: NavigationDrawerThemeData(backgroundColor: colors.surfaceDim),

    // Dropdown menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: textTheme.bodyLarge,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        prefixIconColor: colors.primary,
        iconColor: colors.primary,
        suffixIconColor: colors.primary,
        hintStyle: textTheme.bodyLarge?.copyWith(color: colors.outline),
        labelStyle: textTheme.labelLarge,
        helperStyle: textTheme.labelLarge,
        errorStyle: textTheme.labelLarge?.copyWith(color: colors.error),
        errorMaxLines: 1,
        border: OutlineInputBorder(
          borderSide: buildBorder(colors.primaryContainer),
          gapPadding: 0,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: buildBorder(colors.outlineVariant),
          gapPadding: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: buildBorder(colors.primaryContainer),
          gapPadding: 0,
        ),
        errorBorder: OutlineInputBorder(borderSide: buildBorder(colors.error), gapPadding: 0),
        focusedBorder: OutlineInputBorder(
          borderSide: buildBorder(colors.secondaryContainer),
          gapPadding: 0,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: buildBorder(colors.error),
          gapPadding: 0,
        ),
      ),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        shadowColor: colors.shadow,
        disabledForegroundColor: colors.outline,
        iconColor: colors.primary,
        disabledIconColor: colors.outline,
        overlayColor: colors.primary,
        side: buildBorder(colors.primaryContainer),
        enabledMouseCursor: SystemMouseCursors.click,
        shape: buttonShape,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(design.padding),
      ),
    ),

    // Expansion tile
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: richTextBackground,
      collapsedBackgroundColor: richTextBackground,
      iconColor: colors.primary,
      collapsedIconColor: colors.primary,
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.only(left: ltr ? margin * 2 : 0, right: ltr ? 0 : margin * 2),
      expandedAlignment: ltr ? Alignment.centerLeft : Alignment.centerRight,
      expansionAnimationStyle: AnimationStyle(
        curve: animCurve,
        reverseCurve: animCurve,
        duration: Duration(milliseconds: threeQAnim),
        reverseDuration: Duration(milliseconds: threeQAnim),
      ),
    ),

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: crucialPrimaryBackground,
      foregroundColor: colors.onPrimary,
      hoverColor: focusColor,
      extendedPadding: EdgeInsets.zero,
      shape: buttonShape,
      mouseCursor: enabledClicks,
      iconSize: iconSize,
      sizeConstraints: BoxConstraints(
        minWidth: iconSize + (padding * 1.1),
        maxWidth: iconSize + (padding * 1.1),
        minHeight: iconSize + (padding * 1.1),
        maxHeight: iconSize + (padding * 1.1),
      ),
    ),

    // Icon button
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: colors.surface,
        foregroundColor: colors.primary,
        disabledForegroundColor: colors.outline,
        overlayColor: colors.primary,
        side: buildBorder(colors.primaryContainer),
        enabledMouseCursor: SystemMouseCursors.click,
        shape: buttonShape,
        iconSize: iconSize,
        alignment: Alignment.center,
        padding: EzInsets.wrap(design.padding),
      ),
    ),

    // Input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      contentPadding: EdgeInsets.all(design.margin),
      fillColor: inputBackground,
      prefixIconColor: colors.primary,
      iconColor: colors.primary,
      suffixIconColor: colors.primary,
      hintStyle: textTheme.bodyLarge?.copyWith(color: colors.outline),
      labelStyle: textTheme.labelLarge,
      helperStyle: textTheme.labelLarge,
      errorStyle: textTheme.labelLarge!.copyWith(color: colors.error),
      errorMaxLines: 1,
      border: UnderlineInputBorder(borderSide: buildBorder(crucialPrimaryBorder)),
      disabledBorder: UnderlineInputBorder(borderSide: buildBorder(crucialDisabledBorder)),
      enabledBorder: UnderlineInputBorder(borderSide: buildBorder(crucialPrimaryBorder)),
      errorBorder: UnderlineInputBorder(borderSide: buildBorder(colors.error)),
      focusedBorder: UnderlineInputBorder(borderSide: buildBorder(crucialSecondaryBorder)),
      focusedErrorBorder: UnderlineInputBorder(borderSide: buildBorder(colors.error)),
    ),

    // Menu
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(crucialButtonBackground),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        side: WidgetStateProperty.all(buildBorder(colors.primaryContainer)),
        alignment: Alignment.center,
      ),
    ),

    // Menu button
    menuButtonTheme: MenuButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: crucialButtonBackground,
        foregroundColor: colors.onSurface,
        disabledForegroundColor: colors.outline,
        iconColor: colors.primary,
        disabledIconColor: colors.outline,
        enabledMouseCursor: SystemMouseCursors.click,
        overlayColor: colors.primary,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(design.padding),
      ),
    ),

    // Progress indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.secondary),

    // Radio button
    radioTheme: RadioThemeData(
      overlayColor: WidgetStateProperty.all(focusColor),
      mouseCursor: enabledClicks,
    ),

    // Slider
    sliderTheme: SliderThemeData(
      thumbShape: RoundSliderThumbShape(
        enabledThumbRadius: iconSize / 2,
        disabledThumbRadius: iconSize / 2,
      ),
    ),

    // Segmented button
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        backgroundColor: colors.surface,
        selectedBackgroundColor: colors.primary,
        enabledMouseCursor: SystemMouseCursors.click,
        foregroundColor: colors.primary,
        selectedForegroundColor: colors.onPrimary,
        disabledForegroundColor: colors.outline,
        side: buildBorder(colors.primaryContainer),
        shape: buttonShape,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(design.padding),
      ),
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: colors.surfaceDim,
      closeIconColor: colors.primary,
      shape: buttonShape.copyWith(side: buildBorder(colors.secondary)),
      contentTextStyle: textTheme.bodyLarge,
      insetPadding: EdgeInsets.all(design.margin),
      dismissDirection: DismissDirection.down,
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected)) ? colors.primary : colors.outline,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            ((states.contains(WidgetState.selected)) ? colors.primary : colors.outline)
                .withValues(alpha: focusOpacity),
      ),
      trackOutlineColor: WidgetStateProperty.all(colors.surface),
      overlayColor: WidgetStateProperty.all(focusColor),
    ),

    // Text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: linkTextBackground,
        foregroundColor: colors.onSurface,
        disabledForegroundColor: colors.outline,
        iconColor: colors.primary,
        disabledIconColor: colors.outline,
        enabledMouseCursor: SystemMouseCursors.click,
        overlayColor: colors.primary,
        shape: buttonShape,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(design.margin),
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: colors.surfaceDim,
        border: Border.all(color: colors.secondary, width: borderWidth),
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
