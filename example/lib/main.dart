/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './screens/export.dart';
import './utils/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_ui/open_ui.dart';

void main() async {
  // Configure the app //

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  EzCM.init(
    appName: thisAppName,
    androidPackage: thisPackageName,
    assetPaths: <String>{},
    defaults: isMobile() ? mobileDefaults : desktopDefaults,
    localeFallback: americanEnglish,
    l10nFallback: await OUILang.delegate.load(americanEnglish),
    preferences: await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(allowList: allEZConfigKeys.keys.toSet()),
    ),
    orientations: DeviceOrientation.values,
  );

  if (!kIsWeb && !isMobile()) {
    await windowManager.ensureInitialized();

    await windowManager.waitUntilReadyToShow(
      const WindowOptions(minimumSize: Size(500, 500)),
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );
  }

  // Run the app //

  final (Locale storedLocale, OUILang storedOUILang) = await ezStoredL10n();

  runApp(OpenUI(storedLocale, storedOUILang, await Lang.delegate.load(storedLocale)));
}

class OpenUI extends StatelessWidget {
  final Locale storedLocale;
  final OUILang storedOUILang;
  final Lang storedLang;

  const OpenUI(this.storedLocale, this.storedOUILang, this.storedLang, {super.key});

  @override
  Widget build(BuildContext context) => EzConfigurableApp(
        localizationsDelegates: ezLocalizationsDelegates(Lang.localizationsDelegates),
        supportedLocales: Lang.supportedLocales,
        locale: storedLocale,
        el10n: storedOUILang,
        appCache: OpenUICache(storedLocale, storedLang),
        routerConfig: GoRouter(
          navigatorKey: ezRootNav,
          initialLocation: homePath,
          errorBuilder: (_, __) => const ErrorScreen(),
          routes: <RouteBase>[
            // Home
            GoRoute(
              path: homePath,
              name: homePath,
              pageBuilder: (BuildContext pbc, GoRouterState pbs) =>
                  ezPageBuilder(configWatcher(pbc), pbc, pbs, const HomeScreen()),
              routes: <RouteBase>[
                // Archive
                GoRoute(
                  path: archiveScreenPath,
                  name: archiveScreenPath,
                  pageBuilder: (BuildContext pbc, GoRouterState pbs) => ezPageBuilder(
                    configWatcher(pbc),
                    pbc,
                    pbs,
                    ArchiveScreen((pbs.extra as EAGConfig)),
                  ),
                ),

                // Generate
                GoRoute(
                  path: generateScreenPath,
                  name: generateScreenPath,
                  pageBuilder: (BuildContext pbc, GoRouterState pbs) => ezPageBuilder(
                    configWatcher(pbc),
                    pbc,
                    pbs,
                    GenerateScreen((pbs.extra as EAGConfig)),
                  ),
                ),

                // Settings
                GoRoute(
                  path: settingsHubPath,
                  name: settingsHubPath,
                  pageBuilder: (BuildContext pbc, GoRouterState pbs) =>
                      ezPageBuilder(configWatcher(pbc), pbc, pbs, const SettingsHubScreen()),
                ),
              ],
            ),
          ],
        ),
      );
}
