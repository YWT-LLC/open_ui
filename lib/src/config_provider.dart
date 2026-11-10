/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../open_ui.dart';

import 'dart:async';
import 'package:provider/provider.dart';
import 'package:material_ui/material_ui.dart';

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

    if (_isDark) {
      // Color //

      final ColorScheme basicColors = ezColorScheme(Brightness.dark);

      final EzSwitchColor surface = _colorOrGradient(darkSurfaceKey, basicColors);
      final EzSwitchColor surfaceContainer = _colorOrGradient(darkSurfaceContainerKey, basicColors);
      final EzSwitchColor primary = _colorOrGradient(darkPrimaryKey, basicColors);
      final EzSwitchColor secondary = _colorOrGradient(darkSecondaryKey, basicColors);
      final EzSwitchColor tertiary = _colorOrGradient(darkTertiaryKey, basicColors);
      final EzSwitchColor error = _colorOrGradient(darkErrorKey, basicColors);

      final EzColorCache colorCache = EzColorCache(
        schemeImagePath: EzCM.get(darkColorSchemeImageKey) ?? noImageValue,

        // Surface
        surface: surface,
        surfaceDim: _colorOrGradient(darkSurfaceDimKey, basicColors).asColor,
        surfaceContainer: surfaceContainer,
        onSurface: ezTextColor(surface.asColor),

        // Big three
        primary: primary,
        primaryContainer: _colorOrGradient(darkPrimaryContainerKey, basicColors),
        onPrimary: ezTextColor(primary.asColor),

        secondary: secondary,
        secondaryContainer: _colorOrGradient(darkSecondaryContainerKey, basicColors),
        onSecondary: ezTextColor(secondary.asColor),

        tertiary: tertiary,
        tertiaryContainer: _colorOrGradient(darkTertiaryContainerKey, basicColors),
        onTertiary: ezTextColor(tertiary.asColor),

        // Misc
        error: error,
        errorContainer: _colorOrGradient(darkErrorContainerKey, basicColors),
        onError: ezTextColor(error.asColor),

        outline: _colorOrGradient(darkOutlineKey, basicColors).asColor,
        outlineVariant: _colorOrGradient(darkOutlineVariantKey, basicColors),
        shadow: _colorOrGradient(darkShadowKey, basicColors),
        surfaceTint: _colorOrGradient(darkSurfaceTintKey, basicColors).asColor,
      );

      // Design //

      final double margin = EzCM.get(darkMarginKey);
      final double spacing = EzCM.get(darkSpacingKey);

      final String backgroundImagePath = EzCM.get(darkBackgroundImageKey) ?? noImageValue;
      final BoxFit? backgroundImageFit = boxFitLib[EzCM.get(darkBackgroundFitKey)];

      final EzDesignCache designCache = EzDesignCache(
        // Button
        padding: EzCM.get(darkPaddingKey),
        buttonShape: EBSConfig.safeLookup(EzCM.get(darkButtonShapeKey)),
        borderWidth: EzCM.get(darkBorderWidthKey),
        lineLinks: EzCM.get(darkLineLinksKey),
        showBackFAB: EzCM.get(darkShowBackFABKey),
        showScroll: EzCM.get(darkShowScrollKey),

        // Page
        margin: margin,
        spacing: spacing,
        animDur: EzCM.get(darkAnimationDurationKey),
        animCurve: EACConfig.translate(EzCM.get(darkAnimationCurveKey)),
        transitionType: ETTConfig.safeLookup(EzCM.get(darkTransitionTypeKey)),
        fadedTransition: EzCM.get(darkTransitionFadeKey),
        backgroundImagePath: backgroundImagePath,
        backgroundImageFit: backgroundImageFit,
        screenDecoration: _buildScreenDeco(
          surfaceContainer,
          backgroundImagePath,
          backgroundImageFit,
        ),
      );

      final EzLayoutCache layoutCache = EzLayoutCache(
        margin: EzSpacer(margin),
        rowMargin: EzSpacer(margin, vertical: false),
        spacer: EzSpacer(spacing),
        separator: EzSpacer(spacing * 2),
        rowSpacer: EzSpacer(spacing, vertical: false),
        halfSpacer: EzSpacer(spacing / 2),
        swapSpacer: EzSwapSpacer(spacing),
      );

      // Text //

      final TextStyle bodyStyle = ezBodyStyle(basicColors.onSurface, isDark: true);

      final EzTextCache textCache = EzTextCache(
        iconSize: EzCM.get(darkIconSizeKey),
        backgroundOpacity: EzCM.get(darkTextBackgroundOpacityKey),
        startLine: EzNewLine(bodyStyle, textAlign: TextAlign.start),
        centerLine: EzNewLine(bodyStyle),
        endLine: EzNewLine(bodyStyle, textAlign: TextAlign.end),
        richLine: const EzRichLine(),
      );

      _color = colorCache;
      _design = designCache;
      _layout = layoutCache;
      _text = textCache;

      _theme = ezThemeData(
        Brightness.dark,
        ltr: _ltr,
        basicColors: basicColors,
        colors: colorCache,
        design: designCache,
        layout: layoutCache,
        text: textCache,
      );
    } else {
      // Color //

      final ColorScheme basicColors = ezColorScheme(Brightness.light);

      final EzSwitchColor surface = _colorOrGradient(lightSurfaceKey, basicColors);
      final EzSwitchColor surfaceContainer =
          _colorOrGradient(lightSurfaceContainerKey, basicColors);
      final EzSwitchColor primary = _colorOrGradient(lightPrimaryKey, basicColors);
      final EzSwitchColor secondary = _colorOrGradient(lightSecondaryKey, basicColors);
      final EzSwitchColor tertiary = _colorOrGradient(lightTertiaryKey, basicColors);
      final EzSwitchColor error = _colorOrGradient(lightErrorKey, basicColors);

      final EzColorCache colorCache = EzColorCache(
        schemeImagePath: EzCM.get(lightColorSchemeImageKey) ?? noImageValue,

        // Surface
        surface: surface,
        surfaceDim: _colorOrGradient(lightSurfaceDimKey, basicColors).asColor,
        surfaceContainer: surfaceContainer,
        onSurface: ezTextColor(surface.asColor),

        // Big three
        primary: primary,
        primaryContainer: _colorOrGradient(lightPrimaryContainerKey, basicColors),
        onPrimary: ezTextColor(primary.asColor),

        secondary: secondary,
        secondaryContainer: _colorOrGradient(lightSecondaryContainerKey, basicColors),
        onSecondary: ezTextColor(secondary.asColor),

        tertiary: tertiary,
        tertiaryContainer: _colorOrGradient(lightTertiaryContainerKey, basicColors),
        onTertiary: ezTextColor(tertiary.asColor),

        // Misc
        error: error,
        errorContainer: _colorOrGradient(lightErrorContainerKey, basicColors),
        onError: ezTextColor(error.asColor),

        outline: _colorOrGradient(lightOutlineKey, basicColors).asColor,
        outlineVariant: _colorOrGradient(lightOutlineVariantKey, basicColors),
        shadow: _colorOrGradient(lightShadowKey, basicColors),
        surfaceTint: _colorOrGradient(lightSurfaceTintKey, basicColors).asColor,
      );

      // Design //

      final double margin = EzCM.get(lightMarginKey);
      final double spacing = EzCM.get(lightSpacingKey);

      final String backgroundImagePath = EzCM.get(lightBackgroundImageKey) ?? noImageValue;
      final BoxFit? backgroundImageFit = boxFitLib[EzCM.get(lightBackgroundFitKey)];

      final EzDesignCache designCache = EzDesignCache(
        // Button
        padding: EzCM.get(lightPaddingKey),
        buttonShape: EBSConfig.safeLookup(EzCM.get(lightButtonShapeKey)),
        borderWidth: EzCM.get(lightBorderWidthKey),
        lineLinks: EzCM.get(lightLineLinksKey),
        showBackFAB: EzCM.get(lightShowBackFABKey),
        showScroll: EzCM.get(lightShowScrollKey),

        // Page
        margin: margin,
        spacing: spacing,
        animDur: EzCM.get(lightAnimationDurationKey),
        animCurve: EACConfig.translate(EzCM.get(lightAnimationCurveKey)),
        transitionType: ETTConfig.safeLookup(EzCM.get(lightTransitionTypeKey)),
        fadedTransition: EzCM.get(lightTransitionFadeKey),
        backgroundImagePath: backgroundImagePath,
        backgroundImageFit: backgroundImageFit,
        screenDecoration: _buildScreenDeco(
          surfaceContainer,
          backgroundImagePath,
          backgroundImageFit,
        ),
      );

      final EzLayoutCache layoutCache = EzLayoutCache(
        margin: EzSpacer(margin),
        rowMargin: EzSpacer(margin, vertical: false),
        spacer: EzSpacer(spacing),
        separator: EzSpacer(spacing * 2),
        rowSpacer: EzSpacer(spacing, vertical: false),
        halfSpacer: EzSpacer(spacing / 2),
        swapSpacer: EzSwapSpacer(spacing),
      );

      // Text //

      final TextStyle bodyStyle = ezBodyStyle(basicColors.onSurface, isDark: false);

      final EzTextCache textCache = EzTextCache(
        iconSize: EzCM.get(lightIconSizeKey),
        backgroundOpacity: EzCM.get(lightTextBackgroundOpacityKey),
        startLine: EzNewLine(bodyStyle, textAlign: TextAlign.start),
        centerLine: EzNewLine(bodyStyle),
        endLine: EzNewLine(bodyStyle, textAlign: TextAlign.end),
        richLine: const EzRichLine(),
      );

      _color = colorCache;
      _design = designCache;
      _layout = layoutCache;
      _text = textCache;

      _theme = ezThemeData(
        Brightness.light,
        ltr: _ltr,
        basicColors: basicColors,
        colors: colorCache,
        design: designCache,
        layout: layoutCache,
        text: textCache,
      );
    }
  }

  //* Get *//

  Locale get locale => _locale;
  OUILang get ezL10n => _l10n;

  /// Text direction for the [locale]
  bool get isLTR => _ltr;

  /// Whether the layout should favor left handed users
  bool get isLefty => _isLefty;

  /// Combines [isLefty] && [isLTR] for cases where absolute position is required
  /// (vs start/end)
  bool get onLeft => isLefty == isLTR;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _isDark;
  ThemeData get theme => _theme;

  // Color cache //

  String get schemeImagePath => _color.schemeImagePath;

  // Surface
  EzSwitchColor get surfaceFill => _color.surface;
  Color get surfaceDim => _color.surfaceDim;
  EzSwitchColor get surfaceContainerFill => _color.surfaceContainer;
  Color get onSurface => _color.onSurface;

  EzSwitchColor get surfaceDimFiller => EzSwitchColor(color: surfaceDim);

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

  Color get outline => _color.outline;
  EzSwitchColor get outlineVariantFill => _color.outlineVariant;
  Color get surfaceTint => _color.surfaceTint;
  EzSwitchColor get shadowFill => _color.shadow;

  EzSwitchColor get outlineFiller => EzSwitchColor(color: outline);
  EzSwitchColor get surfaceTintFiller => EzSwitchColor(color: surfaceTint);

  // Design cache //
  // Button
  double get padding => _design.padding;

  EzButtonShape get buttonShape => _design.buttonShape;
  double get borderWidth => _design.borderWidth;

  bool get lineLinks => _design.lineLinks;
  bool get showScroll => _design.showScroll;
  bool get showBackFAB => _design.showBackFAB;

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
  BoxDecoration get screenDecoration => _design.screenDecoration;

  // Helpers
  List<Widget> backFABs({bool isHome = false, bool override = false}) =>
      (override || (showBackFAB && !isHome && (ezRootNav.currentState?.canPop() ?? false)))
          ? <Widget>[spacer, EzBackFAB(this)]
          : <Widget>[];

  DecorationImage? get backgroundImage => (backgroundImagePath == noImageValue)
      ? null
      : DecorationImage(
          image: ezImageProvider(backgroundImagePath),
          fit: backgroundImageFit,
        );

  /// Defaults to [EzCP.primaryContainerFill]
  BoxBorder boxBorder({EzSwitchColor? fill, double? width}) => ezBoxBorder(
        fill ?? primaryContainerFill,
        width: width ?? borderWidth,
      );

  /// Defaults to [EzCP.primaryContainerFill]
  BorderSide borderSide({
    EzSwitchColor? fill,
    double? width,
    double? opacity,
  }) =>
      ezBorderSide(
        fill ?? primaryContainerFill,
        width: width ?? borderWidth,
        opacity: opacity,
      );

  /// Defaults to [EzCP.primaryContainerFill]
  OutlinedBorder outlinedBorder({
    EzSwitchColor? fill,
    double? width,
    OutlinedBorder? base,
  }) =>
      ezOutlinedBorder(
        fill ?? primaryContainerFill,
        width: width ?? borderWidth,
        base: base ?? buttonShape.shape,
      );

  /// Defaults to [EzCP.primaryContainerFill]
  OutlineInputBorder outInBorder({
    EzSwitchColor? fill,
    double? width,
    BorderRadius? radius,
    double? opacity,
  }) =>
      ezOutInBorder(
        fill ?? primaryContainerFill,
        borderWidth: width ?? borderWidth,
        borderRadius: radius ?? buttonShape.textFieldRadius,
        opacity: opacity,
      );

  /// Defaults to [EzCP.primaryContainerFill]
  UnderlineInputBorder underInBorder({
    EzSwitchColor? fill,
    double? width,
    BorderRadius? radius,
    double? opacity,
  }) =>
      ezUnderInBorder(
        fill ?? primaryContainerFill,
        borderWidth: width ?? borderWidth,
        borderRadius: radius ?? buttonShape.textFieldRadius,
        opacity: opacity,
      );

  /// Defaults to [EzCP.surfaceFill]
  BoxDecoration boxDeco({
    EzSwitchColor? fill,
    BoxBorder? border,
    EzSwitchColor? borderFill,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    BoxShape shape = BoxShape.rectangle,
    double? opacity,
  }) =>
      ezBoxDeco(
        fill ?? surfaceFill,
        border: border,
        borderRadius: borderRadius ?? buttonShape.radius,
        shape: shape,
        opacity: opacity,
      );

  // TODO: audit all these: border, or no border?
  /// Defaults to [EzCP.surfaceFill]
  ButtonLayerBuilder? buttonLayer({
    EzSwitchColor? fill,
    BoxBorder? border,
    EzSwitchColor? borderFill,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    BoxShape shape = BoxShape.rectangle,
    double? opacity,
  }) =>
      ezButtonLayer(
        fill ?? surfaceFill,
        border: border,
        borderRadius: borderRadius ?? buttonShape.radius,
        shape: shape,
        opacity: opacity,
      );

  // Layout cache (lil page design, lil text) //

  EzSpacer get margin => _layout.margin;
  EzSpacer get rowMargin => _layout.rowMargin;

  EzSpacer get spacer => _layout.spacer;
  EzSpacer get separator => _layout.separator;
  EzSpacer get rowSpacer => _layout.rowSpacer;
  EzSpacer get halfSpacer => _layout.halfSpacer;
  EzSwapSpacer get swapSpacer => _layout.swapSpacer;

  // Text cache //

  double get iconSize => _text.iconSize;
  double get textBackgroundOpacity => _text.backgroundOpacity;

  EzNewLine get startLine => _text.startLine;
  EzNewLine get centerLine => _text.centerLine;
  EzNewLine get endLine => _text.endLine;
  EzRichLine get richLine => _text.richLine;

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
  final Color? color;
  final LinearGradient? gradient;

  const EzSwitchColor({
    this.gradient,
    this.color,
  }) : assert((gradient == null) != (color == null), 'One must be provided');

  Color get asColor => color ?? gradient!.colors.first;

  Gradient get asGradient => gradient ?? LinearGradient(colors: <Color>[color!]);
}

class EzColorCache {
  final String schemeImagePath;

  // Backgrounds
  final EzSwitchColor surface;
  final Color surfaceDim;
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

  final Color outline;
  final EzSwitchColor outlineVariant;
  final EzSwitchColor shadow;
  final Color surfaceTint;

  EzColorCache({
    required this.schemeImagePath,

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
  });
}

class EzDesignCache {
  // Button //

  final double padding;

  final EzButtonShape buttonShape;
  final double borderWidth;

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
  final BoxDecoration screenDecoration;

  EzDesignCache({
    // Button
    required this.padding,
    required this.buttonShape,
    required this.borderWidth,
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
    required this.screenDecoration,
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

  EzLayoutCache({
    required this.margin,
    required this.rowMargin,
    required this.spacer,
    required this.separator,
    required this.rowSpacer,
    required this.halfSpacer,
    required this.swapSpacer,
  });
}

class EzTextCache {
  final double iconSize;
  final double backgroundOpacity;

  final EzNewLine startLine;
  final EzNewLine centerLine;
  final EzNewLine endLine;
  final EzRichLine richLine;

  EzTextCache({
    required this.iconSize,
    required this.backgroundOpacity,
    required this.startLine,
    required this.centerLine,
    required this.endLine,
    required this.richLine,
  });
}

abstract class EzAppCache {
  /// Will run on app setup
  void init(bool isDark);

  /// Will run on every call to [EzCP.rebuildUI]
  Future<void> rebuild(EzCP config);
}

//* Helpers *//

// Internal //

EzSwitchColor _colorOrGradient(String key, ColorScheme basic) {
  late final EzSwitchColor backup = EzSwitchColor(color: getLiveColor(basic, key));

  final dynamic stored = EzCM.get(key);
  if (stored == null) return backup;

  final String value = stored.toString();
  final List<String> parts = value.split(colorSplit);

  if (parts.length > 1) {
    if (parts.length < 3) return backup;

    final List<int?> hexes = parts.sublist(2).map(int.tryParse).toList();
    if (hexes.contains(null)) return backup;

    return EzSwitchColor(
      gradient: LinearGradient(
        begin: alignLibrary[parts[0]] ?? Alignment.centerLeft,
        end: alignLibrary[parts[1]] ?? Alignment.centerRight,
        colors: hexes.map((int? hex) => Color(hex!)).toList(),
      ),
    );
  } else {
    final int? hex = int.tryParse(value);
    return (hex == null) ? backup : EzSwitchColor(color: Color(hex));
  }
}

BoxDecoration _buildScreenDeco(EzSwitchColor fill, String imagePath, BoxFit? imageFit) {
  if (imagePath == noImageValue) return BoxDecoration(color: fill.color, gradient: fill.gradient);

  final int? isColor = int.tryParse(imagePath);
  if (isColor != null) return BoxDecoration(color: Color(isColor));

  final LinearGradient? isGradient =
      (imagePath.split(colorSplit).length >= 4) ? ezLGFromString(imagePath) : null;
  if (isGradient != null) return BoxDecoration(gradient: isGradient);

  return BoxDecoration(image: DecorationImage(image: ezImageProvider(imagePath), fit: imageFit));
}

// Hybrid //

BoxBorder ezBoxBorder(
  EzSwitchColor fill, {
  required double width,
}) =>
    fill.color == null
        ? EzGradientBoxBorder(
            gradient: fill.gradient!,
            width: width,
          )
        : Border.all(
            color: fill.color!,
            width: width,
          );

BorderSide ezBorderSide(
  EzSwitchColor fill, {
  required double width,
  double? opacity,
}) =>
    (width) == 0
        ? BorderSide.none
        : fill.color == null
            ? EzGradientBorderSide(
                gradient: opacity == null ? fill.gradient! : fill.gradient!.withOpacity(opacity),
                width: width,
              )
            : BorderSide(
                color: opacity == null ? fill.color! : fill.color!.withValues(alpha: opacity),
                width: width,
              );

OutlinedBorder ezOutlinedBorder(
  EzSwitchColor fill, {
  required double width,
  required OutlinedBorder base,
}) =>
    fill.color == null
        ? EzGradientOutlinedBorder(gradient: fill.gradient!, width: width, base: base)
        : base;

OutlineInputBorder ezOutInBorder(
  EzSwitchColor fill, {
  required double borderWidth,
  required BorderRadius borderRadius,
  double? opacity,
}) =>
    OutlineInputBorder(
      borderSide: ezBorderSide(fill, width: borderWidth, opacity: opacity),
      borderRadius: borderRadius,
      gapPadding: 0,
    );

UnderlineInputBorder ezUnderInBorder(
  EzSwitchColor fill, {
  required double borderWidth,
  required BorderRadius borderRadius,
  double? opacity,
}) =>
    UnderlineInputBorder(
      borderSide: ezBorderSide(fill, width: borderWidth, opacity: opacity),
      borderRadius: borderRadius,
    );

BoxDecoration ezBoxDeco(
  EzSwitchColor fill, {
  BoxBorder? border,
  required BorderRadiusGeometry borderRadius,
  BoxShape shape = BoxShape.rectangle,
  double? opacity,
}) =>
    (opacity == null)
        ? BoxDecoration(
            border: border,
            borderRadius: (shape == BoxShape.circle) ? null : borderRadius,
            color: fill.color,
            gradient: fill.gradient,
            shape: shape,
          )
        : BoxDecoration(
            border: border,
            borderRadius: (shape == BoxShape.circle) ? null : borderRadius,
            color: fill.color?.withValues(alpha: opacity),
            gradient: fill.gradient?.withOpacity(opacity),
            shape: shape,
          );

// TODO: audit all these: border, or no border?
ButtonLayerBuilder? ezButtonLayer(
  EzSwitchColor fill, {
  BoxBorder? border,
  required BorderRadiusGeometry borderRadius,
  BoxShape shape = BoxShape.rectangle,
  double? opacity,
}) =>
    (fill.gradient == null)
        ? null
        : (_, __, Widget? child) => Ink(
              decoration: BoxDecoration(
                border: border,
                borderRadius: (shape == BoxShape.circle) ? null : borderRadius,
                gradient: opacity == null ? fill.gradient : fill.gradient?.withOpacity(opacity),
                shape: shape,
              ),
              child: child,
            );

// External //

/// Safety net, not a crutch...
/// Only to be used when getting the proper Provider is unreasonably difficult
/// Example: inside GoRouter
EzCP configWatcher(BuildContext context) => Provider.of<EzCP>(context, listen: false);
