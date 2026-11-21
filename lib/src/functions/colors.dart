/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

/// Returns the guesstimated most readable text color (black/white) for [background]
Color ezTextColor(Color background) {
  final int lumR = (background.r * 255.0 * 0.299).round();
  final int lumG = (background.g * 255.0 * 0.587).round();
  final int lumB = (background.b * 255.0 * 0.114).round();

  return ((lumR + lumG + lumB) >= 150) ? Colors.black : Colors.white;
}

/// Given a color storage string, return the [Color] or [LinearGradient]'s first color
Color? ezFirstColor(String color) {
  final List<String> parts = color.split(colorSplit);
  final int? cv = int.tryParse(parts.length >= 4 ? parts[2] : color);
  return cv == null ? null : Color(cv);
}

/// Generate a [ColorScheme] based on [EzManager]
ColorScheme ezColorScheme(Brightness brightness) {
  Color? getFirstColor(String key) {
    final dynamic value = EzManager.get(key);

    return switch (value.runtimeType) {
      int => Color(value),
      String => ezFirstColor(value),
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

/// Store the passed [ColorScheme] in [EzManager]
/// When [brightness] is null, both dark and light color schemes are updated
Future<void> loadColorScheme(ColorScheme colorScheme, Brightness? brightness) async {
  if (brightness == null || brightness == Brightness.dark) {
    // Reset
    await EzManager.removeKeys(darkColorKeys.keys.toSet());

    // Rebuild
    await EzManager.setString(
      darkPrimaryKey,
      colorScheme.primary.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnPrimaryKey,
      colorScheme.onPrimary.toARGB32().toString(),
    );
    await EzManager.setString(
      darkPrimaryContainerKey,
      colorScheme.primaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnPrimaryContainerKey,
      colorScheme.onPrimaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      darkPrimaryFixedKey,
      colorScheme.primaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      darkPrimaryFixedDimKey,
      colorScheme.primaryFixedDim.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnPrimaryFixedKey,
      colorScheme.onPrimaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnPrimaryFixedVariantKey,
      colorScheme.onPrimaryFixedVariant.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSecondaryKey,
      colorScheme.secondary.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnSecondaryKey,
      colorScheme.onSecondary.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSecondaryContainerKey,
      colorScheme.secondaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnSecondaryContainerKey,
      colorScheme.onSecondaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSecondaryFixedKey,
      colorScheme.secondaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSecondaryFixedDimKey,
      colorScheme.secondaryFixedDim.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnSecondaryFixedKey,
      colorScheme.onSecondaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnSecondaryFixedVariantKey,
      colorScheme.onSecondaryFixedVariant.toARGB32().toString(),
    );
    await EzManager.setString(
      darkTertiaryKey,
      colorScheme.tertiary.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnTertiaryKey,
      colorScheme.onTertiary.toARGB32().toString(),
    );
    await EzManager.setString(
      darkTertiaryContainerKey,
      colorScheme.tertiaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnTertiaryContainerKey,
      colorScheme.onTertiaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      darkTertiaryFixedKey,
      colorScheme.tertiaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      darkTertiaryFixedDimKey,
      colorScheme.tertiaryFixedDim.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnTertiaryFixedKey,
      colorScheme.onTertiaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnTertiaryFixedVariantKey,
      colorScheme.onTertiaryFixedVariant.toARGB32().toString(),
    );
    await EzManager.setString(
      darkErrorKey,
      colorScheme.error.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnErrorKey,
      colorScheme.onError.toARGB32().toString(),
    );
    await EzManager.setString(
      darkErrorContainerKey,
      colorScheme.errorContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnErrorContainerKey,
      colorScheme.onErrorContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOutlineKey,
      colorScheme.outline.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOutlineVariantKey,
      colorScheme.outlineVariant.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSurfaceKey,
      colorScheme.surface.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnSurfaceKey,
      colorScheme.onSurface.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSurfaceDimKey,
      colorScheme.surfaceDim.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSurfaceBrightKey,
      colorScheme.surfaceBright.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSurfaceContainerLowestKey,
      colorScheme.surfaceContainerLowest.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSurfaceContainerLowKey,
      colorScheme.surfaceContainerLow.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSurfaceContainerKey,
      colorScheme.surfaceContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSurfaceContainerHighKey,
      colorScheme.surfaceContainerHigh.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSurfaceContainerHighestKey,
      colorScheme.surfaceContainerHighest.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnSurfaceVariantKey,
      colorScheme.onSurfaceVariant.toARGB32().toString(),
    );
    await EzManager.setString(
      darkInverseSurfaceKey,
      colorScheme.inverseSurface.toARGB32().toString(),
    );
    await EzManager.setString(
      darkOnInverseSurfaceKey,
      colorScheme.onInverseSurface.toARGB32().toString(),
    );
    await EzManager.setString(
      darkInversePrimaryKey,
      colorScheme.inversePrimary.toARGB32().toString(),
    );
    await EzManager.setString(
      darkShadowKey,
      colorScheme.shadow.toARGB32().toString(),
    );
    await EzManager.setString(
      darkScrimKey,
      colorScheme.scrim.toARGB32().toString(),
    );
    await EzManager.setString(
      darkSurfaceTintKey,
      colorScheme.surfaceTint.toARGB32().toString(),
    );
  }

  if (brightness == null || brightness == Brightness.light) {
    // Reset
    await EzManager.removeKeys(lightColorKeys.keys.toSet());

    // Rebuild
    await EzManager.setString(
      lightPrimaryKey,
      colorScheme.primary.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnPrimaryKey,
      colorScheme.onPrimary.toARGB32().toString(),
    );
    await EzManager.setString(
      lightPrimaryContainerKey,
      colorScheme.primaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnPrimaryContainerKey,
      colorScheme.onPrimaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      lightPrimaryFixedKey,
      colorScheme.primaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      lightPrimaryFixedDimKey,
      colorScheme.primaryFixedDim.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnPrimaryFixedKey,
      colorScheme.onPrimaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnPrimaryFixedVariantKey,
      colorScheme.onPrimaryFixedVariant.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSecondaryKey,
      colorScheme.secondary.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnSecondaryKey,
      colorScheme.onSecondary.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSecondaryContainerKey,
      colorScheme.secondaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnSecondaryContainerKey,
      colorScheme.onSecondaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSecondaryFixedKey,
      colorScheme.secondaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSecondaryFixedDimKey,
      colorScheme.secondaryFixedDim.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnSecondaryFixedKey,
      colorScheme.onSecondaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnSecondaryFixedVariantKey,
      colorScheme.onSecondaryFixedVariant.toARGB32().toString(),
    );
    await EzManager.setString(
      lightTertiaryKey,
      colorScheme.tertiary.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnTertiaryKey,
      colorScheme.onTertiary.toARGB32().toString(),
    );
    await EzManager.setString(
      lightTertiaryContainerKey,
      colorScheme.tertiaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnTertiaryContainerKey,
      colorScheme.onTertiaryContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      lightTertiaryFixedKey,
      colorScheme.tertiaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      lightTertiaryFixedDimKey,
      colorScheme.tertiaryFixedDim.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnTertiaryFixedKey,
      colorScheme.onTertiaryFixed.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnTertiaryFixedVariantKey,
      colorScheme.onTertiaryFixedVariant.toARGB32().toString(),
    );
    await EzManager.setString(
      lightErrorKey,
      colorScheme.error.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnErrorKey,
      colorScheme.onError.toARGB32().toString(),
    );
    await EzManager.setString(
      lightErrorContainerKey,
      colorScheme.errorContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnErrorContainerKey,
      colorScheme.onErrorContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOutlineKey,
      colorScheme.outline.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOutlineVariantKey,
      colorScheme.outlineVariant.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSurfaceKey,
      colorScheme.surface.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnSurfaceKey,
      colorScheme.onSurface.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSurfaceDimKey,
      colorScheme.surfaceDim.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSurfaceBrightKey,
      colorScheme.surfaceBright.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSurfaceContainerLowestKey,
      colorScheme.surfaceContainerLowest.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSurfaceContainerLowKey,
      colorScheme.surfaceContainerLow.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSurfaceContainerKey,
      colorScheme.surfaceContainer.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSurfaceContainerHighKey,
      colorScheme.surfaceContainerHigh.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSurfaceContainerHighestKey,
      colorScheme.surfaceContainerHighest.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnSurfaceVariantKey,
      colorScheme.onSurfaceVariant.toARGB32().toString(),
    );
    await EzManager.setString(
      lightInverseSurfaceKey,
      colorScheme.inverseSurface.toARGB32().toString(),
    );
    await EzManager.setString(
      lightOnInverseSurfaceKey,
      colorScheme.onInverseSurface.toARGB32().toString(),
    );
    await EzManager.setString(
      lightInversePrimaryKey,
      colorScheme.inversePrimary.toARGB32().toString(),
    );
    await EzManager.setString(
      lightShadowKey,
      colorScheme.shadow.toARGB32().toString(),
    );
    await EzManager.setString(
      lightScrimKey,
      colorScheme.scrim.toARGB32().toString(),
    );
    await EzManager.setString(
      lightSurfaceTintKey,
      colorScheme.surfaceTint.toARGB32().toString(),
    );
  }
}

/// Generates a [ColorScheme] based on the image found at [path],
/// Stores it in [EzManager], and loads it to [EzProvider]
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
