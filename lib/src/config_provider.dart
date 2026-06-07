/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzCP extends ChangeNotifier {
  // Construct //

  late Locale _locale;
  late EFUILang _l10n;
  bool _ltr;

  late EzColorCache _color;
  late EzDesignCache _design;
  late EzLayoutCache _layout;
  late EzTextCache _text;

  final EzAppCache _appCache;

  late ThemeData _darkTheme;
  late ThemeData _lightTheme;

  late ThemeMode _themeMode;
  late ThemeData _currTheme;
  late bool _isDark;

  bool _needsRebuild;

  /// EzConfig Provider
  EzCP({
    required Locale locale,
    required EFUILang el10n,
    required EzAppCache appCache,
    required bool isDark,
  })  : _locale = locale,
        _l10n = el10n,
        _ltr = !rtlLanguageCodes.contains(locale.languageCode),
        _appCache = appCache,
        _isDark = isDark,
        _needsRebuild = false {
    _buildThemeMode();
    _buildThemeData();
    _appCache.init(isDark);
  }

  /// Gather and set [_themeMode] from storage
  ThemeMode _buildThemeMode() {
    final bool? savedDark = EzCM.get(isDarkThemeKey);

    final ThemeMode newMode = (savedDark == null)
        ? ThemeMode.system
        : (savedDark == true)
            ? ThemeMode.dark
            : ThemeMode.light;

    _themeMode = newMode;
    return newMode;
  }

  /// Builds fresh themes and config caches
  void _buildThemeData() {
    // Build new themes //

    _darkTheme = ezThemeData(Brightness.dark, _ltr);
    _lightTheme = ezThemeData(Brightness.light, _ltr);

    if (_isDark) {
      // Build new caches //

      // Setup
      final EzButtonShape buttonShape = EBSConfig.lookup(EzCM.get(darkButtonShapeKey));
      final double margin = EzCM.get(darkMarginKey);
      final double spacing = EzCM.get(darkSpacingKey);

      // Make them so
      _color = EzColorCache(EzCM.get(darkColorSchemeImageKey) ?? noImageValue);

      _design = EzDesignCache(
        // Button
        padding: EzCM.get(darkPaddingKey),
        buttonShape: buttonShape,
        borderWidth: EzCM.get(darkBorderWidthKey),
        textRadius: buttonShape.textRadius,
        textFieldRadius: buttonShape.textFieldRadius,
        lineLinks: EzCM.get(darkLineLinksKey),
        showBackFAB: EzCM.get(darkShowBackFABKey),
        showScroll: EzCM.get(darkShowScrollKey),

        // Page
        margin: margin,
        spacing: spacing,
        backgroundImagePath: EzCM.get(darkBackgroundImageKey) ?? noImageValue,
        backgroundImageFit: boxFitLib[EzCM.get(darkBackgroundFitKey)],
        transitionType: ETTConfig.lookup(EzCM.get(darkTransitionTypeKey)),
        fadedTransition: EzCM.get(darkTransitionFadeKey),
        animDur: EzCM.get(darkAnimationDurationKey),
        animCurve: EACConfig.translate(EzCM.get(darkAnimationCurveKey)),
      );

      _layout = EzLayoutCache(
        margin: EzSpacer(margin),
        rowMargin: EzSpacer(margin, vertical: false),
        spacer: EzSpacer(spacing),
        rowSpacer: EzSpacer(spacing, vertical: false),
        swapSpacer: EzSwapSpacer(spacing),
        separator: EzSpacer(spacing * 2),
        divider: EzDivider(spacing * 3),
        startLine: const EzNewLine(textAlign: TextAlign.start),
        centerLine: const EzNewLine(),
        endLine: const EzNewLine(textAlign: TextAlign.end),
      );

      _text = EzTextCache(
        backgroundOpacity: EzCM.get(darkTextBackgroundOpacityKey),
        iconSize: EzCM.get(darkIconSizeKey),
      );

      // Update the curr theme pointer
      _currTheme = _darkTheme;
    } else {
      // Build new caches //

      // Setup
      final EzButtonShape buttonShape = EBSConfig.lookup(EzCM.get(lightButtonShapeKey));
      final double margin = EzCM.get(lightMarginKey);
      final double spacing = EzCM.get(lightSpacingKey);

      // Make them so
      _color = EzColorCache(EzCM.get(lightColorSchemeImageKey) ?? noImageValue);

      _design = EzDesignCache(
        // Button
        padding: EzCM.get(lightPaddingKey),
        buttonShape: buttonShape,
        borderWidth: EzCM.get(lightBorderWidthKey),
        textRadius: buttonShape.textRadius,
        textFieldRadius: buttonShape.textFieldRadius,
        lineLinks: EzCM.get(lightLineLinksKey),
        showBackFAB: EzCM.get(lightShowBackFABKey),
        showScroll: EzCM.get(lightShowScrollKey),

        // Page
        margin: margin,
        spacing: spacing,
        backgroundImagePath: EzCM.get(lightBackgroundImageKey) ?? noImageValue,
        backgroundImageFit: boxFitLib[EzCM.get(lightBackgroundFitKey)],
        transitionType: ETTConfig.lookup(EzCM.get(lightTransitionTypeKey)),
        fadedTransition: EzCM.get(lightTransitionFadeKey),
        animDur: EzCM.get(lightAnimationDurationKey),
        animCurve: EACConfig.translate(EzCM.get(lightAnimationCurveKey)),
      );

      _layout = EzLayoutCache(
        margin: EzSpacer(margin),
        rowMargin: EzSpacer(margin, vertical: false),
        spacer: EzSpacer(spacing),
        rowSpacer: EzSpacer(spacing, vertical: false),
        swapSpacer: EzSwapSpacer(spacing),
        separator: EzSpacer(spacing * 2),
        divider: EzDivider(spacing * 3),
        startLine: const EzNewLine(textAlign: TextAlign.start),
        centerLine: const EzNewLine(),
        endLine: const EzNewLine(textAlign: TextAlign.end),
      );

      _text = EzTextCache(
        backgroundOpacity: EzCM.get(lightTextBackgroundOpacityKey),
        iconSize: EzCM.get(lightIconSizeKey),
      );

      // Update the curr theme pointer
      _currTheme = _lightTheme;
    }
  }

  // Get //

  /// Current language for the app
  Locale get locale => _locale;

  /// EFUI localizations for the [locale]
  EFUILang get efuiL10n => _l10n;

  /// Text direction for the [locale]
  bool get isLTR => _ltr;

  // Color cache //
  EzColorCache get color => _color;

  String get schemeImagePath => _color.schemeImagePath;

  // Design cache //
  EzDesignCache get design => _design;

  // Button
  double get padding => _design.padding;

  EzButtonShape get buttonShape => _design.buttonShape;
  double get borderWidth => _design.borderWidth;

  BorderRadius get textRadius => _design.textRadius;
  BorderRadius get textFieldRadius => _design.textFieldRadius;

  BorderSide borderSide({Color? color}) => borderWidth == 0
      ? BorderSide.none
      : BorderSide(color: color ?? colors.primaryContainer, width: borderWidth);

  bool get lineLinks => _design.lineLinks;
  bool get showBackFAB => _design.showBackFAB;

  List<Widget> backFABs(bool isHome) =>
      (showBackFAB && !isHome && ezRootNav.currentState!.canPop()) ? <Widget>[spacer] : <Widget>[];

  // Page
  double get marginVal => _design.margin;
  double get spacing => _design.spacing;

  String get backgroundImagePath => _design.backgroundImagePath;
  BoxFit? get backgroundImageFit => _design.backgroundImageFit;

  DecorationImage get backgroundImage => DecorationImage(
        image: ezImageProvider(backgroundImagePath),
        fit: backgroundImageFit,
      );

  EzTransitionType get transitionType => _design.transitionType;
  bool get fadedTransition => _design.fadedTransition;

  int get animDur => _design.animDur;
  Curve get animCurve => _design.animCurve;

  bool get showScroll => _design.showScroll;

  // Layout cache (lil page design, lil text) //
  EzLayoutCache get layout => _layout;

  EzSpacer get margin => _layout.margin;
  EzSpacer get rowMargin => _layout.rowMargin;

  EzSpacer get spacer => _layout.spacer;
  EzSpacer get rowSpacer => _layout.rowSpacer;
  EzSwapSpacer get swapSpacer => _layout.swapSpacer;

  EzSpacer get separator => _layout.separator;
  EzDivider get divider => _layout.divider;

  EzNewLine get startLine => _layout.startLine;
  EzNewLine get centerLine => _layout.centerLine;
  EzNewLine get endLine => _layout.endLine;

  // Text cache //
  EzTextCache get text => _text;

  double get textBackgroundOpacity => _text.backgroundOpacity;
  double get iconSize => _text.iconSize;

  // Live theme //
  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;

  /// Current [ThemeMode]
  ThemeMode get themeMode => _themeMode;

  /// Current [ThemeData] to match the [themeMode]
  ThemeData get theme => _currTheme;

  /// Whether the current [themeMode] uses [Brightness.dark]
  bool get isDark => _isDark;

  ColorScheme get colors => _currTheme.colorScheme;

  TextTheme get styles => _currTheme.textTheme;
  TextStyle? get displayStyle => _currTheme.textTheme.displayLarge;
  TextStyle? get headlineStyle => _currTheme.textTheme.headlineLarge;
  TextStyle? get titleStyle => _currTheme.textTheme.titleLarge;
  TextStyle? get bodyStyle => _currTheme.textTheme.bodyLarge;
  TextStyle? get labelStyle => _currTheme.textTheme.labelLarge;

  /// Toggleable bool for alerting the user to rebuild the UI
  /// Some settings would be too expensive to rebuild on every change, so they update locally and [pingRebuild]
  bool get needsRebuild => _needsRebuild;

  /// Cache for external values that should track [EzCP] notifications
  /// Most helpful for external localizations, but the possibilities are endless!
  EzAppCache? get appCache => _appCache;

  // Set //

  /// Set [needsRebuild] to [status]
  void pingRebuild(bool status) {
    if (_needsRebuild != status) {
      _needsRebuild = status;
      notifyListeners();
    }
  }

  /// Set the apps [Locale] from storage and load corresponding localizations
  Future<void> rebuildLocale() async {
    final (Locale, EFUILang) result = await ezStoredL10n();
    _locale = result.$1;
    _l10n = result.$2;
    _ltr = !rtlLanguageCodes.contains(_locale.languageCode);

    await rebuildUI();
  }

  /// Reconfigure [ThemeMode] et al. from storage and [rebuildUI]
  Future<void> rebuildThemeMode() async {
    final ThemeMode newMode = _buildThemeMode();

    switch (newMode) {
      case ThemeMode.dark:
        _isDark = true;
        _currTheme = _darkTheme;
        break;
      case ThemeMode.light:
        _isDark = false;
        _currTheme = _lightTheme;
        break;
      case ThemeMode.system:
        if (WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark) {
          _isDark = true;
          _currTheme = _darkTheme;
        } else {
          _isDark = false;
          _currTheme = _lightTheme;
        }
        break;
    }

    await rebuildUI();
  }

  /// Rebuilds the apps [ThemeMode], [ThemeData], and updates the config caches
  Future<void> rebuildUI({Future<dynamic> Function()? changes}) async {
    unawaited(ezRootNav.currentState!.push(
      // Open progress layer
      PageRouteBuilder<Widget>(
        opaque: false,
        transitionsBuilder: (_, __, ___, Widget child) => child,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => const Center(child: CircularProgressIndicator()),
      ),
    ));

    if (changes != null) await changes();
    final ThemeMode newMode = _buildThemeMode();

    switch (newMode) {
      case ThemeMode.dark:
        _isDark = true;
        break;
      case ThemeMode.light:
        _isDark = false;
        break;
      case ThemeMode.system:
        WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark
            ? _isDark = true
            : _isDark = false;
        break;
    }
    _buildThemeData();

    await _appCache.rebuild(this);
    _needsRebuild = false;

    ezRootNav.currentState!.pop();
    ezCloseAll();
    notifyListeners();
  }
}

// Build //

class EzColorCache {
  final String schemeImagePath;

  /// Theme aware tracker for frequently used color values...
  /// (dark|light)ColorSchemeImageKey
  EzColorCache(this.schemeImagePath);
}

class EzDesignCache {
  // Button //

  final double padding;

  final EzButtonShape buttonShape;
  final double borderWidth;

  final BorderRadius textRadius;
  final BorderRadius textFieldRadius;

  final bool lineLinks;
  final bool showBackFAB;
  final bool showScroll;

  // Page //

  final double margin;
  final double spacing;

  final int animDur;
  final Curve animCurve;
  final EzTransitionType transitionType;
  final bool fadedTransition;

  final String backgroundImagePath;
  final BoxFit? backgroundImageFit;

  /// Theme aware tracker for frequently used design values...
  /// Animation duration
  EzDesignCache({
    // Button
    required this.padding,
    required this.buttonShape,
    required this.borderWidth,
    required this.textRadius,
    required this.textFieldRadius,
    required this.lineLinks,
    required this.showBackFAB,
    required this.showScroll,

    // Page
    required this.margin,
    required this.spacing,
    required this.animDur,
    required this.animCurve,
    required this.transitionType,
    required this.fadedTransition,
    required this.backgroundImagePath,
    required this.backgroundImageFit,
  });
}

class EzLayoutCache {
  final EzSpacer margin;
  final EzSpacer rowMargin;
  final EzSpacer spacer;
  final EzSpacer rowSpacer;
  final EzSwapSpacer swapSpacer;
  final EzSpacer separator;
  final EzDivider divider;

  final EzNewLine startLine;
  final EzNewLine centerLine;
  final EzNewLine endLine;

  /// Theme aware tracker for frequently used layout [Widget]s
  EzLayoutCache({
    required this.margin,
    required this.rowMargin,
    required this.spacer,
    required this.rowSpacer,
    required this.swapSpacer,
    required this.separator,
    required this.divider,
    required this.startLine,
    required this.centerLine,
    required this.endLine,
  });
}

class EzTextCache {
  final double backgroundOpacity;
  final double iconSize;

  /// Theme aware tracker for frequently used text values...
  /// Icon size, frequently used [EzNewLine]s
  EzTextCache({
    required this.backgroundOpacity,
    required this.iconSize,
  });
}

abstract class EzAppCache {
  /// Will run on app setup
  void init(bool isDark);

  /// Will run on every call to [EzCP.rebuildUI]
  Future<void> rebuild(EzCP config);
}

// Helpers/watchers //

EzCP get configWatcher => Provider.of<EzCP>(ezRootNav.currentContext!, listen: false);

EFUILang get efuiL10nWatcher => configWatcher._l10n;
