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
  Color? getColor(String key) {
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
