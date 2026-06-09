/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_saver/file_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//* Config constructor(s) *//

class EzCM {
  /// Name of the app
  final String _appName;

  /// Android package path (optional)
  final String? _androidPackage;

  /// [AssetImage] paths for the app
  final Set<String> _assetPaths;

  /// [DeviceOrientation]s the app uses
  final List<DeviceOrientation> _orientations;

  /// [TargetPlatform] the app is running on
  final TargetPlatform _platform;

  /// Whether the [TargetPlatform] is a mobile platform
  final bool _onMobile;

  /// Fallback [Locale] for unsupported [Locale]s
  /// [english] or [americanEnglish] is recommended
  final Locale _localeFallback;

  /// Fallback [EFUILang] for unsupported [Locale]s
  /// [EFUILang.delegate] load the [_localeFallback]
  /// Constructors cannot be async, so the load must be awaited externally/beforehand
  final EFUILang _l10nFallback;

  /// [SharedPreferencesAsync] instance
  final SharedPreferencesAsync _preferences;

  /// Optional [FlutterSecureStorage] instance
  final FlutterSecureStorage? _securePreferences;

  /// Default config
  final Map<String, dynamic> _defaults;

  /// Optional protected keys
  final Set<String> _neverReset;

  /// Live values in use
  final Map<String, dynamic> _prefs;

  /// [EzCM] key : value runtime [Type] map
  final Map<String, Type> _typeMap;

  /// Private instance
  static EzCM? _instance;

  /// EzConfig Manager
  /// Private/internal constructor
  EzCM._({
    // External (factory parameters)
    required String appName,
    required String? androidPackage,
    required Set<String> assetPaths,
    required List<DeviceOrientation> orientations,
    required TargetPlatform platform,
    required bool onMobile,
    required Locale localeFallback,
    required EFUILang l10nFallback,
    required SharedPreferencesAsync preferences,
    FlutterSecureStorage? securePreferences,
    required Map<String, dynamic> defaults,
    Set<String>? neverReset,

    // Internal (built by factory)
    required Map<String, dynamic> prefs,
    required Map<String, Type> typeMap,
  })  : _appName = appName,
        _androidPackage = androidPackage,
        _assetPaths = assetPaths,
        _orientations = orientations,
        _platform = platform,
        _onMobile = onMobile,
        _localeFallback = localeFallback,
        _l10nFallback = l10nFallback,
        _preferences = preferences,
        _securePreferences = securePreferences,
        _defaults = defaults,
        _neverReset = neverReset ?? const <String>{appLocaleKey},
        _prefs = prefs,
        _typeMap = typeMap;

  /// EzConfig Manager
  /// [appName] => Name of the app
  /// [androidPackage] => Android package path (optional)
  /// [assetPaths] => [AssetImage] paths for this app
  /// [orientations] => [DeviceOrientation] the app supports
  /// [localeFallback] => Fallback [Locale] for unsupported [Locale]s
  /// [l10nFallback] => Fallback [EFUILang] for unsupported [Locale]s
  /// [preferences] => [SharedPreferencesAsync] instance
  /// [securePreferences] => Optional [FlutterSecureStorage] instance
  /// [defaults] => Default config; brand colors, text styles, design settings, etc.
  /// [neverReset] => Optional protected keys
  factory EzCM.init({
    required String appName,
    required String? androidPackage,
    required Set<String> assetPaths,
    required List<DeviceOrientation> orientations,
    required Locale localeFallback,
    required EFUILang l10nFallback,
    required SharedPreferencesWithCache preferences,
    FlutterSecureStorage? securePreferences,
    required Map<String, dynamic> defaults,
    Set<String>? neverReset,
  }) {
    if (_instance == null) {
      // Get the value type for each key //

      // Start with the known EzConfigverse
      final Map<String, Type> typeMap = Map<String, Type>.from(allEZConfigKeys);

      // Include defaults
      final Set<String> uniqueDefaults = defaults.keys.toSet().difference(typeMap.keys.toSet());

      for (final String key in uniqueDefaults) {
        typeMap[key] = defaults[key].runtimeType;
      }

      // Build this.prefs //

      // Start with the defaults
      final Map<String, dynamic> prefs = Map<String, dynamic>.from(defaults);

      // Find the keys that users have overwritten
      final Set<String> overwritten = preferences.keys.intersection(typeMap.keys.toSet());

      // Get the updated values
      for (final String key in overwritten) {
        final Type? valueType = typeMap[key];
        dynamic userPref;

        switch (valueType) {
          case const (bool):
            userPref = preferences.getBool(key);
            break;

          case const (int):
            userPref = preferences.getInt(key);
            break;

          case const (double):
            userPref = preferences.getDouble(key);
            break;

          case const (String):
            userPref = preferences.getString(key);
            break;

          case const (List<String>):
            userPref = preferences.getStringList(key);
            break;

          default:
            ezLog('''Key [$key] has unsupported Type [$valueType]
Must be one of [int, bool, double, String, List<String>]''');
            break;
        }

        if (userPref != null) prefs[key] = userPref;
      }

      // Build the EzCM instance //

      _instance = EzCM._(
        appName: appName,
        androidPackage: androidPackage,
        assetPaths: <String>{...assetPaths, ...efuiAssetPaths},
        orientations: orientations,
        platform: getBasePlatform(),
        onMobile: isMobile(),
        localeFallback: localeFallback,
        l10nFallback: l10nFallback,
        preferences: SharedPreferencesAsync(),
        securePreferences: securePreferences,
        defaults: defaults,
        neverReset: neverReset,
        prefs: prefs,
        typeMap: typeMap,
      );
    }

    return _instance!;
  }

  //* Config getters *//

  // Core //

  /// Name of the app
  static String get appName => _instance!._appName;

  /// Android package path (when relevant)
  static String? get androidPackage => _instance!._androidPackage;

  /// [DeviceOrientation]s the app uses
  static List<DeviceOrientation> get orientations => _instance!._orientations;

  /// [TargetPlatform] the app is running on
  static TargetPlatform get platform => _instance!._platform;

  /// Whether the [TargetPlatform] is a mobile platform
  static bool get onMobile => _instance!._onMobile;

  /// Fallback [Locale] for unsupported [Locale]s
  static Locale get localeFallback => _instance!._localeFallback;

  /// Fallback [EFUILang] for unsupported [Locale]s
  static EFUILang get l10nFallback => _instance!._l10nFallback;

  /// Get the [key]s (nullable) [bool] value
  /// Uses the stored values from [SharedPreferencesAsync]
  static Future<bool?> getBool(String key) => _instance!._preferences.getBool(key);

  /// Get the [key]s (nullable) [int] value
  /// Uses the stored values from [SharedPreferencesAsync]
  static Future<int?> getInt(String key) => _instance!._preferences.getInt(key);

  /// Get the [key]s (nullable) [double] value
  /// Uses the stored values from [SharedPreferencesAsync]
  static Future<double?> getDouble(String key) => _instance!._preferences.getDouble(key);

  /// Get the [key]s (nullable) [String] value
  /// Uses the stored values from [SharedPreferencesAsync]
  static Future<String?> getString(String key) => _instance!._preferences.getString(key);

  /// Get the [key]s (nullable) [List] value
  /// Uses the stored values from [SharedPreferencesAsync]
  static Future<List<String>?> getStringList(String key) =>
      _instance!._preferences.getStringList(key);

  /// Get the [key]s default (nullable) value
  static dynamic getDefault(String key) => _instance!._defaults[key];

  /// [FlutterSecureStorage] only stores Strings
  /// No null or error checking, assumes the proper instance was provided in [EzCM.init]
  /// Returns empty [String] on failure (not null)
  static Future<String> secGet(String key) async =>
      await _instance!._securePreferences!.read(key: key) ?? Future<String>.value('');

  /// Get the [key]s current value
  /// bool, int, double, String, String List, or null
  static dynamic get(String key) => _instance!._prefs[key] ?? getDefault(key);

  /// Wether the [path] leads to an [AssetImage]
  static bool isPathAsset(String path) => _instance!._assetPaths.contains(path);

  /// Wether the [key] points to an [AssetImage] path
  static bool isKeyAsset(String key) => _instance!._assetPaths.contains(_instance!._prefs[key]);

  //* Setters *//

  /// Set the [key] to [value] with type [bool]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setBool(String key, bool value) async {
    try {
      await _instance!._preferences.setBool(key, value);
      _instance!._prefs[key] = value;
      return true;
    } catch (e) {
      ezLog('Error setting bool [$key]...\n$e');
      return false;
    }
  }

  /// Set the [key] to [value] with type [int]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setInt(String key, int value) async {
    try {
      await _instance!._preferences.setInt(key, value);
      _instance!._prefs[key] = value;
      return true;
    } catch (e) {
      ezLog('Error setting int [$key]...\n$e');
      return false;
    }
  }

  /// Set the [key] to [value] with type [double]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setDouble(String key, double value) async {
    try {
      await _instance!._preferences.setDouble(key, value);
      _instance!._prefs[key] = value;
      return true;
    } catch (e) {
      ezLog('Error setting double [$key]...\n$e');
      return false;
    }
  }

  /// Set the [key] to [value] with type [String]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setString(String key, String value) async {
    try {
      await _instance!._preferences.setString(key, value);
      _instance!._prefs[key] = value;
      return true;
    } catch (e) {
      ezLog('Error setting String [$key]...\n$e');
      return false;
    }
  }

  /// [setString] but with [FlutterSecureStorage]
  /// ([FlutterSecureStorage] can only [setString])
  static Future<bool> secSet(String key, String value) async {
    if (_instance!._securePreferences == null) {
      ezLog('Attempted to secSet without a secure storage instance');
      return false;
    }

    try {
      await _instance!._securePreferences!.write(key: key, value: value);
      return true;
    } catch (e) {
      ezLog('Error in secSet: [$key]...\n$e');
      return false;
    }
  }

  /// Set the [key] to [value] with type [List]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setStringList(String key, List<String> value) async {
    try {
      await _instance!._preferences.setStringList(key, value);
      _instance!._prefs[key] = value;
      return true;
    } catch (e) {
      ezLog('Error setting String List [$key]...\n$e');
      return false;
    }
  }

  /// Save the current [EzCM] to local storage
  static Future<void> saveConfig(
    EzCP config, {
    required BuildContext context,
    Set<String>? skip,
  }) async {
    final Map<String, dynamic> toSave = Map<String, dynamic>.from(_instance!._prefs);
    if (skip != null) {
      for (final String key in skip) {
        toSave.remove(key);
      }
    }

    try {
      await FileSaver.instance.saveFile(
        name: '${ezTitleToSnake(appName)}_settings.json',
        bytes: utf8.encode(jsonEncode(toSave)),
        mimeType: MimeType.json,
      );
    } catch (e) {
      (context.mounted)
          ? await ezLogAlert(config, context: context, message: e.toString())
          : ezLog(e.toString());
      return;
    }

    if (context.mounted) {
      ezSnackBar(config, context: context, message: config.ezL10n.ssConfigSaved(archivePath()));
    }
  }

  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<void> loadConfig(
    EzCP config, {
    required Map<String, dynamic> toLoad,
    Set<String>? filter,
  }) async {
    final Set<MapEntry<String, dynamic>> entries = toLoad.entries.toSet();
    if (filter != null) entries.removeAll(filter);

    for (final MapEntry<String, dynamic> entry in entries) {
      // Check type
      final dynamic expectedType = _instance!._typeMap[entry.key];
      if (expectedType == null) {
        ezLog('Skipping unknown key [${entry.key}]');
        continue;
      }
      if (expectedType != entry.value.runtimeType) {
        ezLog(
          'Skipping key [${entry.key}], mismatched types: [$expectedType != ${entry.value.runtimeType}]',
        );
        continue;
      }

      // Load value
      switch (entry.value.runtimeType) {
        case const (bool):
          await setBool(entry.key, entry.value);
          break;
        case const (int):
          await setInt(entry.key, entry.value);
          break;
        case const (double):
          await setDouble(entry.key, entry.value);
          break;
        case const (String):
          await setString(entry.key, entry.value);
          break;
        case const (List<String>):
          await setStringList(entry.key, entry.value);
          break;
      }
    }
  }

  /// Create a pseudo-random config that follows the default vibe
  /// i.e. a triadic [ColorScheme] that should be legible
  static Future<void> randomize(bool isDark) async {
    final Random random = Random();

    double getScalar() => (random.nextDouble() * 1.5) + 0.5;

    // Update global settings //

    // Lefty
    await setBool(isLeftyKey, random.nextBool());

    // Leave ThemeMode as-is, don't wanna light blast peeps at night
    // Locale too, don't want them to get lost

    // Define (shared) seed ColorScheme //

    // Define random seed
    final Color primary = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
    final Color onPrimary = getTextColor(primary);

    // Build a triadic combo from the seed
    final HSVColor primaryHSV = HSVColor.fromColor(primary);
    final double secondaryHue = (primaryHSV.hue + 120) % 360;
    final double tertiaryHue = (primaryHSV.hue + 240) % 360;

    final Color secondary = HSVColor.fromAHSV(
      1.0,
      secondaryHue,
      primaryHSV.saturation,
      primaryHSV.value,
    ).toColor();
    final Color onSecondary = getTextColor(secondary);

    final Color tertiary = HSVColor.fromAHSV(
      1.0,
      tertiaryHue,
      primaryHSV.saturation,
      primaryHSV.value,
    ).toColor();
    final Color onTertiary = getTextColor(tertiary);

    if (isDark) {
      // Update color settings //
      await loadColorScheme(
        ColorScheme.fromSeed(
          // Backgrounds: generated

          // Text
          onSurface: Colors.white,
          outline: halfWhite,

          // Primary
          primary: primary,
          onPrimary: onPrimary,
          primaryContainer: primary.withValues(alpha: defaultBorderOpacity),
          onPrimaryContainer: onPrimary,

          // Secondary
          secondary: secondary,
          onSecondary: onSecondary,
          secondaryContainer: secondary.withValues(alpha: defaultBorderOpacity),
          onSecondaryContainer: onSecondary,

          // Tertiary
          tertiary: tertiary,
          onTertiary: onTertiary,
          tertiaryContainer: tertiary.withValues(alpha: defaultBorderOpacity),
          onTertiaryContainer: onTertiary,

          // Erriary
          error: Colors.red,
          onError: Colors.white,
          errorContainer: const Color(0x33FF0000),
          onErrorContainer: Colors.white,

          // Misc
          // outlineVariant
          // shadow
          surfaceTint: Colors.transparent,
          scrim: Colors.black,
          brightness: Brightness.dark,
          seedColor: primary,
        ),
        Brightness.dark,
      );

      // Update design settings //

      await setDouble(
        darkPaddingKey,
        (onMobile ? defaultMobilePadding : defaultDesktopPadding) * getScalar(),
      );

      await setString(darkButtonShapeKey,
          EzButtonShape.values[random.nextInt(EzButtonShape.values.length)].value);
      await setDouble(darkBorderWidthKey, random.nextDouble() * 3);

      await setBool(darkLineLinksKey, random.nextBool());
      await setBool(darkShowBackFABKey, random.nextBool());

      if (onMobile) {
        await setDouble(darkMarginKey, defaultMobileMargin * getScalar());
        await setDouble(darkSpacingKey, defaultMobileSpacing * getScalar());
      } else {
        await setDouble(darkMarginKey, defaultDesktopMargin * getScalar());
        await setDouble(darkSpacingKey, defaultDesktopSpacing * getScalar());
      }

      await setInt(darkAnimationDurationKey, random.nextInt(1000));
      await setString(darkTransitionTypeKey,
          EzTransitionType.values[random.nextInt(EzTransitionType.values.length)].value);
      await setBool(darkTransitionFadeKey, random.nextBool());

      await setBool(darkShowScrollKey, random.nextBool());

      // Update text settings //

      final List<String> styleOptions = googleStyles.keys.toList();

      final String attentionStyle = styleOptions[random.nextInt(styleOptions.length)];
      final double attentionScale = getScalar();

      final String descriptionStyle = styleOptions[random.nextInt(styleOptions.length)];
      final double descriptionScale = getScalar();

      await setString(darkDisplayFontFamilyKey, attentionStyle);
      await setDouble(
        darkDisplayFontSizeKey,
        defaultDisplaySize * attentionScale,
      );
      await setBool(darkDisplayBoldedKey, false);
      await setBool(darkDisplayItalicizedKey, false);
      await setBool(darkDisplayUnderlinedKey, random.nextBool());
      await setDouble(darkDisplayFontHeightKey, defaultFontHeight);
      await setDouble(darkDisplayLetterSpacingKey, defaultLetterSpacing);
      await setDouble(darkDisplayWordSpacingKey, defaultWordSpacing);

      await setString(darkHeadlineFontFamilyKey, attentionStyle);
      await setDouble(
        darkHeadlineFontSizeKey,
        defaultHeadlineSize * attentionScale,
      );
      await setBool(darkHeadlineBoldedKey, false);
      await setBool(darkHeadlineItalicizedKey, false);
      await setBool(darkHeadlineUnderlinedKey, false);
      await setDouble(darkHeadlineFontHeightKey, defaultFontHeight);
      await setDouble(darkHeadlineLetterSpacingKey, defaultLetterSpacing);
      await setDouble(darkHeadlineWordSpacingKey, defaultWordSpacing);

      await setString(
        darkTitleFontFamilyKey,
        styleOptions[random.nextInt(styleOptions.length)],
      );
      await setDouble(darkTitleFontSizeKey, defaultTitleSize * attentionScale);
      await setBool(darkTitleBoldedKey, false);
      await setBool(darkTitleItalicizedKey, false);
      await setBool(darkTitleUnderlinedKey, random.nextBool());
      await setDouble(darkTitleFontHeightKey, defaultFontHeight);
      await setDouble(darkTitleLetterSpacingKey, defaultLetterSpacing);
      await setDouble(darkTitleWordSpacingKey, defaultWordSpacing);

      await setString(darkBodyFontFamilyKey, descriptionStyle);
      await setDouble(darkBodyFontSizeKey, defaultBodySize * descriptionScale);
      await setBool(darkBodyBoldedKey, false);
      await setBool(darkBodyItalicizedKey, false);
      await setBool(darkBodyUnderlinedKey, false);
      await setDouble(darkBodyFontHeightKey, defaultFontHeight);
      await setDouble(darkBodyLetterSpacingKey, defaultLetterSpacing);
      await setDouble(darkBodyWordSpacingKey, defaultWordSpacing);

      await setString(darkLabelFontFamilyKey, descriptionStyle);
      await setDouble(
        darkLabelFontSizeKey,
        defaultLabelSize * descriptionScale,
      );
      await setBool(darkLabelBoldedKey, false);
      await setBool(darkLabelItalicizedKey, false);
      await setBool(darkLabelUnderlinedKey, false);
      await setDouble(darkLabelFontHeightKey, defaultFontHeight);
      await setDouble(darkLabelLetterSpacingKey, defaultLetterSpacing);
      await setDouble(darkLabelWordSpacingKey, defaultWordSpacing);

      await setDouble(darkTextBackgroundOpacityKey, random.nextDouble());
      await setDouble(darkIconSizeKey, defaultIconSize * getScalar());
    } else {
      // Update color settings //

      await loadColorScheme(
        ColorScheme.fromSeed(
          // Backgrounds: generated

          // Text
          onSurface: Colors.black,
          outline: halfBlack,

          // Primary
          primary: primary,
          onPrimary: onPrimary,
          primaryContainer: primary.withValues(alpha: defaultBorderOpacity),
          onPrimaryContainer: onPrimary,

          // Secondary
          secondary: secondary,
          onSecondary: onSecondary,
          secondaryContainer: secondary.withValues(alpha: defaultBorderOpacity),
          onSecondaryContainer: onSecondary,

          // Tertiary
          tertiary: tertiary,
          onTertiary: onTertiary,
          tertiaryContainer: tertiary.withValues(alpha: defaultBorderOpacity),
          onTertiaryContainer: onTertiary,

          // Error
          error: Colors.red,
          onError: Colors.white,
          errorContainer: const Color(0x33FF0000),
          onErrorContainer: Colors.white,

          // Misc
          // outlineVariant
          // shadow
          surfaceTint: Colors.transparent,
          scrim: Colors.white,
          brightness: Brightness.light,
          seedColor: primary,
        ),
        Brightness.light,
      );

      // Update design settings //

      await setDouble(
        lightPaddingKey,
        (onMobile ? defaultMobilePadding : defaultDesktopPadding) * getScalar(),
      );

      await setString(lightButtonShapeKey,
          EzButtonShape.values[random.nextInt(EzButtonShape.values.length)].value);
      await setDouble(lightBorderWidthKey, random.nextDouble() * 3);

      await setBool(lightLineLinksKey, random.nextBool());
      await setBool(lightShowBackFABKey, random.nextBool());

      if (onMobile) {
        await setDouble(lightMarginKey, defaultMobileMargin * getScalar());
        await setDouble(lightSpacingKey, defaultMobileSpacing * getScalar());
      } else {
        await setDouble(lightMarginKey, defaultDesktopMargin * getScalar());
        await setDouble(lightSpacingKey, defaultDesktopSpacing * getScalar());
      }

      await setInt(lightAnimationDurationKey, random.nextInt(1000));
      await setString(lightTransitionTypeKey,
          EzTransitionType.values[random.nextInt(EzTransitionType.values.length)].value);
      await setBool(lightTransitionFadeKey, random.nextBool());

      await setBool(lightShowScrollKey, random.nextBool());

      // Update text settings //

      final List<String> styleOptions = googleStyles.keys.toList();

      final String attentionStyle = styleOptions[random.nextInt(styleOptions.length)];
      final double attentionScale = getScalar();

      final String descriptionStyle = styleOptions[random.nextInt(styleOptions.length)];
      final double descriptionScale = getScalar();

      await setString(lightDisplayFontFamilyKey, attentionStyle);
      await setDouble(
        lightDisplayFontSizeKey,
        defaultDisplaySize * attentionScale,
      );
      await setBool(lightDisplayBoldedKey, false);
      await setBool(lightDisplayItalicizedKey, false);
      await setBool(lightDisplayUnderlinedKey, random.nextBool());
      await setDouble(lightDisplayFontHeightKey, defaultFontHeight);
      await setDouble(lightDisplayLetterSpacingKey, defaultLetterSpacing);
      await setDouble(lightDisplayWordSpacingKey, defaultWordSpacing);

      await setString(lightHeadlineFontFamilyKey, attentionStyle);
      await setDouble(
        lightHeadlineFontSizeKey,
        defaultHeadlineSize * attentionScale,
      );
      await setBool(lightHeadlineBoldedKey, false);
      await setBool(lightHeadlineItalicizedKey, false);
      await setBool(lightHeadlineUnderlinedKey, false);
      await setDouble(lightHeadlineFontHeightKey, defaultFontHeight);
      await setDouble(lightHeadlineLetterSpacingKey, defaultLetterSpacing);
      await setDouble(lightHeadlineWordSpacingKey, defaultWordSpacing);

      await setString(
        lightTitleFontFamilyKey,
        styleOptions[random.nextInt(styleOptions.length)],
      );
      await setDouble(lightTitleFontSizeKey, defaultTitleSize * attentionScale);
      await setBool(lightTitleBoldedKey, false);
      await setBool(lightTitleItalicizedKey, false);
      await setBool(lightTitleUnderlinedKey, random.nextBool());
      await setDouble(lightTitleFontHeightKey, defaultFontHeight);
      await setDouble(lightTitleLetterSpacingKey, defaultLetterSpacing);
      await setDouble(lightTitleWordSpacingKey, defaultWordSpacing);

      await setString(lightBodyFontFamilyKey, descriptionStyle);
      await setDouble(lightBodyFontSizeKey, defaultBodySize * descriptionScale);
      await setBool(lightBodyBoldedKey, false);
      await setBool(lightBodyItalicizedKey, false);
      await setBool(lightBodyUnderlinedKey, false);
      await setDouble(lightBodyFontHeightKey, defaultFontHeight);
      await setDouble(lightBodyLetterSpacingKey, defaultLetterSpacing);
      await setDouble(lightBodyWordSpacingKey, defaultWordSpacing);

      await setString(lightLabelFontFamilyKey, descriptionStyle);
      await setDouble(
        lightLabelFontSizeKey,
        defaultLabelSize * descriptionScale,
      );
      await setBool(lightLabelBoldedKey, false);
      await setBool(lightLabelItalicizedKey, false);
      await setBool(lightLabelUnderlinedKey, false);
      await setDouble(lightLabelFontHeightKey, defaultFontHeight);
      await setDouble(lightLabelLetterSpacingKey, defaultLetterSpacing);
      await setDouble(lightLabelWordSpacingKey, defaultWordSpacing);

      await setDouble(lightTextBackgroundOpacityKey, random.nextDouble());
      await setDouble(lightIconSizeKey, defaultIconSize * getScalar());
    }
  }

  //* Removers *//

  /// Remove the custom value for [key]
  /// When [reset] is true, the default value is restored (if present)
  /// By default, both the live and [SharedPreferencesAsync] values are modified
  static Future<bool> remove(
    String key, {
    bool reset = true,
  }) async {
    try {
      await _instance!._preferences.remove(key);

      (reset && _instance!._defaults.containsKey(key))
          ? _instance!._prefs[key] = _instance!._defaults[key]
          : _instance!._prefs.remove(key);

      return true;
    } catch (e) {
      ezLog('Error removing key [$key]...\n$e');
      return false;
    }
  }

  /// Remove the [keys] custom values
  /// When [reset] is true, the default value is restored (if present)
  /// By default, both the live and [SharedPreferencesAsync] values are modified
  /// Returns false if any keys fail to be removed, but all keys will be attempted
  static Future<bool> removeKeys(
    Set<String> keys, {
    bool reset = true,
  }) async {
    bool success = true;
    for (final String key in keys) {
      success &= await remove(key, reset: reset);
    }

    return success;
  }

  /// [removeKeys], all (except those in [skip])
  /// The neverReset keys from [EzCM.init] will always be [skip]ed, provided keys will be appended
  /// Obviously, [forceOne] and [forceBoth] are not meant to be true at the same time
  /// If they are, forceOne takes precedence
  static Future<bool> reset(
    bool isDark, {
    Set<String>? skip,
    bool forceOne = false,
    bool forceBoth = false,
  }) async {
    final Set<String> keys = Set<String>.from(_instance!._prefs.keys);

    keys.removeAll(_instance!._neverReset);
    if (skip != null) keys.removeAll(skip);

    if (forceOne || (!forceBoth && !updateBoth)) {
      isDark
          ? keys.removeWhere((String key) => key.startsWith('light'))
          : keys.removeWhere((String key) => key.startsWith('dark'));
    }

    bool success = true;
    for (final String key in keys) {
      success &= await remove(key, reset: true);
    }
    return success;
  }

  //* Helpers/BTS *//

  static int get hubPos => get(hubPositionKey);
  static bool get updateBoth => get(updateBothKey);

  static Future<bool> setHubPos(int pos) => setInt(hubPositionKey, pos);
}
