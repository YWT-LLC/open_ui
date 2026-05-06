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

/// Generate a [ColorScheme] based on values present in [EzConfig.prefs]
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
          primaryContainer: getColor(darkPrimaryContainerKey),
          secondary: getColor(darkSecondaryKey),
          secondaryContainer: getColor(darkSecondaryContainerKey),
          tertiary: getColor(darkTertiaryKey),
          tertiaryContainer: getColor(darkTertiaryContainerKey),
          error: getColor(darkErrorKey),
          errorContainer: getColor(darkErrorContainerKey),
          outline: getColor(darkOutlineKey),
          outlineVariant: getColor(darkOutlineVariantKey),
          surface: getColor(darkSurfaceKey),
          onSurface: getColor(darkOnSurfaceKey),
          surfaceDim: getColor(darkSurfaceDimKey),
          surfaceContainer: getColor(darkSurfaceContainerKey),
          shadow: getColor(darkShadowKey),
          surfaceTint: getColor(darkSurfaceTintKey),
        )
      : ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: getColor(lightPrimaryKey)!,
          primary: getColor(lightPrimaryKey),
          primaryContainer: getColor(lightPrimaryContainerKey),
          secondary: getColor(lightSecondaryKey),
          secondaryContainer: getColor(lightSecondaryContainerKey),
          tertiary: getColor(lightTertiaryKey),
          tertiaryContainer: getColor(lightTertiaryContainerKey),
          error: getColor(lightErrorKey),
          errorContainer: getColor(lightErrorContainerKey),
          outline: getColor(lightOutlineKey),
          outlineVariant: getColor(lightOutlineVariantKey),
          surface: getColor(lightSurfaceKey),
          onSurface: getColor(lightOnSurfaceKey),
          surfaceDim: getColor(lightSurfaceDimKey),
          surfaceContainer: getColor(lightSurfaceContainerKey),
          shadow: getColor(lightShadowKey),
          surfaceTint: getColor(lightSurfaceTintKey),
        );
}

/// Store the passed [ColorScheme] in [EzConfig]
/// When [brightness] is null, both dark and light color schemes are updated
Future<void> loadColorScheme(
  ColorScheme colorScheme,
  Brightness? brightness,
) async {
  if (brightness == null || brightness == Brightness.dark) {
    // Reset
    await EzConfig.removeKeys(darkColorKeys.keys.toSet());

    // Rebuild
    await EzConfig.setInt(darkPrimaryKey, colorScheme.primary.toARGB32());
    await EzConfig.setInt(darkPrimaryContainerKey, colorScheme.primaryContainer.toARGB32());

    await EzConfig.setInt(darkSecondaryKey, colorScheme.secondary.toARGB32());
    await EzConfig.setInt(darkSecondaryContainerKey, colorScheme.secondaryContainer.toARGB32());

    await EzConfig.setInt(darkTertiaryKey, colorScheme.tertiary.toARGB32());
    await EzConfig.setInt(darkTertiaryContainerKey, colorScheme.tertiaryContainer.toARGB32());

    await EzConfig.setInt(darkErrorKey, colorScheme.error.toARGB32());
    await EzConfig.setInt(darkErrorContainerKey, colorScheme.errorContainer.toARGB32());

    await EzConfig.setInt(darkOutlineKey, colorScheme.outline.toARGB32());
    await EzConfig.setInt(darkOutlineVariantKey, colorScheme.outlineVariant.toARGB32());

    await EzConfig.setInt(darkSurfaceKey, colorScheme.surface.toARGB32());
    await EzConfig.setInt(darkOnSurfaceKey, colorScheme.onSurface.toARGB32());
    await EzConfig.setInt(darkSurfaceDimKey, colorScheme.surfaceDim.toARGB32());
    await EzConfig.setInt(darkSurfaceContainerKey, colorScheme.surfaceContainer.toARGB32());

    await EzConfig.setInt(darkShadowKey, colorScheme.shadow.toARGB32());
    await EzConfig.setInt(darkSurfaceTintKey, colorScheme.surfaceTint.toARGB32());
  }

  if (brightness == null || brightness == Brightness.light) {
    // Reset
    await EzConfig.removeKeys(lightColorKeys.keys.toSet());

    // Rebuild
    await EzConfig.setInt(lightPrimaryKey, colorScheme.primary.toARGB32());

    await EzConfig.setInt(lightPrimaryContainerKey, colorScheme.primaryContainer.toARGB32());

    await EzConfig.setInt(lightSecondaryKey, colorScheme.secondary.toARGB32());
    await EzConfig.setInt(lightSecondaryContainerKey, colorScheme.secondaryContainer.toARGB32());

    await EzConfig.setInt(lightTertiaryKey, colorScheme.tertiary.toARGB32());
    await EzConfig.setInt(lightTertiaryContainerKey, colorScheme.tertiaryContainer.toARGB32());

    await EzConfig.setInt(lightErrorKey, colorScheme.error.toARGB32());
    await EzConfig.setInt(lightErrorContainerKey, colorScheme.errorContainer.toARGB32());

    await EzConfig.setInt(lightOutlineKey, colorScheme.outline.toARGB32());
    await EzConfig.setInt(lightOutlineVariantKey, colorScheme.outlineVariant.toARGB32());

    await EzConfig.setInt(lightSurfaceKey, colorScheme.surface.toARGB32());
    await EzConfig.setInt(lightOnSurfaceKey, colorScheme.onSurface.toARGB32());
    await EzConfig.setInt(lightSurfaceDimKey, colorScheme.surfaceDim.toARGB32());
    await EzConfig.setInt(lightSurfaceContainerKey, colorScheme.surfaceContainer.toARGB32());

    await EzConfig.setInt(lightShadowKey, colorScheme.shadow.toARGB32());
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
String getColorName(String key) {
  switch (key) {
    case lightPrimaryKey:
    case darkPrimaryKey:
      return EzConfig.l10n.csPrimary;
    case lightPrimaryContainerKey:
    case darkPrimaryContainerKey:
      return EzConfig.l10n.csPrimaryContainer;

    case lightSecondaryKey:
    case darkSecondaryKey:
      return EzConfig.l10n.csSecondary;
    case lightSecondaryContainerKey:
    case darkSecondaryContainerKey:
      return EzConfig.l10n.csSecondaryContainer;

    case lightTertiaryKey:
    case darkTertiaryKey:
      return EzConfig.l10n.csTertiary;
    case lightTertiaryContainerKey:
    case darkTertiaryContainerKey:
      return EzConfig.l10n.csTertiaryContainer;

    case lightErrorKey:
    case darkErrorKey:
      return EzConfig.l10n.csError;
    case lightErrorContainerKey:
    case darkErrorContainerKey:
      return EzConfig.l10n.csErrorContainer;

    case lightOutlineKey:
    case darkOutlineKey:
      return EzConfig.l10n.csOutline;
    case lightOutlineVariantKey:
    case darkOutlineVariantKey:
      return EzConfig.l10n.csOutlineVariant;

    case lightSurfaceKey:
    case darkSurfaceKey:
      return EzConfig.l10n.csSurface;
    case lightOnSurfaceKey:
    case darkOnSurfaceKey:
      return EzConfig.l10n.csOnSurface;
    case lightSurfaceDimKey:
    case darkSurfaceDimKey:
      return EzConfig.l10n.csSurfaceDim;
    case lightSurfaceContainerKey:
    case darkSurfaceContainerKey:
      return EzConfig.l10n.csSurfaceContainer;

    case lightShadowKey:
    case darkShadowKey:
      return EzConfig.l10n.csShadow;
    case lightSurfaceTintKey:
    case darkSurfaceTintKey:
      return EzConfig.l10n.csSurfaceTint;

    default:
      final String readable = ezCamelToTitle(key);
      return readable.replaceAll(RegExp('(Light|Dark) '), '');
  }
}

/// Get the live [ColorScheme] value of [key]
Color getLiveColor(String key) {
  switch (key) {
    case lightPrimaryKey:
    case darkPrimaryKey:
      return EzConfig.colors.primary;
    case lightPrimaryContainerKey:
    case darkPrimaryContainerKey:
      return EzConfig.colors.onPrimaryContainer;

    case lightSecondaryKey:
    case darkSecondaryKey:
      return EzConfig.colors.secondary;
    case lightSecondaryContainerKey:
    case darkSecondaryContainerKey:
      return EzConfig.colors.secondaryContainer;

    case lightTertiaryKey:
    case darkTertiaryKey:
      return EzConfig.colors.tertiary;
    case lightTertiaryContainerKey:
    case darkTertiaryContainerKey:
      return EzConfig.colors.tertiaryContainer;

    case lightErrorKey:
    case darkErrorKey:
      return EzConfig.colors.error;
    case lightErrorContainerKey:
    case darkErrorContainerKey:
      return EzConfig.colors.errorContainer;

    case lightOutlineKey:
    case darkOutlineKey:
      return EzConfig.colors.outline;
    case lightOutlineVariantKey:
    case darkOutlineVariantKey:
      return EzConfig.colors.outlineVariant;

    case lightSurfaceKey:
    case darkSurfaceKey:
      return EzConfig.colors.surface;
    case lightOnSurfaceKey:
    case darkOnSurfaceKey:
      return EzConfig.colors.onSurface;
    case lightSurfaceDimKey:
    case darkSurfaceDimKey:
      return EzConfig.colors.surfaceDim;
    case lightSurfaceContainerKey:
    case darkSurfaceContainerKey:
      return EzConfig.colors.surfaceContainer;

    case lightShadowKey:
    case darkShadowKey:
      return EzConfig.colors.shadow;
    case lightSurfaceTintKey:
    case darkSurfaceTintKey:
      return EzConfig.colors.surfaceTint;

    default:
      return Colors.transparent;
  }
}
