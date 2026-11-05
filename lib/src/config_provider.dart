/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../open_ui.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzCP extends ChangeNotifier {
  late Locale _locale;
  late OUILang _l10n;
  bool _ltr;

  late bool _isLefty;

  late ThemeMode _themeMode;
  late bool _isDark;
  late ThemeData _theme;

  late EzColorCache _color;
  late EzDesignCache _design;
  late EzLayoutCache _layout;
  late EzTextCache _text;

  EzAppCache _appCache;
  bool _needsRebuild;

  EzCP({
    required bool isDark,
    required Locale locale,
    required OUILang el10n,
    required EzAppCache appCache,
  })  : _locale = locale,
        _l10n = el10n,
        _ltr = !rtlCodes.contains(locale.languageCode),
        _isDark = isDark,
        _appCache = appCache,
        _needsRebuild = false {
    _isLefty = EzCM.get(isLeftyKey);
    _getThemeMode();
    _buildThemeData();
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
  void _buildThemeData() {
    _isLefty = EzCM.get(isLeftyKey);

    EzSwitchColor colorOrGradient(String key) {
      final String color = EzCM.get(key);
      final List<String> parts = color.split(colorSplit);

      return parts.length > 1
          ? EzSwitchColor(
              gradient: LinearGradient(
              begin: alignLibrary[parts[0]] ?? Alignment.centerLeft,
              end: alignLibrary[parts[1]] ?? Alignment.centerRight,
              colors: parts.sublist(2).map((String color) => Color(int.parse(color))).toList(),
            ))
          : EzSwitchColor(color: Color(int.parse(color)));
    }

    if (_isDark) {
      _theme = ezThemeData(Brightness.dark, _ltr);

      //* Setup (dark) *//
      // Color //

      final EzSwitchColor surface = colorOrGradient(darkSurfaceKey);
      final EzSwitchColor primary = colorOrGradient(darkPrimaryKey);
      final EzSwitchColor secondary = colorOrGradient(darkSecondaryKey);
      final EzSwitchColor tertiary = colorOrGradient(darkTertiaryKey);
      final EzSwitchColor error = colorOrGradient(darkErrorKey);

      // Design //

      final EzButtonShape buttonShape = EBSConfig.safeLookup(EzCM.get(darkButtonShapeKey));
      final double margin = EzCM.get(darkMarginKey);
      final double spacing = EzCM.get(darkSpacingKey);

      // Text //

      final TextStyle? bodyStyle = _theme.textTheme.bodyLarge;

      //* Make them so *//
      // Color //

      _color = EzColorCache(
        schemeImagePath: EzCM.get(darkColorSchemeImageKey) ?? noImageValue,

        // Surface
        surface: surface,
        surfaceDim: colorOrGradient(darkSurfaceDimKey),
        surfaceContainer: colorOrGradient(darkSurfaceContainerKey),
        onSurface: ezTextColor(surface.asColor),

        // Big three
        primary: primary,
        primaryContainer: colorOrGradient(darkPrimaryContainerKey),
        onPrimary: ezTextColor(primary.asColor),

        secondary: secondary,
        secondaryContainer: colorOrGradient(darkSecondaryContainerKey),
        onSecondary: ezTextColor(secondary.asColor),

        tertiary: tertiary,
        tertiaryContainer: colorOrGradient(darkTertiaryContainerKey),
        onTertiary: ezTextColor(tertiary.asColor),

        // Misc
        error: error,
        errorContainer: colorOrGradient(darkErrorContainerKey),
        onError: ezTextColor(error.asColor),

        outline: colorOrGradient(darkOutlineKey),
        outlineVariant: colorOrGradient(darkOutlineVariantKey),
        surfaceTint: colorOrGradient(darkSurfaceTintKey),
        shadow: colorOrGradient(darkShadowKey),
        scrim: colorOrGradient(darkScrimKey),
      );

      // Design //

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

      _layout = EzLayoutCache(
        margin: EzSpacer(margin),
        rowMargin: EzSpacer(margin, vertical: false),
        spacer: EzSpacer(spacing),
        separator: EzSpacer(spacing * 2),
        rowSpacer: EzSpacer(spacing, vertical: false),
        halfSpacer: EzSpacer(spacing / 2),
        swapSpacer: EzSwapSpacer(spacing),
        startLine: EzNewLine(bodyStyle, textAlign: TextAlign.start),
        centerLine: EzNewLine(bodyStyle),
        endLine: EzNewLine(bodyStyle, textAlign: TextAlign.end),
        richLine: const EzRichLine(),
      );

      // Text //

      _text = EzTextCache(
        backgroundOpacity: EzCM.get(darkTextBackgroundOpacityKey),
        iconSize: EzCM.get(darkIconSizeKey),
      );
    } else {
      _theme = ezThemeData(Brightness.light, _ltr);

      //* Setup (light) *//
      // Color //

      final EzSwitchColor surface = colorOrGradient(lightSurfaceKey);
      final EzSwitchColor primary = colorOrGradient(lightPrimaryKey);
      final EzSwitchColor secondary = colorOrGradient(lightSecondaryKey);
      final EzSwitchColor tertiary = colorOrGradient(lightTertiaryKey);
      final EzSwitchColor error = colorOrGradient(lightErrorKey);

      // Design //

      final EzButtonShape buttonShape = EBSConfig.safeLookup(EzCM.get(lightButtonShapeKey));
      final double margin = EzCM.get(lightMarginKey);
      final double spacing = EzCM.get(lightSpacingKey);

      // Text //

      final TextStyle? bodyStyle = _theme.textTheme.bodyLarge;

      //* Make them so *//
      // Color //

      _color = EzColorCache(
        schemeImagePath: EzCM.get(lightColorSchemeImageKey) ?? noImageValue,

        // Surface
        surface: surface,
        surfaceDim: colorOrGradient(lightSurfaceDimKey),
        surfaceContainer: colorOrGradient(lightSurfaceContainerKey),
        onSurface: ezTextColor(surface.asColor),

        // Big three
        primary: primary,
        primaryContainer: colorOrGradient(lightPrimaryContainerKey),
        onPrimary: ezTextColor(primary.asColor),

        secondary: secondary,
        secondaryContainer: colorOrGradient(lightSecondaryContainerKey),
        onSecondary: ezTextColor(secondary.asColor),

        tertiary: tertiary,
        tertiaryContainer: colorOrGradient(lightTertiaryContainerKey),
        onTertiary: ezTextColor(tertiary.asColor),

        // Misc
        error: error,
        errorContainer: colorOrGradient(lightErrorContainerKey),
        onError: ezTextColor(error.asColor),

        outline: colorOrGradient(lightOutlineKey),
        outlineVariant: colorOrGradient(lightOutlineVariantKey),
        surfaceTint: colorOrGradient(lightSurfaceTintKey),
        shadow: colorOrGradient(lightShadowKey),
        scrim: colorOrGradient(lightScrimKey),
      );

      // Design //

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

      _layout = EzLayoutCache(
        margin: EzSpacer(margin),
        rowMargin: EzSpacer(margin, vertical: false),
        spacer: EzSpacer(spacing),
        separator: EzSpacer(spacing * 2),
        rowSpacer: EzSpacer(spacing, vertical: false),
        halfSpacer: EzSpacer(spacing / 2),
        swapSpacer: EzSwapSpacer(spacing),
        startLine: EzNewLine(bodyStyle, textAlign: TextAlign.start),
        centerLine: EzNewLine(bodyStyle),
        endLine: EzNewLine(bodyStyle, textAlign: TextAlign.end),
        richLine: const EzRichLine(),
      );

      // Text //

      _text = EzTextCache(
        backgroundOpacity: EzCM.get(lightTextBackgroundOpacityKey),
        iconSize: EzCM.get(lightIconSizeKey),
      );
    }
  }

  //* Get *//

  /// Current language for the app
  Locale get locale => _locale;

  /// Open UI localizations for the [locale]
  OUILang get ezL10n => _l10n;

  /// Text direction for the [locale]
  bool get isLTR => _ltr;

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

  // Color cache //

  String get schemeImagePath => _color.schemeImagePath;

  // Surface
  EzSwitchColor get surfaceFill => _color.surface;
  EzSwitchColor get surfaceDimFill => _color.surfaceDim;
  EzSwitchColor get surfaceContainerFill => _color.surfaceContainer;
  Color get onSurface => _color.onSurface;

  // Big three
  EzSwitchColor get primaryFill => _color.primary;
  EzSwitchColor get primaryContainerFill => _color.primaryContainer;
  Color get onPrimary => _color.onPrimary;

  EzSwitchColor get secondaryFill => _color.secondary;
  EzSwitchColor get secondaryContainerFill => _color.secondaryContainer;
  Color get onSecondary => _color.onSecondary;

  EzSwitchColor get tertiaryFill => _color.tertiary;
  EzSwitchColor get tertiaryContainerFill => _color.tertiaryContainer;
  Color get onTertiary => _color.onTertiary;

  // Misc
  EzSwitchColor get errorFill => _color.error;
  EzSwitchColor get errorContainerFill => _color.errorContainer;
  Color get onError => _color.onError;

  EzSwitchColor get outlineFill => _color.outline;
  EzSwitchColor get outlineVariantFill => _color.outlineVariant;
  EzSwitchColor get surfaceTintFill => _color.surfaceTint;
  EzSwitchColor get shadowFill => _color.shadow;
  EzSwitchColor get scrimFill => _color.scrim;

  BoxDecoration boxDeco({
    EzSwitchColor? fill,
    double? opacity,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) =>
      (opacity == null)
          ? BoxDecoration(
              color: (fill ?? _color.surface).color,
              gradient: (fill ?? _color.surface).gradient,
              shape: shape,
              borderRadius: borderRadius,
            )
          : BoxDecoration(
              color: (fill ?? _color.surface).color?.withValues(alpha: opacity),
              gradient: (fill ?? _color.surface).gradient?.withOpacity(opacity),
              shape: shape,
              borderRadius: borderRadius,
            );

  // Design cache //
  // Button

  double get padding => _design.padding;

  EzButtonShape get buttonShape => _design.buttonShape;
  BorderRadius get textRadius => _design.textRadius;
  BorderRadius get textFieldRadius => _design.textFieldRadius;

  double get borderWidth => _design.borderWidth;

  BoxBorder boxBorder(EzSwitchColor fill) => fill.color == null
      ? EzGradientBoxBorder(this, gradient: fill.gradient!)
      : Border.all(
          color: fill.color!,
          width: _design.borderWidth,
        );

  OutlinedBorder outlinedBorder(EzSwitchColor fill, {OutlinedBorder? shape}) => fill.color == null
      ? EzGradientOutlinedBorder(this, shape: shape ?? buttonShape.shape, gradient: fill.gradient!)
      : shape ?? buttonShape.shape;

  BorderSide borderSide(
    EzSwitchColor fill, {
    double? width,
    double? opacity,
  }) =>
      (width ?? _design.borderWidth) == 0
          ? BorderSide.none
          : fill.color == null
              ? EzGradientBorderSide(
                  this,
                  gradient: opacity == null ? fill.gradient! : fill.gradient!.withOpacity(opacity),
                  vvidth: width ?? _design.borderWidth,
                )
              : BorderSide(
                  color: opacity == null ? fill.color! : fill.color!.withValues(alpha: opacity),
                  width: width ?? _design.borderWidth,
                );

  bool get lineLinks => _design.lineLinks;
  bool get showScroll => _design.showScroll;
  bool get showBackFAB => _design.showBackFAB;

  List<Widget> backFABs({bool isHome = false, bool override = false}) =>
      (override || (_design.showBackFAB && !isHome && (ezRootNav.currentState?.canPop() ?? false)))
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

  EzSpacer get margin => _layout.margin;
  EzSpacer get rowMargin => _layout.rowMargin;

  EzSpacer get spacer => _layout.spacer;
  EzSpacer get separator => _layout.separator;
  EzSpacer get rowSpacer => _layout.rowSpacer;
  EzSpacer get halfSpacer => _layout.halfSpacer;
  EzSwapSpacer get swapSpacer => _layout.swapSpacer;

  EzNewLine get startLine => _layout.startLine;
  EzNewLine get centerLine => _layout.centerLine;
  EzNewLine get endLine => _layout.endLine;
  EzRichLine get richLine => _layout.richLine; // TODO: move to text

  // Text cache //

  double get textBackgroundOpacity => _text.backgroundOpacity;
  double get iconSize => _text.iconSize;

  // Theme sub-pointers //

  TextStyle? get displayStyle => _theme.textTheme.displayLarge;
  TextStyle? get headlineStyle => _theme.textTheme.headlineLarge;
  TextStyle? get titleStyle => _theme.textTheme.titleLarge;
  TextStyle? get bodyStyle => _theme.textTheme.bodyLarge;
  TextStyle? get labelStyle => _theme.textTheme.labelLarge;

  TextStyle? get subHeadingStyle =>
      _theme.textTheme.headlineLarge?.copyWith(fontSize: _theme.textTheme.titleLarge?.fontSize);

  TextStyle? get subTitleStyle =>
      _theme.textTheme.bodyLarge?.copyWith(fontSize: _theme.textTheme.titleLarge?.fontSize);

  /// Toggleable bool for alerting the user to rebuild the UI
  /// Some settings would be too expensive to rebuild on every change, so they update locally and [pingRebuild]
  bool get needsRebuild => _needsRebuild;

  /// Cache for external values that should track [EzCP] notifications
  /// Most helpful for external localizations, but the possibilities are endless!
  EzAppCache? get appCache => _appCache;

  //* Set *//

  /// SuperCache
  void swapCache(EzAppCache newCache) {
    if (_appCache != newCache) {
      _appCache = newCache;
      notifyListeners();
    }
  }

  /// Set [needsRebuild] to [status]
  void pingRebuild(bool status) {
    if (_needsRebuild != status) {
      _needsRebuild = status;
      notifyListeners();
    }
  }

  /// Set the apps [Locale] from storage and load corresponding localizations
  Future<void> rebuildLocale() async {
    final (Locale, OUILang) result = await ezStoredL10n();
    _locale = result.$1;
    _l10n = result.$2;
    _ltr = !rtlCodes.contains(_locale.languageCode);

    await rebuildUI();
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
    await rebuildUI();
  }

  /// If you are making known [changes] prior to the rebuild, it is recommended to provide them here
  /// A fullscreen [CircularProgressIndicator] will prevent user input while the [changes] are awaited
  Future<void> rebuildUI({Future<dynamic> Function()? changes}) async {
    await ezNoTouch(this, () async {
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
      _buildThemeData();

      await _appCache.rebuild(this);
      _needsRebuild = false;
    });

    ezCloseAll();
    notifyListeners();
  }
}

//* Cache *//

class EzSwitchColor {
  final Gradient? gradient;
  final Color? color;

  const EzSwitchColor({this.gradient, this.color})
      : assert((gradient == null) != (color == null), 'One must be provided');

  Color get asColor => color ?? gradient!.colors.first;

  Gradient get asGradient => gradient ?? LinearGradient(colors: <Color>[color!]);
}

class EzColorCache {
  final String schemeImagePath;

  // Backgrounds
  final EzSwitchColor surface;
  final EzSwitchColor surfaceDim;
  final EzSwitchColor surfaceContainer;
  final Color onSurface;

  // Big three
  final EzSwitchColor primary;
  final EzSwitchColor primaryContainer;
  final Color onPrimary;

  final EzSwitchColor secondary;
  final EzSwitchColor secondaryContainer;
  final Color onSecondary;

  final EzSwitchColor tertiary;
  final EzSwitchColor tertiaryContainer;
  final Color onTertiary;

  // Misc
  final EzSwitchColor error;
  final EzSwitchColor errorContainer;
  final Color onError;

  final EzSwitchColor outline;
  final EzSwitchColor outlineVariant;
  final EzSwitchColor surfaceTint;
  final EzSwitchColor shadow;
  final EzSwitchColor scrim;

  /// Theme aware tracker for frequently used color values...
  /// Color scheme image(s)
  EzColorCache({
    required this.schemeImagePath, // TODO: use this lol

    // Backgrounds
    required this.surface,
    required this.surfaceDim,
    required this.surfaceContainer,
    required this.onSurface,

    // Primary
    required this.primary,
    required this.primaryContainer,
    required this.onPrimary,

    // Secondary
    required this.secondary,
    required this.secondaryContainer,
    required this.onSecondary,

    // Tertiary
    required this.tertiary,
    required this.tertiaryContainer,
    required this.onTertiary,

    // Erriary
    required this.error,
    required this.errorContainer,
    required this.onError,

    // Misc
    required this.outline,
    required this.outlineVariant,
    required this.surfaceTint,
    required this.shadow,
    required this.scrim,
  });
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
  final EzSpacer separator;
  final EzSpacer rowSpacer;
  final EzSpacer halfSpacer;
  final EzSwapSpacer swapSpacer;

  final EzNewLine startLine;
  final EzNewLine centerLine;
  final EzNewLine endLine;
  final EzRichLine richLine;

  /// Theme aware tracker for frequently used layout [Widget]s
  /// Spacers and new lines
  EzLayoutCache({
    required this.margin,
    required this.rowMargin,
    required this.spacer,
    required this.separator,
    required this.rowSpacer,
    required this.halfSpacer,
    required this.swapSpacer,
    required this.startLine,
    required this.centerLine,
    required this.endLine,
    required this.richLine,
  });
}

class EzTextCache {
  final double backgroundOpacity;
  final double iconSize;

  /// Theme aware tracker for frequently used text values...
  /// Background opacity, icon size
  EzTextCache({required this.backgroundOpacity, required this.iconSize});
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
