/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'dart:math';
import 'package:material_ui/material_ui.dart';

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

  // Has a twin in EzCP
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

  // Has a twin in EzCP
  BoxBorder buildBox(EzSwitchColor fill) => fill.color == null
      ? EzGradientBoxBorder(
          gradient: fill.gradient!,
          width: design.borderWidth,
        )
      : Border.all(
          color: fill.color!,
          width: design.borderWidth,
        );

  // Has a twin in EzCP
  BoxDecoration buildDecoration(
    EzSwitchColor fill, {
    double? opacity,
    BoxShape shape = BoxShape.rectangle,
    BoxBorder? border,
    BorderRadius? borderRadius,
  }) =>
      (opacity == null)
          ? BoxDecoration(
              border: border,
              borderRadius: borderRadius,
              color: fill.color,
              gradient: fill.gradient,
              shape: shape,
            )
          : BoxDecoration(
              border: border,
              borderRadius: borderRadius,
              color: fill.color?.withValues(alpha: opacity),
              gradient: fill.gradient?.withOpacity(opacity),
              shape: shape,
            );

  // Has a twin in EzCp
  ButtonLayerBuilder? buttonLayer(
    EzSwitchColor fill, {
    BoxShape shape = BoxShape.rectangle,
  }) =>
      (fill.gradient == null)
          ? null
          : (_, __, Widget? child) => Ink(
                decoration: BoxDecoration(
                  border: buildBox(fill),
                  borderRadius: design.buttonShape.radius,
                  gradient: fill.gradient,
                  shape: shape,
                ),
                child: child,
              );

  OutlineInputBorder buildOIBorder(EzSwitchColor fill) => OutlineInputBorder(
        borderSide: buildBorder(fill),
        gapPadding: 0,
      );

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
      side: buildBorder(colors.primaryContainer),
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
        border: buildOIBorder(colors.primaryContainer),
        disabledBorder: buildOIBorder(colors.outlineVariant),
        enabledBorder: buildOIBorder(colors.primaryContainer),
        errorBorder: buildOIBorder(colors.errorContainer),
        focusedBorder: buildOIBorder(colors.secondaryContainer),
        focusedErrorBorder: buildOIBorder(colors.tertiaryContainer),
      ),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        backgroundBuilder: buttonLayer(colors.surface),
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
        side: buildBorder(colors.primaryContainer),
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
        side: buildBorder(colors.primaryContainer),
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
      border: UnderlineInputBorder(borderSide: buildBorder(colors.primaryContainer)),
      disabledBorder: UnderlineInputBorder(borderSide: buildBorder(colors.outlineVariant)),
      enabledBorder: UnderlineInputBorder(borderSide: buildBorder(colors.primaryContainer)),
      errorBorder: UnderlineInputBorder(borderSide: buildBorder(colors.errorContainer)),
      focusedBorder: UnderlineInputBorder(borderSide: buildBorder(colors.secondaryContainer)),
      focusedErrorBorder: UnderlineInputBorder(borderSide: buildBorder(colors.tertiaryContainer)),
    ),

    // Menu
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(colors.surface.asColor),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        side: WidgetStateProperty.all(buildBorder(colors.primaryContainer)),
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
        side: buildBorder(colors.primaryContainer),
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
      shape: design.buttonShape.shape.copyWith(side: buildBorder(colors.secondary)),
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
      decoration: buildDecoration(
        EzSwitchColor(color: colors.surfaceDim),
        border: buildBox(colors.secondary),
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
