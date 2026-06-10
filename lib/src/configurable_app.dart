/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzConfigurableApp extends StatelessWidget {
  /// LocaleNamesLocalizationsDelegate(), etc.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// Languages/locales the app supports
  final Iterable<Locale> supportedLocales;

  /// Initial locale
  /// Recommended to use [ezStoredL10n]
  final Locale locale;

  /// Initial EFUILang
  /// Recommended to use [ezStoredL10n]
  final EFUILang el10n;

  /// Sets [EzCP.appCache]
  final EzAppCache appCache;

  /// Router/page config
  final RouterConfig<Object>? routerConfig;

  /// [MaterialApp.router] wrapper with a [ChangeNotifierProvider] for live configuration
  const EzConfigurableApp({
    super.key,
    this.localizationsDelegates,
    required this.supportedLocales,
    required this.locale,
    required this.el10n,
    required this.appCache,
    this.routerConfig,
  });

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<EzCP>(
        create: (_) => EzCP(
          locale: locale,
          el10n: el10n,
          isDark: EzCM.get(isDarkThemeKey) ?? isDarkTheme(context),
          appCache: appCache,
        ),
        child: _AppDrawer(
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          routerConfig: routerConfig,
        ),
      );
}

class _AppDrawer extends StatefulWidget {
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final RouterConfig<Object>? routerConfig;

  const _AppDrawer({
    required this.localizationsDelegates,
    required this.supportedLocales,
    required this.routerConfig,
  });

  @override
  State<_AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<_AppDrawer> with WidgetsBindingObserver {
  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() async {
    super.didChangePlatformBrightness();

    final EzCP config = Provider.of<EzCP>(context, listen: false);

    if ((WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark) !=
        config.isDark) {
      await config.rebuildUI(allECT);
    }
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => Consumer<EzCP>(
        builder: (_, EzCP config, __) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: widget.localizationsDelegates,
          supportedLocales: widget.supportedLocales,
          locale: config.locale,
          title: EzCM.appName,
          themeMode: config.themeMode,
          darkTheme: config.theme,
          theme: config.theme,
          routerConfig: widget.routerConfig,
        ),
      );

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
