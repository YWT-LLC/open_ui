/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';

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
  Color? getFirstColor(String key) {
    final dynamic value = EzCM.get(key);

    return switch (value.runtimeType) {
      int => Color(value),
      String => Color(int.parse(value.contains(',') ? value.split(',')[2] : value)),
      _ => null,
    };
  }

  return (brightness == Brightness.dark)
      ? ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: getFirstColor(darkPrimaryKey)!,
          primary: getFirstColor(darkPrimaryKey),
          onPrimary: getFirstColor(darkOnPrimaryKey),
          primaryContainer: getFirstColor(darkPrimaryContainerKey),
          onPrimaryContainer: getFirstColor(darkOnPrimaryContainerKey),
          primaryFixed: getFirstColor(darkPrimaryFixedKey),
          primaryFixedDim: getFirstColor(darkPrimaryFixedDimKey),
          onPrimaryFixed: getFirstColor(darkOnPrimaryFixedKey),
          onPrimaryFixedVariant: getFirstColor(darkOnPrimaryFixedVariantKey),
          secondary: getFirstColor(darkSecondaryKey),
          onSecondary: getFirstColor(darkOnSecondaryKey),
          secondaryContainer: getFirstColor(darkSecondaryContainerKey),
          onSecondaryContainer: getFirstColor(darkOnSecondaryContainerKey),
          secondaryFixed: getFirstColor(darkSecondaryFixedKey),
          secondaryFixedDim: getFirstColor(darkSecondaryFixedDimKey),
          onSecondaryFixed: getFirstColor(darkOnSecondaryFixedKey),
          onSecondaryFixedVariant: getFirstColor(darkOnSecondaryFixedVariantKey),
          tertiary: getFirstColor(darkTertiaryKey),
          onTertiary: getFirstColor(darkOnTertiaryKey),
          tertiaryContainer: getFirstColor(darkTertiaryContainerKey),
          onTertiaryContainer: getFirstColor(darkOnTertiaryContainerKey),
          tertiaryFixed: getFirstColor(darkTertiaryFixedKey),
          tertiaryFixedDim: getFirstColor(darkTertiaryFixedDimKey),
          onTertiaryFixed: getFirstColor(darkOnTertiaryFixedKey),
          onTertiaryFixedVariant: getFirstColor(darkOnTertiaryFixedVariantKey),
          error: getFirstColor(darkErrorKey),
          onError: getFirstColor(darkOnErrorKey),
          errorContainer: getFirstColor(darkErrorContainerKey),
          onErrorContainer: getFirstColor(darkOnErrorContainerKey),
          outline: getFirstColor(darkOutlineKey),
          outlineVariant: getFirstColor(darkOutlineVariantKey),
          surface: getFirstColor(darkSurfaceKey),
          onSurface: getFirstColor(darkOnSurfaceKey),
          surfaceDim: getFirstColor(darkSurfaceDimKey),
          surfaceBright: getFirstColor(darkSurfaceBrightKey),
          surfaceContainerLowest: getFirstColor(darkSurfaceContainerLowestKey),
          surfaceContainerLow: getFirstColor(darkSurfaceContainerLowKey),
          surfaceContainer: getFirstColor(darkSurfaceContainerKey),
          surfaceContainerHigh: getFirstColor(darkSurfaceContainerHighKey),
          surfaceContainerHighest: getFirstColor(darkSurfaceContainerHighestKey),
          onSurfaceVariant: getFirstColor(darkOnSurfaceVariantKey),
          inverseSurface: getFirstColor(darkInverseSurfaceKey),
          onInverseSurface: getFirstColor(darkOnInverseSurfaceKey),
          inversePrimary: getFirstColor(darkInversePrimaryKey),
          shadow: getFirstColor(darkShadowKey),
          scrim: getFirstColor(darkScrimKey),
          surfaceTint: getFirstColor(darkSurfaceTintKey),
        )
      : ColorScheme.fromSeed(
          // brightness: Brightness.light,
          seedColor: getFirstColor(lightPrimaryKey)!,
          primary: getFirstColor(lightPrimaryKey),
          onPrimary: getFirstColor(lightOnPrimaryKey),
          primaryContainer: getFirstColor(lightPrimaryContainerKey),
          onPrimaryContainer: getFirstColor(lightOnPrimaryContainerKey),
          primaryFixed: getFirstColor(lightPrimaryFixedKey),
          primaryFixedDim: getFirstColor(lightPrimaryFixedDimKey),
          onPrimaryFixed: getFirstColor(lightOnPrimaryFixedKey),
          onPrimaryFixedVariant: getFirstColor(lightOnPrimaryFixedVariantKey),
          secondary: getFirstColor(lightSecondaryKey),
          onSecondary: getFirstColor(lightOnSecondaryKey),
          secondaryContainer: getFirstColor(lightSecondaryContainerKey),
          onSecondaryContainer: getFirstColor(lightOnSecondaryContainerKey),
          secondaryFixed: getFirstColor(lightSecondaryFixedKey),
          secondaryFixedDim: getFirstColor(lightSecondaryFixedDimKey),
          onSecondaryFixed: getFirstColor(lightOnSecondaryFixedKey),
          onSecondaryFixedVariant: getFirstColor(lightOnSecondaryFixedVariantKey),
          tertiary: getFirstColor(lightTertiaryKey),
          onTertiary: getFirstColor(lightOnTertiaryKey),
          tertiaryContainer: getFirstColor(lightTertiaryContainerKey),
          onTertiaryContainer: getFirstColor(lightOnTertiaryContainerKey),
          tertiaryFixed: getFirstColor(lightTertiaryFixedKey),
          tertiaryFixedDim: getFirstColor(lightTertiaryFixedDimKey),
          onTertiaryFixed: getFirstColor(lightOnTertiaryFixedKey),
          onTertiaryFixedVariant: getFirstColor(lightOnTertiaryFixedVariantKey),
          error: getFirstColor(lightErrorKey),
          onError: getFirstColor(lightOnErrorKey),
          errorContainer: getFirstColor(lightErrorContainerKey),
          onErrorContainer: getFirstColor(lightOnErrorContainerKey),
          outline: getFirstColor(lightOutlineKey),
          outlineVariant: getFirstColor(lightOutlineVariantKey),
          surface: getFirstColor(lightSurfaceKey),
          onSurface: getFirstColor(lightOnSurfaceKey),
          surfaceDim: getFirstColor(lightSurfaceDimKey),
          surfaceBright: getFirstColor(lightSurfaceBrightKey),
          surfaceContainerLowest: getFirstColor(lightSurfaceContainerLowestKey),
          surfaceContainerLow: getFirstColor(lightSurfaceContainerLowKey),
          surfaceContainer: getFirstColor(lightSurfaceContainerKey),
          surfaceContainerHigh: getFirstColor(lightSurfaceContainerHighKey),
          surfaceContainerHighest: getFirstColor(lightSurfaceContainerHighestKey),
          onSurfaceVariant: getFirstColor(lightOnSurfaceVariantKey),
          inverseSurface: getFirstColor(lightInverseSurfaceKey),
          onInverseSurface: getFirstColor(lightOnInverseSurfaceKey),
          inversePrimary: getFirstColor(lightInversePrimaryKey),
          shadow: getFirstColor(lightShadowKey),
          scrim: getFirstColor(lightScrimKey),
          surfaceTint: getFirstColor(lightSurfaceTintKey),
        );
}

/// Store the passed [ColorScheme] in [EzCM]
/// When [brightness] is null, both dark and light color schemes are updated
Future<void> loadColorScheme(ColorScheme colorScheme, Brightness? brightness) async {
  if (brightness == null || brightness == Brightness.dark) {
    // Reset
    await EzCM.removeKeys(darkColorKeys.keys.toSet());

    // Rebuild
    await EzCM.setString(
      darkPrimaryKey,
      colorScheme.primary.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnPrimaryKey,
      colorScheme.onPrimary.toARGB32().toString(),
    );
    await EzCM.setString(
      darkPrimaryContainerKey,
      colorScheme.primaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnPrimaryContainerKey,
      colorScheme.onPrimaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      darkPrimaryFixedKey,
      colorScheme.primaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      darkPrimaryFixedDimKey,
      colorScheme.primaryFixedDim.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnPrimaryFixedKey,
      colorScheme.onPrimaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnPrimaryFixedVariantKey,
      colorScheme.onPrimaryFixedVariant.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSecondaryKey,
      colorScheme.secondary.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnSecondaryKey,
      colorScheme.onSecondary.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSecondaryContainerKey,
      colorScheme.secondaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnSecondaryContainerKey,
      colorScheme.onSecondaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSecondaryFixedKey,
      colorScheme.secondaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSecondaryFixedDimKey,
      colorScheme.secondaryFixedDim.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnSecondaryFixedKey,
      colorScheme.onSecondaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnSecondaryFixedVariantKey,
      colorScheme.onSecondaryFixedVariant.toARGB32().toString(),
    );
    await EzCM.setString(
      darkTertiaryKey,
      colorScheme.tertiary.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnTertiaryKey,
      colorScheme.onTertiary.toARGB32().toString(),
    );
    await EzCM.setString(
      darkTertiaryContainerKey,
      colorScheme.tertiaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnTertiaryContainerKey,
      colorScheme.onTertiaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      darkTertiaryFixedKey,
      colorScheme.tertiaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      darkTertiaryFixedDimKey,
      colorScheme.tertiaryFixedDim.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnTertiaryFixedKey,
      colorScheme.onTertiaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnTertiaryFixedVariantKey,
      colorScheme.onTertiaryFixedVariant.toARGB32().toString(),
    );
    await EzCM.setString(
      darkErrorKey,
      colorScheme.error.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnErrorKey,
      colorScheme.onError.toARGB32().toString(),
    );
    await EzCM.setString(
      darkErrorContainerKey,
      colorScheme.errorContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnErrorContainerKey,
      colorScheme.onErrorContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOutlineKey,
      colorScheme.outline.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOutlineVariantKey,
      colorScheme.outlineVariant.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSurfaceKey,
      colorScheme.surface.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnSurfaceKey,
      colorScheme.onSurface.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSurfaceDimKey,
      colorScheme.surfaceDim.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSurfaceBrightKey,
      colorScheme.surfaceBright.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSurfaceContainerLowestKey,
      colorScheme.surfaceContainerLowest.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSurfaceContainerLowKey,
      colorScheme.surfaceContainerLow.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSurfaceContainerKey,
      colorScheme.surfaceContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSurfaceContainerHighKey,
      colorScheme.surfaceContainerHigh.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSurfaceContainerHighestKey,
      colorScheme.surfaceContainerHighest.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnSurfaceVariantKey,
      colorScheme.onSurfaceVariant.toARGB32().toString(),
    );
    await EzCM.setString(
      darkInverseSurfaceKey,
      colorScheme.inverseSurface.toARGB32().toString(),
    );
    await EzCM.setString(
      darkOnInverseSurfaceKey,
      colorScheme.onInverseSurface.toARGB32().toString(),
    );
    await EzCM.setString(
      darkInversePrimaryKey,
      colorScheme.inversePrimary.toARGB32().toString(),
    );
    await EzCM.setString(
      darkShadowKey,
      colorScheme.shadow.toARGB32().toString(),
    );
    await EzCM.setString(
      darkScrimKey,
      colorScheme.scrim.toARGB32().toString(),
    );
    await EzCM.setString(
      darkSurfaceTintKey,
      colorScheme.surfaceTint.toARGB32().toString(),
    );
  }

  if (brightness == null || brightness == Brightness.light) {
    // Reset
    await EzCM.removeKeys(lightColorKeys.keys.toSet());

    // Rebuild
    await EzCM.setString(
      lightPrimaryKey,
      colorScheme.primary.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnPrimaryKey,
      colorScheme.onPrimary.toARGB32().toString(),
    );
    await EzCM.setString(
      lightPrimaryContainerKey,
      colorScheme.primaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnPrimaryContainerKey,
      colorScheme.onPrimaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      lightPrimaryFixedKey,
      colorScheme.primaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      lightPrimaryFixedDimKey,
      colorScheme.primaryFixedDim.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnPrimaryFixedKey,
      colorScheme.onPrimaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnPrimaryFixedVariantKey,
      colorScheme.onPrimaryFixedVariant.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSecondaryKey,
      colorScheme.secondary.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnSecondaryKey,
      colorScheme.onSecondary.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSecondaryContainerKey,
      colorScheme.secondaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnSecondaryContainerKey,
      colorScheme.onSecondaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSecondaryFixedKey,
      colorScheme.secondaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSecondaryFixedDimKey,
      colorScheme.secondaryFixedDim.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnSecondaryFixedKey,
      colorScheme.onSecondaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnSecondaryFixedVariantKey,
      colorScheme.onSecondaryFixedVariant.toARGB32().toString(),
    );
    await EzCM.setString(
      lightTertiaryKey,
      colorScheme.tertiary.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnTertiaryKey,
      colorScheme.onTertiary.toARGB32().toString(),
    );
    await EzCM.setString(
      lightTertiaryContainerKey,
      colorScheme.tertiaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnTertiaryContainerKey,
      colorScheme.onTertiaryContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      lightTertiaryFixedKey,
      colorScheme.tertiaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      lightTertiaryFixedDimKey,
      colorScheme.tertiaryFixedDim.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnTertiaryFixedKey,
      colorScheme.onTertiaryFixed.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnTertiaryFixedVariantKey,
      colorScheme.onTertiaryFixedVariant.toARGB32().toString(),
    );
    await EzCM.setString(
      lightErrorKey,
      colorScheme.error.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnErrorKey,
      colorScheme.onError.toARGB32().toString(),
    );
    await EzCM.setString(
      lightErrorContainerKey,
      colorScheme.errorContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnErrorContainerKey,
      colorScheme.onErrorContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOutlineKey,
      colorScheme.outline.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOutlineVariantKey,
      colorScheme.outlineVariant.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSurfaceKey,
      colorScheme.surface.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnSurfaceKey,
      colorScheme.onSurface.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSurfaceDimKey,
      colorScheme.surfaceDim.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSurfaceBrightKey,
      colorScheme.surfaceBright.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSurfaceContainerLowestKey,
      colorScheme.surfaceContainerLowest.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSurfaceContainerLowKey,
      colorScheme.surfaceContainerLow.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSurfaceContainerKey,
      colorScheme.surfaceContainer.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSurfaceContainerHighKey,
      colorScheme.surfaceContainerHigh.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSurfaceContainerHighestKey,
      colorScheme.surfaceContainerHighest.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnSurfaceVariantKey,
      colorScheme.onSurfaceVariant.toARGB32().toString(),
    );
    await EzCM.setString(
      lightInverseSurfaceKey,
      colorScheme.inverseSurface.toARGB32().toString(),
    );
    await EzCM.setString(
      lightOnInverseSurfaceKey,
      colorScheme.onInverseSurface.toARGB32().toString(),
    );
    await EzCM.setString(
      lightInversePrimaryKey,
      colorScheme.inversePrimary.toARGB32().toString(),
    );
    await EzCM.setString(
      lightShadowKey,
      colorScheme.shadow.toARGB32().toString(),
    );
    await EzCM.setString(
      lightScrimKey,
      colorScheme.scrim.toARGB32().toString(),
    );
    await EzCM.setString(
      lightSurfaceTintKey,
      colorScheme.surfaceTint.toARGB32().toString(),
    );
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
String getColorName(OUILang l10n, String key) => switch (key) {
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
