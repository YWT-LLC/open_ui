/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

/// Creates a [ThemeData] from [EzConfig] values
ThemeData ezThemeData(Brightness brightness, bool ltr) {
  //* Setup *//

  final bool isDark = Brightness.dark == brightness;

  // Color //

  final ColorScheme colorScheme = ezColorScheme(brightness);

  final Color focusColor = colorScheme.primary.withValues(alpha: focusOpacity);

  final Color crucialButtonBackground =
      colorScheme.surface.withValues(alpha: max(colorScheme.surface.a, focusOpacity));
  final Color crucialPrimaryBackground =
      colorScheme.primary.withValues(alpha: max(colorScheme.primary.a, focusOpacity));
  final Color crucialPrimaryBorder = colorScheme.primaryContainer
      .withValues(alpha: max(colorScheme.primaryContainer.a, focusOpacity));
  final Color crucialSecondaryBorder = colorScheme.secondaryContainer
      .withValues(alpha: max(colorScheme.secondaryContainer.a, focusOpacity));
  final Color crucialDisabledBorder =
      colorScheme.outlineVariant.withValues(alpha: max(colorScheme.outlineVariant.a, focusOpacity));

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

  final double padding = isDark ? EzConfig.get(darkPaddingKey) : EzConfig.get(lightPaddingKey);

  final OutlinedBorder buttonShape =
      EBSConfig.lookup(EzConfig.get(isDark ? darkButtonShapeKey : lightButtonShapeKey)).shape;

  final double borderWidth = EzConfig.get(isDark ? darkBorderWidthKey : lightBorderWidthKey);
  BorderSide buildBorder(Color color) =>
      borderWidth == 0 ? BorderSide.none : BorderSide(color: color, width: borderWidth);

  // Design (page) //

  final double margin = EzConfig.get(isDark ? darkMarginKey : lightMarginKey);
  final double spacing = EzConfig.get(isDark ? darkSpacingKey : lightSpacingKey);

  final int animDuration =
      EzConfig.get(isDark ? darkAnimationDurationKey : lightAnimationDurationKey);
  final int threeQAnim = (animDuration * 0.75).toInt();

  final Curve animCurve =
      EACConfig.translate(EzConfig.get(isDark ? darkAnimationCurveKey : lightAnimationCurveKey));

  // Text //

  final TextTheme textTheme = ezTextTheme(colorScheme.onSurface, isDark: isDark);

  final double textOpacity =
      EzConfig.get(isDark ? darkTextBackgroundOpacityKey : lightTextBackgroundOpacityKey);
  final double crucialTextOpacity = max(textOpacity, focusOpacity);

  final Color linkTextBackground = colorScheme.surface.withValues(alpha: textOpacity);
  final Color richTextBackground = colorScheme.surfaceContainer.withValues(alpha: textOpacity);

  final Color inputBackground =
      colorScheme.surface.withValues(alpha: max(colorScheme.surface.a, crucialTextOpacity));
  final Color crucialTextShadow = crucialTextOpacity < 1.0
      ? colorScheme.shadow.withValues(alpha: crucialTextOpacity * shadowMod)
      : colorScheme.shadow;

  final double iconSize = EzConfig.get(isDark ? darkIconSizeKey : lightIconSizeKey);

  final IconThemeData iconData = IconThemeData(
    color: colorScheme.primary,
    size: iconSize,
    applyTextScaling: true,
  );
  final IconThemeData appBarIconData = IconThemeData(
    color: colorScheme.primary,
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

    dividerColor: colorScheme.secondary,
    hoverColor: focusColor,
    scaffoldBackgroundColor: colorScheme.surfaceContainer,

    // Transitions //

    pageTransitionsTheme: animDuration > minAnimationDuration ? EzTransitions() : EzNoTransitions(),

    // Typography //

    textTheme: textTheme,
    primaryTextTheme: textTheme,

    iconTheme: iconData,
    primaryIconTheme: iconData,

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colorScheme.secondary,
      selectionColor: colorScheme.secondary.withValues(alpha: selectionOpacity),
      selectionHandleColor: colorScheme.primary,
    ),

    // Widgets //

    // App bar
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surfaceDim,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: textTheme.headlineLarge,
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      centerTitle: true,
      titleSpacing: 0,
    ),

    // Bottom sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surfaceContainer,
      modalBackgroundColor: colorScheme.surfaceContainer,
      showDragHandle: true,
      dragHandleColor: colorScheme.onSurface,
    ),

    // Card
    cardTheme: CardThemeData(
      color: colorScheme.surfaceDim.withValues(alpha: crucialTextOpacity),
      shadowColor: crucialTextShadow,
      margin: EdgeInsets.zero,
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected)) ? colorScheme.primary : colorScheme.surface,
      ),
      checkColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected)) ? colorScheme.onPrimary : null,
      ),
      overlayColor: WidgetStateProperty.all(focusColor),
      side: buildBorder(colorScheme.primary),
      shape: buttonShape,
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: colorScheme.surfaceDim,
      titleTextStyle: textTheme.titleLarge,
      contentTextStyle: textTheme.bodyLarge,
      alignment: Alignment.center,
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: colorScheme.secondary,
      space: spacing * 3,
    ),

    // Drawer
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: colorScheme.surfaceDim,
    ),

    // Dropdown menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: textTheme.bodyLarge,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        prefixIconColor: colorScheme.primary,
        iconColor: colorScheme.primary,
        suffixIconColor: colorScheme.primary,
        hintStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
        labelStyle: textTheme.labelLarge,
        helperStyle: textTheme.labelLarge,
        errorStyle: textTheme.labelLarge?.copyWith(color: colorScheme.error),
        errorMaxLines: 1,
        border: OutlineInputBorder(
          borderSide: buildBorder(colorScheme.primaryContainer),
          gapPadding: 0,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: buildBorder(colorScheme.outlineVariant),
          gapPadding: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: buildBorder(colorScheme.primaryContainer),
          gapPadding: 0,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: buildBorder(colorScheme.error),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: buildBorder(colorScheme.secondaryContainer),
          gapPadding: 0,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: buildBorder(colorScheme.error),
          gapPadding: 0,
        ),
      ),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        shadowColor: colorScheme.shadow,
        disabledForegroundColor: colorScheme.outline,
        iconColor: colorScheme.primary,
        disabledIconColor: colorScheme.outline,
        overlayColor: colorScheme.primary,
        side: buildBorder(colorScheme.primaryContainer),
        enabledMouseCursor: SystemMouseCursors.click,
        shape: buttonShape,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
      ),
    ),

    // Expansion tile
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: richTextBackground,
      collapsedBackgroundColor: richTextBackground,
      iconColor: colorScheme.primary,
      collapsedIconColor: colorScheme.primary,
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.only(
        left: ltr ? margin * 2 : 0,
        right: ltr ? 0 : margin * 2,
      ),
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
      foregroundColor: colorScheme.onPrimary,
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
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.outline,
        overlayColor: colorScheme.primary,
        side: buildBorder(colorScheme.primaryContainer),
        enabledMouseCursor: SystemMouseCursors.click,
        shape: buttonShape,
        iconSize: iconSize,
        alignment: Alignment.center,
        padding: EzInsets.wrap(padding),
      ),
    ),

    // Input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputBackground,
      prefixIconColor: colorScheme.primary,
      iconColor: colorScheme.primary,
      suffixIconColor: colorScheme.primary,
      hintStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
      labelStyle: textTheme.labelLarge,
      helperStyle: textTheme.labelLarge,
      errorStyle: textTheme.labelLarge!.copyWith(color: colorScheme.error),
      errorMaxLines: 1,
      border: UnderlineInputBorder(borderSide: buildBorder(crucialPrimaryBorder)),
      disabledBorder: UnderlineInputBorder(borderSide: buildBorder(crucialDisabledBorder)),
      enabledBorder: UnderlineInputBorder(borderSide: buildBorder(crucialPrimaryBorder)),
      errorBorder: UnderlineInputBorder(borderSide: buildBorder(colorScheme.error)),
      focusedBorder: UnderlineInputBorder(borderSide: buildBorder(crucialSecondaryBorder)),
      focusedErrorBorder: UnderlineInputBorder(borderSide: buildBorder(colorScheme.error)),
    ),

    // Menu
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(crucialButtonBackground),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        side: WidgetStateProperty.all(buildBorder(colorScheme.primaryContainer)),
        alignment: Alignment.center,
      ),
    ),

    // Menu button
    menuButtonTheme: MenuButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: crucialButtonBackground,
        foregroundColor: colorScheme.onSurface,
        disabledForegroundColor: colorScheme.outline,
        iconColor: colorScheme.primary,
        disabledIconColor: colorScheme.outline,
        enabledMouseCursor: SystemMouseCursors.click,
        overlayColor: colorScheme.primary,
        side: null,
        shape: null,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EzInsets.wrap(padding),
      ),
    ),

    // Progress indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.secondary,
    ),

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
        backgroundColor: colorScheme.surface,
        selectedBackgroundColor: colorScheme.primary,
        enabledMouseCursor: SystemMouseCursors.click,
        foregroundColor: colorScheme.primary,
        selectedForegroundColor: colorScheme.onPrimary,
        disabledForegroundColor: colorScheme.outline,
        side: buildBorder(colorScheme.primaryContainer),
        shape: buttonShape,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
      ),
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: colorScheme.surfaceDim,
      closeIconColor: colorScheme.primary,
      shape: buttonShape.copyWith(side: buildBorder(colorScheme.secondary)),
      contentTextStyle: textTheme.bodyLarge,
      insetPadding: EdgeInsets.all(margin),
      dismissDirection: DismissDirection.down,
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected)) ? colorScheme.primary : colorScheme.outline,
      ),
      trackColor: WidgetStateProperty.all(crucialButtonBackground),
      trackOutlineColor: WidgetStateProperty.all(colorScheme.primaryContainer),
      overlayColor: WidgetStateProperty.all(focusColor),
    ),

    // Text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: linkTextBackground,
        foregroundColor: colorScheme.onSurface,
        disabledForegroundColor: colorScheme.outline,
        iconColor: colorScheme.primary,
        disabledIconColor: colorScheme.outline,
        enabledMouseCursor: SystemMouseCursors.click,
        overlayColor: colorScheme.primary,
        side: null,
        shape: null,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: colorScheme.surfaceDim,
        border: Border.all(
          color: colorScheme.secondary,
          width: borderWidth,
        ),
        borderRadius: ezRoundEdge,
      ),
      textStyle: textTheme.bodyLarge,
      textAlign: TextAlign.center,
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(margin),
      waitDuration: const Duration(milliseconds: 750),
    ),
  );
}
