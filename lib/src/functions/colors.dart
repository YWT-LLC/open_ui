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

/// Generate a [ColorScheme] based on [EzCM]
ColorScheme ezColorScheme(Brightness brightness) {
  Color? getColor(String key) {
    final int? value = EzCM.get(key);
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
          // brightness: Brightness.light,
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

/// Store the passed [ColorScheme] in [EzCM]
/// When [brightness] is null, both dark and light color schemes are updated
Future<void> loadColorScheme(ColorScheme colorScheme, Brightness? brightness) async {
  if (brightness == null || brightness == Brightness.dark) {
    // Reset
    await EzCM.removeKeys(darkColorKeys.keys.toSet());

    // Rebuild
    await EzCM.setInt(darkPrimaryKey, colorScheme.primary.toARGB32());
    await EzCM.setInt(darkOnPrimaryKey, colorScheme.onPrimary.toARGB32());
    await EzCM.setInt(darkPrimaryContainerKey, colorScheme.primaryContainer.toARGB32());
    await EzCM.setInt(darkOnPrimaryContainerKey, colorScheme.onPrimaryContainer.toARGB32());
    await EzCM.setInt(darkPrimaryFixedKey, colorScheme.primaryFixed.toARGB32());
    await EzCM.setInt(darkPrimaryFixedDimKey, colorScheme.primaryFixedDim.toARGB32());
    await EzCM.setInt(darkOnPrimaryFixedKey, colorScheme.onPrimaryFixed.toARGB32());
    await EzCM.setInt(darkOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.toARGB32());
    await EzCM.setInt(darkSecondaryKey, colorScheme.secondary.toARGB32());
    await EzCM.setInt(darkOnSecondaryKey, colorScheme.onSecondary.toARGB32());
    await EzCM.setInt(darkSecondaryContainerKey, colorScheme.secondaryContainer.toARGB32());
    await EzCM.setInt(darkOnSecondaryContainerKey, colorScheme.onSecondaryContainer.toARGB32());
    await EzCM.setInt(darkSecondaryFixedKey, colorScheme.secondaryFixed.toARGB32());
    await EzCM.setInt(darkSecondaryFixedDimKey, colorScheme.secondaryFixedDim.toARGB32());
    await EzCM.setInt(darkOnSecondaryFixedKey, colorScheme.onSecondaryFixed.toARGB32());
    await EzCM.setInt(
        darkOnSecondaryFixedVariantKey, colorScheme.onSecondaryFixedVariant.toARGB32());
    await EzCM.setInt(darkTertiaryKey, colorScheme.tertiary.toARGB32());
    await EzCM.setInt(darkOnTertiaryKey, colorScheme.onTertiary.toARGB32());
    await EzCM.setInt(darkTertiaryContainerKey, colorScheme.tertiaryContainer.toARGB32());
    await EzCM.setInt(darkOnTertiaryContainerKey, colorScheme.onTertiaryContainer.toARGB32());
    await EzCM.setInt(darkTertiaryFixedKey, colorScheme.tertiaryFixed.toARGB32());
    await EzCM.setInt(darkTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.toARGB32());
    await EzCM.setInt(darkOnTertiaryFixedKey, colorScheme.onTertiaryFixed.toARGB32());
    await EzCM.setInt(darkOnTertiaryFixedVariantKey, colorScheme.onTertiaryFixedVariant.toARGB32());
    await EzCM.setInt(darkErrorKey, colorScheme.error.toARGB32());
    await EzCM.setInt(darkOnErrorKey, colorScheme.onError.toARGB32());
    await EzCM.setInt(darkErrorContainerKey, colorScheme.errorContainer.toARGB32());
    await EzCM.setInt(darkOnErrorContainerKey, colorScheme.onErrorContainer.toARGB32());
    await EzCM.setInt(darkOutlineKey, colorScheme.outline.toARGB32());
    await EzCM.setInt(darkOutlineVariantKey, colorScheme.outlineVariant.toARGB32());
    await EzCM.setInt(darkSurfaceKey, colorScheme.surface.toARGB32());
    await EzCM.setInt(darkOnSurfaceKey, colorScheme.onSurface.toARGB32());
    await EzCM.setInt(darkSurfaceDimKey, colorScheme.surfaceDim.toARGB32());
    await EzCM.setInt(darkSurfaceBrightKey, colorScheme.surfaceBright.toARGB32());
    await EzCM.setInt(darkSurfaceContainerLowestKey, colorScheme.surfaceContainerLowest.toARGB32());
    await EzCM.setInt(darkSurfaceContainerLowKey, colorScheme.surfaceContainerLow.toARGB32());
    await EzCM.setInt(darkSurfaceContainerKey, colorScheme.surfaceContainer.toARGB32());
    await EzCM.setInt(darkSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.toARGB32());
    await EzCM.setInt(
        darkSurfaceContainerHighestKey, colorScheme.surfaceContainerHighest.toARGB32());
    await EzCM.setInt(darkOnSurfaceVariantKey, colorScheme.onSurfaceVariant.toARGB32());
    await EzCM.setInt(darkInverseSurfaceKey, colorScheme.inverseSurface.toARGB32());
    await EzCM.setInt(darkOnInverseSurfaceKey, colorScheme.onInverseSurface.toARGB32());
    await EzCM.setInt(darkInversePrimaryKey, colorScheme.inversePrimary.toARGB32());
    await EzCM.setInt(darkShadowKey, colorScheme.shadow.toARGB32());
    await EzCM.setInt(darkScrimKey, colorScheme.scrim.toARGB32());
    await EzCM.setInt(darkSurfaceTintKey, colorScheme.surfaceTint.toARGB32());
  }

  if (brightness == null || brightness == Brightness.light) {
    // Reset
    await EzCM.removeKeys(lightColorKeys.keys.toSet());

    // Rebuild
    await EzCM.setInt(lightPrimaryKey, colorScheme.primary.toARGB32());
    await EzCM.setInt(lightOnPrimaryKey, colorScheme.onPrimary.toARGB32());
    await EzCM.setInt(lightPrimaryContainerKey, colorScheme.primaryContainer.toARGB32());
    await EzCM.setInt(lightOnPrimaryContainerKey, colorScheme.onPrimaryContainer.toARGB32());
    await EzCM.setInt(lightPrimaryFixedKey, colorScheme.primaryFixed.toARGB32());
    await EzCM.setInt(lightPrimaryFixedDimKey, colorScheme.primaryFixedDim.toARGB32());
    await EzCM.setInt(lightOnPrimaryFixedKey, colorScheme.onPrimaryFixed.toARGB32());
    await EzCM.setInt(lightOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.toARGB32());
    await EzCM.setInt(lightSecondaryKey, colorScheme.secondary.toARGB32());
    await EzCM.setInt(lightOnSecondaryKey, colorScheme.onSecondary.toARGB32());
    await EzCM.setInt(lightSecondaryContainerKey, colorScheme.secondaryContainer.toARGB32());
    await EzCM.setInt(lightOnSecondaryContainerKey, colorScheme.onSecondaryContainer.toARGB32());
    await EzCM.setInt(lightSecondaryFixedKey, colorScheme.secondaryFixed.toARGB32());
    await EzCM.setInt(lightSecondaryFixedDimKey, colorScheme.secondaryFixedDim.toARGB32());
    await EzCM.setInt(lightOnSecondaryFixedKey, colorScheme.onSecondaryFixed.toARGB32());
    await EzCM.setInt(
        lightOnSecondaryFixedVariantKey, colorScheme.onSecondaryFixedVariant.toARGB32());
    await EzCM.setInt(lightTertiaryKey, colorScheme.tertiary.toARGB32());
    await EzCM.setInt(lightOnTertiaryKey, colorScheme.onTertiary.toARGB32());
    await EzCM.setInt(lightTertiaryContainerKey, colorScheme.tertiaryContainer.toARGB32());
    await EzCM.setInt(lightOnTertiaryContainerKey, colorScheme.onTertiaryContainer.toARGB32());
    await EzCM.setInt(lightTertiaryFixedKey, colorScheme.tertiaryFixed.toARGB32());
    await EzCM.setInt(lightTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.toARGB32());
    await EzCM.setInt(lightOnTertiaryFixedKey, colorScheme.onTertiaryFixed.toARGB32());
    await EzCM.setInt(
        lightOnTertiaryFixedVariantKey, colorScheme.onTertiaryFixedVariant.toARGB32());
    await EzCM.setInt(lightErrorKey, colorScheme.error.toARGB32());
    await EzCM.setInt(lightOnErrorKey, colorScheme.onError.toARGB32());
    await EzCM.setInt(lightErrorContainerKey, colorScheme.errorContainer.toARGB32());
    await EzCM.setInt(lightOnErrorContainerKey, colorScheme.onErrorContainer.toARGB32());
    await EzCM.setInt(lightOutlineKey, colorScheme.outline.toARGB32());
    await EzCM.setInt(lightOutlineVariantKey, colorScheme.outlineVariant.toARGB32());
    await EzCM.setInt(lightSurfaceKey, colorScheme.surface.toARGB32());
    await EzCM.setInt(lightOnSurfaceKey, colorScheme.onSurface.toARGB32());
    await EzCM.setInt(lightSurfaceDimKey, colorScheme.surfaceDim.toARGB32());
    await EzCM.setInt(lightSurfaceBrightKey, colorScheme.surfaceBright.toARGB32());
    await EzCM.setInt(
        lightSurfaceContainerLowestKey, colorScheme.surfaceContainerLowest.toARGB32());
    await EzCM.setInt(lightSurfaceContainerLowKey, colorScheme.surfaceContainerLow.toARGB32());
    await EzCM.setInt(lightSurfaceContainerKey, colorScheme.surfaceContainer.toARGB32());
    await EzCM.setInt(lightSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.toARGB32());
    await EzCM.setInt(
        lightSurfaceContainerHighestKey, colorScheme.surfaceContainerHighest.toARGB32());
    await EzCM.setInt(lightOnSurfaceVariantKey, colorScheme.onSurfaceVariant.toARGB32());
    await EzCM.setInt(lightInverseSurfaceKey, colorScheme.inverseSurface.toARGB32());
    await EzCM.setInt(lightOnInverseSurfaceKey, colorScheme.onInverseSurface.toARGB32());
    await EzCM.setInt(lightInversePrimaryKey, colorScheme.inversePrimary.toARGB32());
    await EzCM.setInt(lightShadowKey, colorScheme.shadow.toARGB32());
    await EzCM.setInt(lightScrimKey, colorScheme.scrim.toARGB32());
    await EzCM.setInt(lightSurfaceTintKey, colorScheme.surfaceTint.toARGB32());
  }
}

/// Generates a [ColorScheme] based on the image found at [path],
/// Stores it in [EzCM], and loads it to [EzCP]
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
          // brightness: Brightness.light,
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
String getColorName(EFUILang l10n, String key) => switch (key) {
      // Backgrounds
      darkSurfaceKey || lightSurfaceKey => l10n.csSurface,
      darkSurfaceDimKey || lightSurfaceDimKey => l10n.csSurfaceDim,
      darkSurfaceContainerKey || lightSurfaceContainerKey => l10n.csSurfaceContainer,

      // Text
      darkOnSurfaceKey || lightOnSurfaceKey => l10n.csOnSurface,
      darkOutlineKey || lightOutlineKey => l10n.csOutline,

      // Primary
      darkPrimaryKey || lightPrimaryKey => l10n.csPrimary,
      darkPrimaryContainerKey || lightPrimaryContainerKey => l10n.csPrimaryContainer,

      // Secondary
      darkSecondaryKey || lightSecondaryKey => l10n.csSecondary,
      darkSecondaryContainerKey || lightSecondaryContainerKey => l10n.csSecondaryContainer,

      // Tertiary
      darkTertiaryKey || lightTertiaryKey => l10n.csTertiary,
      darkTertiaryContainerKey || lightTertiaryContainerKey => l10n.csTertiaryContainer,

      // Erriary
      darkErrorKey || lightErrorKey => l10n.csError,
      darkErrorContainerKey || lightErrorContainerKey => l10n.csErrorContainer,

      // Misc
      darkOutlineVariantKey || lightOutlineVariantKey => l10n.csOutlineVariant,
      darkShadowKey || lightShadowKey => l10n.csShadow,
      darkSurfaceTintKey || lightSurfaceTintKey => l10n.csSurfaceTint,
      darkScrimKey || lightScrimKey => l10n.csScrim,

      // Catch
      _ => ezCamelToTitle(key).replaceAll(RegExp('(Light|Dark) '), ''),
    };

/// Get the live [ColorScheme] value of [key]
Color getLiveColor(ColorScheme colors, String key) => switch (key) {
      // Backgrounds
      darkSurfaceKey || lightSurfaceKey => colors.surface,
      darkSurfaceDimKey || lightSurfaceDimKey => colors.surfaceDim,
      darkSurfaceContainerKey || lightSurfaceContainerKey => colors.surfaceContainer,

      // Text
      darkOnSurfaceKey || lightOnSurfaceKey => colors.onSurface,
      darkOutlineKey || lightOutlineKey => colors.outline,

      // Primary
      darkPrimaryKey || lightPrimaryKey => colors.primary,
      darkPrimaryContainerKey || lightPrimaryContainerKey => colors.onPrimaryContainer,

      // Secondary
      darkSecondaryKey || lightSecondaryKey => colors.secondary,
      darkSecondaryContainerKey || lightSecondaryContainerKey => colors.secondaryContainer,

      // Tertiary
      darkTertiaryKey || lightTertiaryKey => colors.tertiary,
      darkTertiaryContainerKey || lightTertiaryContainerKey => colors.tertiaryContainer,

      // Erriary
      darkErrorKey || lightErrorKey => colors.error,
      darkErrorContainerKey || lightErrorContainerKey => colors.errorContainer,

      // Misc
      darkOutlineVariantKey || lightOutlineVariantKey => colors.outlineVariant,
      darkShadowKey || lightShadowKey => colors.shadow,
      darkSurfaceTintKey || lightSurfaceTintKey => colors.surfaceTint,
      darkScrimKey || lightScrimKey => colors.scrim,

      // Catch
      _ => Colors.transparent,
    };
