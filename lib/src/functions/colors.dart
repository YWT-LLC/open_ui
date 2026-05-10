/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Returns the guesstimated most readable text color (black/white) for [background]
Color getTextColor(Color background) {
  final int lumR = (background.r * 255.0 * 0.299).round();
  final int lumG = (background.g * 255.0 * 0.587).round();
  final int lumB = (background.b * 255.0 * 0.114).round();

  return Color(((lumR + lumG + lumB) >= 150) ? blackHex : whiteHex);
}

/// Generate an [EzConfig] based [ColorScheme]
ColorScheme ezColorScheme(Brightness brightness) {
  Color? getColor(String key) {
    final int? value = EzConfig.get(key);
    return (value == null) ? null : Color(value);
  }

  return (brightness == Brightness.dark)
      ? ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: getColor(darkPrimaryKey)!,
          primary: getColor(darkPrimaryKey),
          onPrimary: getColor(darkOnPrimaryKey),
          primaryContainer: getColor(darkPrimaryContainerKey),
          onPrimaryContainer: getColor(darkOnPrimaryContainerKey),
          primaryFixed: getColor(darkPrimaryFixedKey),
          primaryFixedDim: getColor(darkPrimaryFixedDimKey),
          onPrimaryFixed: getColor(darkOnPrimaryFixedKey),
          onPrimaryFixedVariant: getColor(darkOnPrimaryFixedVariantKey),
          secondary: getColor(darkSecondaryKey),
          onSecondary: getColor(darkOnSecondaryKey),
          secondaryContainer: getColor(darkSecondaryContainerKey),
          onSecondaryContainer: getColor(darkOnSecondaryContainerKey),
          secondaryFixed: getColor(darkSecondaryFixedKey),
          secondaryFixedDim: getColor(darkSecondaryFixedDimKey),
          onSecondaryFixed: getColor(darkOnSecondaryFixedKey),
          onSecondaryFixedVariant: getColor(darkOnSecondaryFixedVariantKey),
          tertiary: getColor(darkTertiaryKey),
          onTertiary: getColor(darkOnTertiaryKey),
          tertiaryContainer: getColor(darkTertiaryContainerKey),
          onTertiaryContainer: getColor(darkOnTertiaryContainerKey),
          tertiaryFixed: getColor(darkTertiaryFixedKey),
          tertiaryFixedDim: getColor(darkTertiaryFixedDimKey),
          onTertiaryFixed: getColor(darkOnTertiaryFixedKey),
          onTertiaryFixedVariant: getColor(darkOnTertiaryFixedVariantKey),
          error: getColor(darkErrorKey),
          onError: getColor(darkOnErrorKey),
          errorContainer: getColor(darkErrorContainerKey),
          onErrorContainer: getColor(darkOnErrorContainerKey),
          outline: getColor(darkOutlineKey),
          outlineVariant: getColor(darkOutlineVariantKey),
          surface: getColor(darkSurfaceKey),
          onSurface: getColor(darkOnSurfaceKey),
          surfaceDim: getColor(darkSurfaceDimKey),
          surfaceBright: getColor(darkSurfaceBrightKey),
          surfaceContainerLowest: getColor(darkSurfaceContainerLowestKey),
          surfaceContainerLow: getColor(darkSurfaceContainerLowKey),
          surfaceContainer: getColor(darkSurfaceContainerKey),
          surfaceContainerHigh: getColor(darkSurfaceContainerHighKey),
          surfaceContainerHighest: getColor(darkSurfaceContainerHighestKey),
          onSurfaceVariant: getColor(darkOnSurfaceVariantKey),
          inverseSurface: getColor(darkInverseSurfaceKey),
          onInverseSurface: getColor(darkOnInverseSurfaceKey),
          inversePrimary: getColor(darkInversePrimaryKey),
          shadow: getColor(darkShadowKey),
          scrim: getColor(darkScrimKey),
          surfaceTint: getColor(darkSurfaceTintKey),
        )
      : ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: getColor(lightPrimaryKey)!,
          primary: getColor(lightPrimaryKey),
          onPrimary: getColor(lightOnPrimaryKey),
          primaryContainer: getColor(lightPrimaryContainerKey),
          onPrimaryContainer: getColor(lightOnPrimaryContainerKey),
          primaryFixed: getColor(lightPrimaryFixedKey),
          primaryFixedDim: getColor(lightPrimaryFixedDimKey),
          onPrimaryFixed: getColor(lightOnPrimaryFixedKey),
          onPrimaryFixedVariant: getColor(lightOnPrimaryFixedVariantKey),
          secondary: getColor(lightSecondaryKey),
          onSecondary: getColor(lightOnSecondaryKey),
          secondaryContainer: getColor(lightSecondaryContainerKey),
          onSecondaryContainer: getColor(lightOnSecondaryContainerKey),
          secondaryFixed: getColor(lightSecondaryFixedKey),
          secondaryFixedDim: getColor(lightSecondaryFixedDimKey),
          onSecondaryFixed: getColor(lightOnSecondaryFixedKey),
          onSecondaryFixedVariant: getColor(lightOnSecondaryFixedVariantKey),
          tertiary: getColor(lightTertiaryKey),
          onTertiary: getColor(lightOnTertiaryKey),
          tertiaryContainer: getColor(lightTertiaryContainerKey),
          onTertiaryContainer: getColor(lightOnTertiaryContainerKey),
          tertiaryFixed: getColor(lightTertiaryFixedKey),
          tertiaryFixedDim: getColor(lightTertiaryFixedDimKey),
          onTertiaryFixed: getColor(lightOnTertiaryFixedKey),
          onTertiaryFixedVariant: getColor(lightOnTertiaryFixedVariantKey),
          error: getColor(lightErrorKey),
          onError: getColor(lightOnErrorKey),
          errorContainer: getColor(lightErrorContainerKey),
          onErrorContainer: getColor(lightOnErrorContainerKey),
          outline: getColor(lightOutlineKey),
          outlineVariant: getColor(lightOutlineVariantKey),
          surface: getColor(lightSurfaceKey),
          onSurface: getColor(lightOnSurfaceKey),
          surfaceDim: getColor(lightSurfaceDimKey),
          surfaceBright: getColor(lightSurfaceBrightKey),
          surfaceContainerLowest: getColor(lightSurfaceContainerLowestKey),
          surfaceContainerLow: getColor(lightSurfaceContainerLowKey),
          surfaceContainer: getColor(lightSurfaceContainerKey),
          surfaceContainerHigh: getColor(lightSurfaceContainerHighKey),
          surfaceContainerHighest: getColor(lightSurfaceContainerHighestKey),
          onSurfaceVariant: getColor(lightOnSurfaceVariantKey),
          inverseSurface: getColor(lightInverseSurfaceKey),
          onInverseSurface: getColor(lightOnInverseSurfaceKey),
          inversePrimary: getColor(lightInversePrimaryKey),
          shadow: getColor(lightShadowKey),
          scrim: getColor(lightScrimKey),
          surfaceTint: getColor(lightSurfaceTintKey),
        );
}

/// Store the passed [ColorScheme] in [EzConfig]
/// When [brightness] is null, both dark and light color schemes are updated
Future<void> loadColorScheme(ColorScheme colorScheme, Brightness? brightness) async {
  if (brightness == null || brightness == Brightness.dark) {
    // Reset
    await EzConfig.removeKeys(darkColorKeys.keys.toSet());

    // Rebuild
    await EzConfig.setInt(darkPrimaryKey, colorScheme.primary.toARGB32());
    await EzConfig.setInt(darkOnPrimaryKey, colorScheme.onPrimary.toARGB32());
    await EzConfig.setInt(darkPrimaryContainerKey, colorScheme.primaryContainer.toARGB32());
    await EzConfig.setInt(darkOnPrimaryContainerKey, colorScheme.onPrimaryContainer.toARGB32());
    await EzConfig.setInt(darkPrimaryFixedKey, colorScheme.primaryFixed.toARGB32());
    await EzConfig.setInt(darkPrimaryFixedDimKey, colorScheme.primaryFixedDim.toARGB32());
    await EzConfig.setInt(darkOnPrimaryFixedKey, colorScheme.onPrimaryFixed.toARGB32());
    await EzConfig.setInt(
        darkOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.toARGB32());
    await EzConfig.setInt(darkSecondaryKey, colorScheme.secondary.toARGB32());
    await EzConfig.setInt(darkOnSecondaryKey, colorScheme.onSecondary.toARGB32());
    await EzConfig.setInt(darkSecondaryContainerKey, colorScheme.secondaryContainer.toARGB32());
    await EzConfig.setInt(darkOnSecondaryContainerKey, colorScheme.onSecondaryContainer.toARGB32());
    await EzConfig.setInt(darkSecondaryFixedKey, colorScheme.secondaryFixed.toARGB32());
    await EzConfig.setInt(darkSecondaryFixedDimKey, colorScheme.secondaryFixedDim.toARGB32());
    await EzConfig.setInt(darkOnSecondaryFixedKey, colorScheme.onSecondaryFixed.toARGB32());
    await EzConfig.setInt(
        darkOnSecondaryFixedVariantKey, colorScheme.onSecondaryFixedVariant.toARGB32());
    await EzConfig.setInt(darkTertiaryKey, colorScheme.tertiary.toARGB32());
    await EzConfig.setInt(darkOnTertiaryKey, colorScheme.onTertiary.toARGB32());
    await EzConfig.setInt(darkTertiaryContainerKey, colorScheme.tertiaryContainer.toARGB32());
    await EzConfig.setInt(darkOnTertiaryContainerKey, colorScheme.onTertiaryContainer.toARGB32());
    await EzConfig.setInt(darkTertiaryFixedKey, colorScheme.tertiaryFixed.toARGB32());
    await EzConfig.setInt(darkTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.toARGB32());
    await EzConfig.setInt(darkOnTertiaryFixedKey, colorScheme.onTertiaryFixed.toARGB32());
    await EzConfig.setInt(
        darkOnTertiaryFixedVariantKey, colorScheme.onTertiaryFixedVariant.toARGB32());
    await EzConfig.setInt(darkErrorKey, colorScheme.error.toARGB32());
    await EzConfig.setInt(darkOnErrorKey, colorScheme.onError.toARGB32());
    await EzConfig.setInt(darkErrorContainerKey, colorScheme.errorContainer.toARGB32());
    await EzConfig.setInt(darkOnErrorContainerKey, colorScheme.onErrorContainer.toARGB32());
    await EzConfig.setInt(darkOutlineKey, colorScheme.outline.toARGB32());
    await EzConfig.setInt(darkOutlineVariantKey, colorScheme.outlineVariant.toARGB32());
    await EzConfig.setInt(darkSurfaceKey, colorScheme.surface.toARGB32());
    await EzConfig.setInt(darkOnSurfaceKey, colorScheme.onSurface.toARGB32());
    await EzConfig.setInt(darkSurfaceDimKey, colorScheme.surfaceDim.toARGB32());
    await EzConfig.setInt(darkSurfaceBrightKey, colorScheme.surfaceBright.toARGB32());
    await EzConfig.setInt(
        darkSurfaceContainerLowestKey, colorScheme.surfaceContainerLowest.toARGB32());
    await EzConfig.setInt(darkSurfaceContainerLowKey, colorScheme.surfaceContainerLow.toARGB32());
    await EzConfig.setInt(darkSurfaceContainerKey, colorScheme.surfaceContainer.toARGB32());
    await EzConfig.setInt(darkSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.toARGB32());
    await EzConfig.setInt(
        darkSurfaceContainerHighestKey, colorScheme.surfaceContainerHighest.toARGB32());
    await EzConfig.setInt(darkOnSurfaceVariantKey, colorScheme.onSurfaceVariant.toARGB32());
    await EzConfig.setInt(darkInverseSurfaceKey, colorScheme.inverseSurface.toARGB32());
    await EzConfig.setInt(darkOnInverseSurfaceKey, colorScheme.onInverseSurface.toARGB32());
    await EzConfig.setInt(darkInversePrimaryKey, colorScheme.inversePrimary.toARGB32());
    await EzConfig.setInt(darkShadowKey, colorScheme.shadow.toARGB32());
    await EzConfig.setInt(darkScrimKey, colorScheme.scrim.toARGB32());
    await EzConfig.setInt(darkSurfaceTintKey, colorScheme.surfaceTint.toARGB32());
  }

  if (brightness == null || brightness == Brightness.light) {
    // Reset
    await EzConfig.removeKeys(lightColorKeys.keys.toSet());

    // Rebuild
    await EzConfig.setInt(lightPrimaryKey, colorScheme.primary.toARGB32());
    await EzConfig.setInt(lightOnPrimaryKey, colorScheme.onPrimary.toARGB32());
    await EzConfig.setInt(lightPrimaryContainerKey, colorScheme.primaryContainer.toARGB32());
    await EzConfig.setInt(lightOnPrimaryContainerKey, colorScheme.onPrimaryContainer.toARGB32());
    await EzConfig.setInt(lightPrimaryFixedKey, colorScheme.primaryFixed.toARGB32());
    await EzConfig.setInt(lightPrimaryFixedDimKey, colorScheme.primaryFixedDim.toARGB32());
    await EzConfig.setInt(lightOnPrimaryFixedKey, colorScheme.onPrimaryFixed.toARGB32());
    await EzConfig.setInt(
        lightOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.toARGB32());
    await EzConfig.setInt(lightSecondaryKey, colorScheme.secondary.toARGB32());
    await EzConfig.setInt(lightOnSecondaryKey, colorScheme.onSecondary.toARGB32());
    await EzConfig.setInt(lightSecondaryContainerKey, colorScheme.secondaryContainer.toARGB32());
    await EzConfig.setInt(
        lightOnSecondaryContainerKey, colorScheme.onSecondaryContainer.toARGB32());
    await EzConfig.setInt(lightSecondaryFixedKey, colorScheme.secondaryFixed.toARGB32());
    await EzConfig.setInt(lightSecondaryFixedDimKey, colorScheme.secondaryFixedDim.toARGB32());
    await EzConfig.setInt(lightOnSecondaryFixedKey, colorScheme.onSecondaryFixed.toARGB32());
    await EzConfig.setInt(
        lightOnSecondaryFixedVariantKey, colorScheme.onSecondaryFixedVariant.toARGB32());
    await EzConfig.setInt(lightTertiaryKey, colorScheme.tertiary.toARGB32());
    await EzConfig.setInt(lightOnTertiaryKey, colorScheme.onTertiary.toARGB32());
    await EzConfig.setInt(lightTertiaryContainerKey, colorScheme.tertiaryContainer.toARGB32());
    await EzConfig.setInt(lightOnTertiaryContainerKey, colorScheme.onTertiaryContainer.toARGB32());
    await EzConfig.setInt(lightTertiaryFixedKey, colorScheme.tertiaryFixed.toARGB32());
    await EzConfig.setInt(lightTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.toARGB32());
    await EzConfig.setInt(lightOnTertiaryFixedKey, colorScheme.onTertiaryFixed.toARGB32());
    await EzConfig.setInt(
        lightOnTertiaryFixedVariantKey, colorScheme.onTertiaryFixedVariant.toARGB32());
    await EzConfig.setInt(lightErrorKey, colorScheme.error.toARGB32());
    await EzConfig.setInt(lightOnErrorKey, colorScheme.onError.toARGB32());
    await EzConfig.setInt(lightErrorContainerKey, colorScheme.errorContainer.toARGB32());
    await EzConfig.setInt(lightOnErrorContainerKey, colorScheme.onErrorContainer.toARGB32());
    await EzConfig.setInt(lightOutlineKey, colorScheme.outline.toARGB32());
    await EzConfig.setInt(lightOutlineVariantKey, colorScheme.outlineVariant.toARGB32());
    await EzConfig.setInt(lightSurfaceKey, colorScheme.surface.toARGB32());
    await EzConfig.setInt(lightOnSurfaceKey, colorScheme.onSurface.toARGB32());
    await EzConfig.setInt(lightSurfaceDimKey, colorScheme.surfaceDim.toARGB32());
    await EzConfig.setInt(lightSurfaceBrightKey, colorScheme.surfaceBright.toARGB32());
    await EzConfig.setInt(
        lightSurfaceContainerLowestKey, colorScheme.surfaceContainerLowest.toARGB32());
    await EzConfig.setInt(lightSurfaceContainerLowKey, colorScheme.surfaceContainerLow.toARGB32());
    await EzConfig.setInt(lightSurfaceContainerKey, colorScheme.surfaceContainer.toARGB32());
    await EzConfig.setInt(
        lightSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.toARGB32());
    await EzConfig.setInt(
        lightSurfaceContainerHighestKey, colorScheme.surfaceContainerHighest.toARGB32());
    await EzConfig.setInt(lightOnSurfaceVariantKey, colorScheme.onSurfaceVariant.toARGB32());
    await EzConfig.setInt(lightInverseSurfaceKey, colorScheme.inverseSurface.toARGB32());
    await EzConfig.setInt(lightOnInverseSurfaceKey, colorScheme.onInverseSurface.toARGB32());
    await EzConfig.setInt(lightInversePrimaryKey, colorScheme.inversePrimary.toARGB32());
    await EzConfig.setInt(lightShadowKey, colorScheme.shadow.toARGB32());
    await EzConfig.setInt(lightScrimKey, colorScheme.scrim.toARGB32());
    await EzConfig.setInt(lightSurfaceTintKey, colorScheme.surfaceTint.toARGB32());
  }
}

/// Generates a [ColorScheme] based on the image found at [path]
/// Then stores the values in [EzConfig]
/// When [brightness] is null, both dark and light color schemes are updated
Future<String> loadImageColorScheme(String path, Brightness? brightness) async {
  try {
    if (brightness == null) {
      await loadColorScheme(
        await ColorScheme.fromImageProvider(
          provider: ezImageProvider(path),
          brightness: Brightness.dark,
        ),
        Brightness.dark,
      );
      await loadColorScheme(
        await ColorScheme.fromImageProvider(
          provider: ezImageProvider(path),
          brightness: Brightness.light,
        ),
        Brightness.light,
      );
    } else {
      await loadColorScheme(
        await ColorScheme.fromImageProvider(
          provider: ezImageProvider(path),
          brightness: brightness,
        ),
        brightness,
      );
    }
  } catch (e) {
    return e.toString();
  }

  return success;
}

/// Get the human readable name of a [key]s color
String getColorName(String key) => switch (key) {
      // Backgrounds
      darkSurfaceKey || lightSurfaceKey => EzConfig.l10n.csSurface,
      darkSurfaceDimKey || lightSurfaceDimKey => EzConfig.l10n.csSurfaceDim,
      darkSurfaceContainerKey || lightSurfaceContainerKey => EzConfig.l10n.csSurfaceContainer,

      // Text
      darkOnSurfaceKey || lightOnSurfaceKey => EzConfig.l10n.csOnSurface,
      darkOutlineKey || lightOutlineKey => EzConfig.l10n.csOutline,

      // Primary
      darkPrimaryKey || lightPrimaryKey => EzConfig.l10n.csPrimary,
      darkPrimaryContainerKey || lightPrimaryContainerKey => EzConfig.l10n.csPrimaryContainer,

      // Secondary
      darkSecondaryKey || lightSecondaryKey => EzConfig.l10n.csSecondary,
      darkSecondaryContainerKey || lightSecondaryContainerKey => EzConfig.l10n.csSecondaryContainer,

      // Tertiary
      darkTertiaryKey || lightTertiaryKey => EzConfig.l10n.csTertiary,
      darkTertiaryContainerKey || lightTertiaryContainerKey => EzConfig.l10n.csTertiaryContainer,

      // Erriary
      darkErrorKey || lightErrorKey => EzConfig.l10n.csError,
      darkErrorContainerKey || lightErrorContainerKey => EzConfig.l10n.csErrorContainer,

      // Misc
      darkOutlineVariantKey || lightOutlineVariantKey => EzConfig.l10n.csOutlineVariant,
      darkShadowKey || lightShadowKey => EzConfig.l10n.csShadow,
      darkSurfaceTintKey || lightSurfaceTintKey => EzConfig.l10n.csSurfaceTint,
      darkScrimKey || lightScrimKey => EzConfig.l10n.csScrim,

      // Catch
      _ => ezCamelToTitle(key).replaceAll(RegExp('(Light|Dark) '), ''),
    };

/// Get the live [ColorScheme] value of [key]
Color getLiveColor(String key) => switch (key) {
      // Backgrounds
      darkSurfaceKey || lightSurfaceKey => EzConfig.colors.surface,
      darkSurfaceDimKey || lightSurfaceDimKey => EzConfig.colors.surfaceDim,
      darkSurfaceContainerKey || lightSurfaceContainerKey => EzConfig.colors.surfaceContainer,

      // Text
      darkOnSurfaceKey || lightOnSurfaceKey => EzConfig.colors.onSurface,
      darkOutlineKey || lightOutlineKey => EzConfig.colors.outline,

      // Primary
      darkPrimaryKey || lightPrimaryKey => EzConfig.colors.primary,
      darkPrimaryContainerKey || lightPrimaryContainerKey => EzConfig.colors.onPrimaryContainer,

      // Secondary
      darkSecondaryKey || lightSecondaryKey => EzConfig.colors.secondary,
      darkSecondaryContainerKey || lightSecondaryContainerKey => EzConfig.colors.secondaryContainer,

      // Tertiary
      darkTertiaryKey || lightTertiaryKey => EzConfig.colors.tertiary,
      darkTertiaryContainerKey || lightTertiaryContainerKey => EzConfig.colors.tertiaryContainer,

      // Erriary
      darkErrorKey || lightErrorKey => EzConfig.colors.error,
      darkErrorContainerKey || lightErrorContainerKey => EzConfig.colors.errorContainer,

      // Misc
      darkOutlineVariantKey || lightOutlineVariantKey => EzConfig.colors.outlineVariant,
      darkShadowKey || lightShadowKey => EzConfig.colors.shadow,
      darkSurfaceTintKey || lightSurfaceTintKey => EzConfig.colors.surfaceTint,
      darkScrimKey || lightScrimKey => EzConfig.colors.scrim,

      // Catch
      _ => Colors.transparent,
    };
