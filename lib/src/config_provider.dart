/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzCP extends ChangeNotifier {
  //* Construct *//

  late bool _isLefty;

  late ThemeMode _themeMode;
  late bool _isDark;
  late ThemeData _theme;

  late Locale _locale;
  late EFUILang _l10n;
  bool _ltr;

  late EzColorCache _color;
  late EzDesignCache _design;
  late EzLayoutCache _layout;
  late EzTextCache _text;

  final EzAppCache _appCache;
  bool _needsRebuild;

  /// EzConfig Provider
  EzCP({
    required bool isDark,
    required Locale locale,
    required EFUILang el10n,
    required EzAppCache appCache,
  })  : _isDark = isDark,
        _locale = locale,
        _l10n = el10n,
        _ltr = !rtlLanguageCodes.contains(locale.languageCode),
        _appCache = appCache,
        _needsRebuild = false {
    _isLefty = EzCM.get(isLeftyKey);
    _getThemeMode();
    _buildThemeData(allECT);
    _appCache.init(isDark);
  }

  /// Gather and set [_themeMode] from storage
  ThemeMode _getThemeMode() {
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
  void _buildThemeData(Set<EzCacheType> types) {
    _isLefty = EzCM.get(isLeftyKey);

    if (_isDark) {
      _theme = ezThemeData(Brightness.dark, _ltr);

      // Setup
      final EzButtonShape buttonShape = EBSConfig.safeLookup(EzCM.get(darkButtonShapeKey));
      final double margin = EzCM.get(darkMarginKey);
      final double spacing = EzCM.get(darkSpacingKey);
      final TextStyle? bodyStyle = _theme.textTheme.bodyLarge;

      // Make them so
      if (needsRebuild || types.contains(EzCacheType.color)) {
        _color = EzColorCache(schemeImagePath: EzCM.get(darkColorSchemeImageKey) ?? noImageValue);
      }

      if (needsRebuild || types.contains(EzCacheType.design)) {
        _design = EzDesignCache(
          // Button
          padding: EzCM.get(darkPaddingKey),
          buttonShape: buttonShape,
          borderWidth: EzCM.get(darkBorderWidthKey),
          textRadius: buttonShape.radius,
          textFieldRadius: buttonShape.textFieldRadius,
          lineLinks: EzCM.get(darkLineLinksKey),
          showBackFAB: EzCM.get(darkShowBackFABKey),
          showScroll: EzCM.get(darkShowScrollKey),

          // Page
          margin: margin,
          spacing: spacing,
          backgroundImagePath: EzCM.get(darkBackgroundImageKey) ?? noImageValue,
          backgroundImageFit: boxFitLib[EzCM.get(darkBackgroundFitKey)],
          transitionType: ETTConfig.safeLookup(EzCM.get(darkTransitionTypeKey)),
          fadedTransition: EzCM.get(darkTransitionFadeKey),
          animDur: EzCM.get(darkAnimationDurationKey),
          animCurve: EACConfig.translate(EzCM.get(darkAnimationCurveKey)),
        );
      }

      if (needsRebuild || types.contains(EzCacheType.design) || types.contains(EzCacheType.text)) {
        _layout = EzLayoutCache(
          margin: EzSpacer(margin),
          rowMargin: EzSpacer(margin, vertical: false),
          spacer: EzSpacer(spacing),
          rowSpacer: EzSpacer(spacing, vertical: false),
          swapSpacer: EzSwapSpacer(spacing),
          separator: EzSpacer(spacing * 2),
          divider: EzDivider(spacing * 3),
          startLine: EzNewLine(bodyStyle, textAlign: TextAlign.start),
          centerLine: EzNewLine(bodyStyle),
          endLine: EzNewLine(bodyStyle, textAlign: TextAlign.end),
        );
      }

      if (needsRebuild || types.contains(EzCacheType.text)) {
        _text = EzTextCache(
          backgroundOpacity: EzCM.get(darkTextBackgroundOpacityKey),
          iconSize: EzCM.get(darkIconSizeKey),
        );
      }
    } else {
      _theme = ezThemeData(Brightness.light, _ltr);

      // Setup
      final EzButtonShape buttonShape = EBSConfig.safeLookup(EzCM.get(lightButtonShapeKey));
      final double margin = EzCM.get(lightMarginKey);
      final double spacing = EzCM.get(lightSpacingKey);
      final TextStyle? bodyStyle = _theme.textTheme.bodyLarge;

      // Make them so
      if (needsRebuild || types.contains(EzCacheType.color)) {
        _color = EzColorCache(schemeImagePath: EzCM.get(lightColorSchemeImageKey) ?? noImageValue);
      }

      if (needsRebuild || types.contains(EzCacheType.design)) {
        _design = EzDesignCache(
          // Button
          padding: EzCM.get(lightPaddingKey),
          buttonShape: buttonShape,
          borderWidth: EzCM.get(lightBorderWidthKey),
          textRadius: buttonShape.radius,
          textFieldRadius: buttonShape.textFieldRadius,
          lineLinks: EzCM.get(lightLineLinksKey),
          showBackFAB: EzCM.get(lightShowBackFABKey),
          showScroll: EzCM.get(lightShowScrollKey),

          // Page
          margin: margin,
          spacing: spacing,
          backgroundImagePath: EzCM.get(lightBackgroundImageKey) ?? noImageValue,
          backgroundImageFit: boxFitLib[EzCM.get(lightBackgroundFitKey)],
          transitionType: ETTConfig.safeLookup(EzCM.get(lightTransitionTypeKey)),
          fadedTransition: EzCM.get(lightTransitionFadeKey),
          animDur: EzCM.get(lightAnimationDurationKey),
          animCurve: EACConfig.translate(EzCM.get(lightAnimationCurveKey)),
        );
      }

      if (needsRebuild || types.contains(EzCacheType.design) || types.contains(EzCacheType.text)) {
        _layout = EzLayoutCache(
          margin: EzSpacer(margin),
          rowMargin: EzSpacer(margin, vertical: false),
          spacer: EzSpacer(spacing),
          rowSpacer: EzSpacer(spacing, vertical: false),
          swapSpacer: EzSwapSpacer(spacing),
          separator: EzSpacer(spacing * 2),
          divider: EzDivider(spacing * 3),
          startLine: EzNewLine(bodyStyle, textAlign: TextAlign.start),
          centerLine: EzNewLine(bodyStyle),
          endLine: EzNewLine(bodyStyle, textAlign: TextAlign.end),
        );
      }

      if (needsRebuild || types.contains(EzCacheType.text)) {
        _text = EzTextCache(
          backgroundOpacity: EzCM.get(lightTextBackgroundOpacityKey),
          iconSize: EzCM.get(lightIconSizeKey),
        );
      }
    }
  }

  //* Get *//

  /// Whether the layout should favor left handed users
  bool get isLefty => _isLefty;

  /// Combines [isLefty] && [isLTR] for cases where absolute position is required
  /// (vs start/end)
  bool get onLeft => isLefty == isLTR;

  /// Current [ThemeMode]
  ThemeMode get themeMode => _themeMode;

  /// Whether the current [themeMode] uses [Brightness.dark]
  bool get isDark => _isDark;

  /// Current [ThemeData] to match the [themeMode]
  ThemeData get theme => _theme;

  /// Current language for the app
  Locale get locale => _locale;

  /// EFUI localizations for the [locale]
  EFUILang get ezL10n => _l10n;

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

  BorderSide borderSide({Color? color}) => _design.borderWidth == 0
      ? BorderSide.none
      : BorderSide(
          color: color ?? _theme.colorScheme.primaryContainer,
          width: _design.borderWidth,
        );

  bool get lineLinks => _design.lineLinks;
  bool get showBackFAB => _design.showBackFAB;
  bool get showScroll => _design.showScroll;

  List<Widget> backFABs(bool isHome) =>
      (_design.showBackFAB && !isHome && (ezRootNav.currentState?.canPop() ?? false))
          ? <Widget>[spacer, EzBackFAB(this)]
          : <Widget>[];

  // Page
  double get marginVal => _design.margin;
  double get spacing => _design.spacing;
  double get spargin => _design.margin + _design.spacing;

  int get animDur => _design.animDur;
  Curve get animCurve => _design.animCurve;

  EzTransitionType get transitionType => _design.transitionType;
  bool get fadedTransition => _design.fadedTransition;

  String get backgroundImagePath => _design.backgroundImagePath;
  BoxFit? get backgroundImageFit => _design.backgroundImageFit;

  DecorationImage get backgroundImage => DecorationImage(
        image: ezImageProvider(_design.backgroundImagePath),
        fit: _design.backgroundImageFit,
      );

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

  // Theme sub-pointers //

  ColorScheme get colors => _theme.colorScheme;

  TextTheme get styles => _theme.textTheme;
  TextStyle? get displayStyle => _theme.textTheme.displayLarge;
  TextStyle? get headlineStyle => _theme.textTheme.headlineLarge;
  TextStyle? get titleStyle => _theme.textTheme.titleLarge;
  TextStyle? get bodyStyle => _theme.textTheme.bodyLarge;
  TextStyle? get labelStyle => _theme.textTheme.labelLarge;

  /// Toggleable bool for alerting the user to rebuild the UI
  /// Some settings would be too expensive to rebuild on every change, so they update locally and [pingRebuild]
  bool get needsRebuild => _needsRebuild;

  /// Cache for external values that should track [EzCP] notifications
  /// Most helpful for external localizations, but the possibilities are endless!
  EzAppCache? get appCache => _appCache;

  //* Set *//

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

    await rebuildUI(noECT);
  }

  /// Reconfigure [ThemeMode] et al. from storage and [rebuildUI]
  Future<void> rebuildThemeMode() async {
    final ThemeMode newMode = _getThemeMode();

    _isDark = switch (newMode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system =>
        (WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark)
            ? true
            : false,
    };
    await rebuildUI(allECT);
  }

  /// Always does a full rebuild of the [ThemeMode] and relevant [ThemeData]
  /// Only updates the provided cache [types]
  /// If you are making known [changes] prior to the rebuild, it is recommended to provide them here
  /// A fullscreen [CircularProgressIndicator] will prevent user input while the [changes] are awaited
  Future<void> rebuildUI(Set<EzCacheType> types, {Future<dynamic> Function()? changes}) async {
    await ezNoTouch(() async {
      if (changes != null) await changes();
      final ThemeMode newMode = _getThemeMode();

      _isDark = switch (newMode) {
        ThemeMode.dark => true,
        ThemeMode.light => false,
        ThemeMode.system =>
          (WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark)
              ? true
              : false,
      };
      _buildThemeData(types);

      await _appCache.rebuild(this);
      _needsRebuild = false;
    });

    ezCloseAll();
    notifyListeners();
  }
}

//* Cache *//

/// Color, Design, Text
enum EzCacheType { color, design, text }

const Set<EzCacheType> allECT = <EzCacheType>{
  EzCacheType.color,
  EzCacheType.design,
  EzCacheType.text,
};
const Set<EzCacheType> noECT = <EzCacheType>{};

class EzColorCache {
  final String schemeImagePath;

  /// Theme aware tracker for frequently used color values...
  /// Color scheme image(s)
  EzColorCache({required this.schemeImagePath});
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
  /// Spacers and new lines
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
  /// Background opacity, icon size
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

/// Safety net, not a crutch...
/// Only to be used when getting the proper Provider is unreasonably difficult
/// Example: inside GoRouter
EzCP configWatcher(BuildContext context) => Provider.of<EzCP>(context, listen: false);
