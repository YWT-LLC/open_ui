/* open_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

//* Consts *//

const String openUIProdPage = 'https://www.empathetech.net/#/products/open-ui';

// Defaults taken from...
// https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#configuring-the-l10n-yaml-file

//* Sub-string getters *//

/// Returns the .arb file directory
String getArbDir(EAGConfig config) {
  for (final String line in config.l10nConfig.split('\n')) {
    if (line.contains('arb-dir')) {
      final List<String> parts = line.split(':');
      return parts[1].trim();
    }
  }

  return 'lib/10n';
}

/// OutputClass name
String l10nClassName(EAGConfig config) {
  for (final String line in config.l10nConfig.split('\n')) {
    if (line.contains('output-class')) {
      final List<String> parts = line.split(':');
      return parts[1].trim();
    }
  }

  return 'AppLocalizations';
}

/// [l10nClassName].localizationsDelegates
String l10nDelegates(EAGConfig config) => '${l10nClassName(config)}.localizationsDelegates';

/// \n...[l10nDelegates],\n
String l10nDelegateHandler(EAGConfig config) => '\n          ...${l10nDelegates(config)},';

//* Code generation *//

/// Slightly modified from the standard template README
Future<void> genREADME({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  final String appName = ezSnakeToTitle(config.appName);

  try {
    await File('$dir/README.md').writeAsString('''# $appName

An empathetic Flutter project.

## <br>Getting Started

Some helpful documentation if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab) (Flutter)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook) (Flutter)
- [EFUI: Digital accessibility made Ez](https://github.com/Empathetech-LLC/empathetech_flutter_ui) (Empathetech)

And videos:

- [First app tutorial](https://www.youtube.com/watch?v=xWV71C2kp38) (Flutter)
- [First app code lab](https://www.youtube.com/watch?v=8sAyPDLorek) (Flutter)
- [Using external packages](https://www.youtube.com/watch?v=WdXcJdhWcEY) (Net Ninja)

### <br>From scratch

If this is one of your first coding projects, welcome! We're honored to help catalyze something new for you.

Some (free) things that will make your life easier...
1. An IDE (Integrated Development Environment). Essentially Word/Docs for coding. By default, Open UI generated apps pair well with [VS Code](https://code.visualstudio.com/download)
2. If you setup VS Code, some **extensions** (similar ones are likely available for other IDEs)
   1. `Dart`: Flutter is a Dart framework. Dart is the underlying language (like C, Python, Java, etc), while Flutter is similar to a library, but HUGE.
   2. `Flutter`: Needs no introduction
      1. `Flutter Widget Snippets` and `Awesome Flutter Snippets` provide some shortcuts while coding. More seasoned developers will get more out of them, but they also won't hinder new players.
   3. `YAML`: Several configuration files for Flutter projects are in the .yaml format.
   4. `ARB Editor`: .arb files are what Flutter uses for localization (translation).
   5. `Code Spell Checker`: Especially when writing documentation, it's good to have your IDE check your human english as well.
      1. Or your Spanish, French, etc. with extension **add-ons**
   6. `Inno Setup`: If you're planning on releasing Windows apps publicly, you will need to write inno setup scripts.
   7. `Markdown All in One`: simplifies editing and previewing markdown files (like this one)
   8. There's also plugins for all your favorite LLMs, but those aren't free.

## <br>Maintaining Momentum

Thanks for using Open UI! We hope you find it helpful.

All that we ask is that you leave the credits/acknowledgements to Empathetech LLC in the code.

That, and/or donate via one of the many options we provide.

### <br>Building with user customization in mind

As your app grows, use [EFUI](https://github.com/Empathetech-LLC/empathetech_flutter_ui) to keep things Ez

* [Responsive design](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/responsive_design): `Widget`s that aid in building responsive UI/UX
* [Screen reader support](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/screen_reader_support): `Widget`s with streamlined `Semantics`
* [User customization](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/user_customization): Wrapper `Widget`s that respond to `EzConfig` data when the `ThemeData` doesn't cut it
* [Helpers](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/helpers): Lots of other `Widget`s and functions to make your life Ez, but don't squarely fit into the above categories

### <br>Localization

aka translation. Add new text to the language files in ${getArbDir(config)} and reference them in the dart code with `${l10nClassName(config)}`

There is a step between: after editing the .arb files, run 
``` bash
flutter gen-l10n
``` 
to generate the new aliases.

## <br>Credits

$appName began with [Open UI]($openUIProdPage)'s app generation service.

It is free and open source, maintained by [Empathetech LLC](https://www.empathetech.net/).

<br>**P.S.** `Getting Started` and `Maintaining Momentum` are for ${config.publisherName}, we recommend (re)moving them if this project is going to be made public.
''');
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('README.md successfully generated', buffer: readout);
  onSuccess();
}

/// APP_VERSION and CHANGELOG.md
Future<void> genVersionTracking({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  try {
    // APP_VERSION //

    await File('$dir/APP_VERSION').writeAsString('1.0.0');

    // CHANGELOG.md //

    final DateTime now = DateTime.now();

    await File('$dir/CHANGELOG.md').writeAsString('''# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - ${now.year}-XX-XX
### Added
- ${config.appName} V1

## [0.0.0] - ${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}
### Added
- ${config.appName} foundation generated via [Open UI]($openUIProdPage)

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
''');
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('Version tracking files successfully generated', buffer: readout);
  onSuccess();
}

/// LICENSE
Future<void> genLicense({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  try {
    await File('$dir/LICENSE').writeAsString(config.license);
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('LICENSE successfully generated', buffer: readout);
  onSuccess();
}

/// pubspec.yaml
Future<void> genPubspec({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  try {
    await File('$dir/pubspec.yaml').writeAsString('''name: ${config.appName}
description: "${config.appDescription}"
version: 1.0.0
publish_to: 'none'

environment:
  sdk: ^3.6.0

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # Flutter (Google)
  go_router: ^17.2.3
  intl: ^0.20.2
  shared_preferences: ^2.5.5

  # Community
  empathetech_flutter_ui: ^12.1.0
  provider: ^6.1.5+1

dev_dependencies:
  dependency_validator: ^5.0.5
  flutter_lints: ^6.0.0

flutter:
  generate: true
  uses-material-design: true
''');
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('pubspec.yaml successfully generated', buffer: readout);
  onSuccess();
}

/// `lib/` and many goodies within
/// Heavily modified from the standard template
Future<void> genLib({
  required EAGConfig config,
  required String dir,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  // Setup //

  final String camelCaseAppName = ezSnakeToCamel(config.appName);
  final String classCaseAppName = ezSnakeToClass(config.appName);
  final String titleCaseAppName = ezSnakeToTitle(config.appName);

  final String copyright = config.copyright;
  final String l10nClass = l10nClassName(config);

  // Create directories //

  await ezCmd(
    EzCM.platform == TargetPlatform.windows
        ? 'mkdir -p lib lib\\utils lib\\widgets lib\\screens'
        : 'mkdir -p lib lib/utils lib/widgets lib/screens',
    dir: dir,
    onFailure: onFailure,
    readout: readout,
  );

  // Write files //

  // main.dart
  try {
    await File('$dir/lib/main.dart').writeAsString("""$copyright

import './screens/export.dart';
import './utils/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void main() async {
  // Configure the app //

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  EzCM.init(
    appName: appName,
    androidPackage: androidPackage,
    assetPaths: <String>{},
    orientations: DeviceOrientation.values,
    localeFallback: americanEnglish,
    l10nFallback: await EFUILang.delegate.load(americanEnglish),
    preferences: await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
        allowList: allEZConfigKeys.keys.toSet(),
      ),
    ),
    defaults: ${camelCaseAppName}Config,
  );

  // Run the app //
  
  final (Locale storedLocale, EFUILang storedEFUILang) = await ezStoredL10n();

  runApp($classCaseAppName(
    storedLocale,
    storedEFUILang,
    await $l10nClass.delegate.load(storedLocale),
  ));
}

class $classCaseAppName extends StatelessWidget {
  final Locale storedLocale;
  final EFUILang storedEFUILang;
  final $l10nClass storedLang;
  
  const $classCaseAppName(
    this.storedLocale,
    this.storedEFUILang,
    this.storedLang, {
    super.key,
  });

  @override
  Widget build(BuildContext context) => EzConfigurableApp(
      localizationsDelegates: ezLocalizationsDelegates(Lang.localizationsDelegates),
      supportedLocales: $l10nClass.supportedLocales,
      locale: storedLocale,
      el10n: storedEFUILang,
      appCache: ${classCaseAppName}Cache(storedLocale, storedLang),
      routerConfig: GoRouter(
        navigatorKey: ezRootNav,
        initialLocation: homePath,
        errorBuilder: (_, GoRouterState state) => const ErrorScreen(),
        routes: <RouteBase>[
          // Home
          GoRoute(
            path: homePath,
            name: homePath,
            pageBuilder: (BuildContext pbc, GoRouterState pbs) =>
                ezPageBuilder(configWatcher(pbc), pbc, pbs, const HomeScreen()),
            routes: <RouteBase>[
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
""");

    // utils //

    // setup consts/config dump
    String configString() {
      String result = '{';

      for (final MapEntry<String, dynamic> entry in config.appDefaults.entries) {
        if (entry.value != null && !entry.key.contains('Image')) {
          // Handle specific cases //

          switch (entry.key) {
            case hubPositionKey:
              result += '${entry.key}Key: 0,';
              break;

            case advancedColorsKey:
            case pageTabKey:
            case advancedTextKey:
              result += '${entry.key}Key: false,';
              break;

            case appLocaleKey:
              final String stringListString = entry.value.toString().replaceAllMapped(
                    RegExp(r'\[\s*([a-zA-Z]+)\s*(?:,\s*([a-zA-Z]+)\s*)?\]'),
                    (Match m) =>
                        m[2] != null ? "<String>['${m[1]}', '${m[2]}']" : "<String>['${m[1]}']",
                  );

              result += '${entry.key}Key: $stringListString,';
              break;

            default:
              final String val = entry.value.toString();

              result +=
                  '${entry.key}Key: ${ezEnumVals.contains(val) ? val.replaceRange(0, 1, 'es${val[0].toUpperCase()}') : val},';
              break;
          }
        }
      }

      return '$result}';
    }

    // write consts
    await File('$dir/lib/utils/consts.dart').writeAsString("""$copyright

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// $titleCaseAppName
const String appName = '$titleCaseAppName';

/// ${config.domainName}.${config.appName}
const String androidPackage = '${config.domainName}.${config.appName}';

/// Default [EzCM] values
const Map<String, Object> ${camelCaseAppName}Config = <String, Object>${configString()};
""");

    // ${APP}_cache.dart
    await File('$dir/lib/utils/${config.appName}_cache.dart').writeAsString("""$copyright

import './export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ${classCaseAppName}Cache extends EzAppCache {
  Locale _locale;
  Lang _l10n;

  ${classCaseAppName}Cache(Locale locale, $l10nClass l10n)
      : _locale = locale,
        _l10n = l10n;

  @override
  void init(_) {}

  @override
  Future<void> rebuild(EzCP config) async {
    if (_locale != config.locale) {
      _l10n = await $l10nClass.delegate.load(config.locale);
      _locale = config.locale;
    }
  }
}

${classCaseAppName}Cache _cache(EzCP config) => config.appCache! as ${classCaseAppName}Cache;

Lang l10n(EzCP config) => _cache(config)._l10n;
""");

    // export.dart
    await File('$dir/lib/utils/export.dart').writeAsString("""$copyright

export 'consts.dart';
export '${config.appName}_cache.dart';

export '../l10n/${ezClassToSnake(l10nClass)}.dart';
""");

    // widgets //

    // fabulous.dart
    await File('$dir/lib/widgets/fabulous.dart').writeAsString("""$copyright

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class CountFAB extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [FloatingActionButton.onPressed] passthrough
  final void Function() count;

  /// Increases the count (for the home screen)
  const CountFAB(this.config, this.count, {super.key});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        heroTag: 'count_fab',
        onPressed: count,
        child: EzIcon(config, Icons.add),
      );
}

// TODO: Complete link placeholders (_PH)
EzUpdaterFAB updater(EzCP config) => EzUpdaterFAB(
    config,
    appVersion: '1.0.0', // TODO: (recommended to) include a check for this in your release scripts
    versionSource:
        'https://raw.githubusercontent.com/USER_PH/REPO_PH/refs/heads/main/APP_VERSION',
    gPlay:
        'https://play.google.com/store/apps/details?id=${config.domainName}.${config.appName}',
    appStore: 'https://apps.apple.com/us/app/${config.appName.replaceAll('_', '-')}/APP_ID_PH',
    github: 'https://github.com/USER_PH/REPO_PH/releases',
  );
""");

    // menu_buttons.dart
    await File('$dir/lib/widgets/menu_buttons.dart').writeAsString("""$copyright

import '../screens/export.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsButton extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [BuildContext] to call [GoRouter.goNamed] with
  final BuildContext parentContext;

  /// [EzMenuButton] for opening the settings
  const SettingsButton(this.config, {super.key, required this.parentContext});

  @override
  Widget build(_) => EzMenuButton(
        config,
        onPressed: () => parentContext.goNamed(settingsHubPath),
        icon: EzIcon(config, Icons.settings),
        label: config.ezL10n.gSettings,
      );
}

class EFUICredits extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  final String _label;

  /// [EzMenuButton] for opening Open UI's product page
  /// Honor system: keep a version of this in your app
  /// Remove iff appropriate contributions have been made to Empathetech LLC
  /// https://www.empathetech.net/#/contribute
  EFUICredits(this.config, {super.key}) : _label = config.isLefty ? config.ezL10n.gMadeBy : config.ezL10n.gCreator;

  @override
  Widget build(BuildContext context) => Tooltip(
      message: config.ezL10n.gOpenEmpathetech,
      excludeFromSemantics: true,
      child: EzMenuLink(config,
        uri: Uri.parse('https://www.empathetech.net/#/products/open-ui'),
        icon: EzIcon(config, Icons.settings),
        label: _label,
        semanticsLabel:
            '\${config.isLefty ? '\${config.ezL10n.gSettings} \$_label' : '\$_label \${config.ezL10n.gSettings}'}. \${config.ezL10n.gOpenEmpathetech}',
      ),
    );
}
""");

    // scaffold file
    await File('$dir/lib/widgets/${config.appName}_scaffold.dart').writeAsString("""$copyright

import '../utils/export.dart';
import './export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ${classCaseAppName}Scaffold extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [AppBar.title] passthrough (via [Text] widget)
  final String title;

  /// Whether to include [SettingsButton] in the [MenuAnchor]
  final bool showSettings;

  /// [Scaffold.body] passthrough
  final Widget body;

  /// [FloatingActionButton]s to add on top of the [EzUpdaterFAB]
  /// BYO spacing widgets
  final List<Widget>? fabs;

  /// For [EzCP.backFABs]
  final bool isHome;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const ${classCaseAppName}Scaffold(this.config, {
    super.key,
    this.title = appName,
    this.showSettings = true,
    required this.body,
    this.fabs,
    this.isHome = false,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final double toolbarHeight =
        ezToolbarHeight(config, context: context, title: appName);

    // Define custom widgets //

    late final Widget options = MenuAnchor(
      builder: (_, MenuController controller, ___) => EzIconButton(config, 
        onPressed: () => toggleMenu(controller),
        tooltip: config.ezL10n.gOptions,
        iconSize: config.titleStyle!.fontSize,
        icon: Icon(Icons.more_vert, semanticLabel: config.ezL10n.gOptions),
      ),
      menuChildren: <Widget>[
        (showSettings) ? SettingsButton(config, parentContext: context) : EFUICredits(config),
      ],
    );

    // Return the build //

    return EzAdaptiveParent(
      small: EzScaffold(
        config,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, toolbarHeight),
          child: EzAppBar(
            config,
            height: toolbarHeight,
            leading: config.isLefty ? options : EzBackAction(config),
            leadingWidth: toolbarHeight,
            title: Text(title, textAlign: TextAlign.center),
            actions: <Widget>[config.isLefty ? EzBackAction(config) : options],
          ),
        ),
        body: body,
        fabs: <Widget>[
          updater(config),
          if (fabs != null) ...fabs!,
          ...config.backFABs(isHome),
        ],
      ),
    );
  }
}
""");

    // export.dart
    await File('$dir/lib/widgets/export.dart').writeAsString("""$copyright

export 'fabulous.dart';
export 'menu_buttons.dart';
export '${config.appName}_scaffold.dart';
""");

    // screens //

    // error.dart
    await File('$dir/lib/screens/error.dart').writeAsString("""$copyright

import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EzCP>(builder: (_, EzCP config, __) => ${classCaseAppName}Scaffold(
        config,
        body: EzScreen(
          config,
          child: Center(
            child: EzScrollView(config, children: <Widget>[
              EzText(
                config,
                text: config.ezL10n.g404Wonder,
                style: config.headlineStyle,
                textAlign: TextAlign.center,
              ),
              config.separator,
              EzText(
                config,
                text: config.ezL10n.g404,
                style: ezSubTitleStyle(config.styles),
                textAlign: TextAlign.center,
              ),
              config.separator,
              EzText(
                config,
                text: config.ezL10n.g404Note,
                style: config.labelStyle,
                textAlign: TextAlign.center,
              ),
              EzFooter(config, spacing: 0),
            ]),
          ),
        ),
      ),
    );
  }
}
""");

    // home_screen.dart
    await File('$dir/lib/screens/home.dart').writeAsString("""$copyright

import '../utils/export.dart';
import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define the build data //

  int count = 0;

  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(appName);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Consumer<EzCP>(builder: (_, EzCP config, __) => ${classCaseAppName}Scaffold(
        config,
        body: EzScreen(
          config,
          child: Center(
            child: EzCol(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  l10n(config).hsCounterLabel,
                  style: ezSubTitleStyle(config.styles),
                  textAlign: TextAlign.center,
                ),
                Text(
                  count.toString(),
                  style: config.headlineStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        title: appName,
        fabs: <Widget>[
          config.spacer,
          CountFAB(config, () => setState(() => count += 1)),
        ],
        isHome: true,
      ),
    );
  }
}
""");

    // home.dart
    await File('$dir/lib/screens/settings.dart').writeAsString("""$copyright

import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsHubScreen extends StatelessWidget {
  /// Optionally override the starting position
  final int? targetPass;

  const SettingsHubScreen({super.key, this.targetPass}) ;

  @override
  Widget build(BuildContext context) {
    return Consumer<EzCP>(
      builder: (_, EzCP config, __) => ${classCaseAppName}Scaffold(
        config,
        body: EzScreen(config,
            child: EzSettingsHub(
              config,
              pages: <EzSettingsSection>[
                // Global //

                EzSettingsSection(
                  position: 0,
                  title: config.ezL10n.gGlobal,
                  icon: EzIcon(
                    config,
                    EzCM.onMobile
                        ? EzCM.platform == TargetPlatform.iOS
                            ? Icons.phone_iphone
                            : Icons.phone_android
                        : Icons.computer,
                    semanticLabel: config.ezL10n.gGlobal,
                  ),
                  subSettings: <EzSubSetting>[],
                  fromStorage: () => EzSubSetting.blank,
                  build: (_) => EzGlobalSettings(config),
                ),

                // Color //

                EzSettingsSection(
                  position: 1,
                  title: config.ezL10n.gColor,
                  icon: EzIcon(
                    config,
                    Icons.palette,
                    semanticLabel: config.ezL10n.gColor,
                  ),
                  subSettings: <EzSubSetting>[
                    EzSubSetting.qckColor,
                    EzSubSetting.advColor,
                  ],
                  fromStorage: () => EzCM.get(advancedColorsKey) == true
                      ? EzSubSetting.advColor
                      : EzSubSetting.qckColor,
                  build: (EzSubSetting subSec) => EzColorSettings(config, target: subSec),
                ),

                // Design //

                EzSettingsSection(
                  position: 2,
                  title: config.ezL10n.gDesign,
                  icon: EzIcon(
                    config,
                    Icons.design_services,
                    semanticLabel: config.ezL10n.gDesign,
                  ),
                  subSettings: <EzSubSetting>[
                    EzSubSetting.butDesign,
                    EzSubSetting.pagDesign,
                  ],
                  fromStorage: () => EzCM.get(pageTabKey) == true
                      ? EzSubSetting.pagDesign
                      : EzSubSetting.butDesign,
                  build: (EzSubSetting subSec) => EzDesignSettings(config, target: subSec),
                ),

                // Text //

                EzSettingsSection(
                  position: 3,
                  title: config.ezL10n.gText,
                  icon: EzIcon(
                    config,
                    Icons.text_format,
                    semanticLabel: config.ezL10n.gText,
                  ),
                  subSettings: <EzSubSetting>[
                    EzSubSetting.qckText,
                    EzSubSetting.advText,
                  ],
                  fromStorage: () => EzCM.get(advancedTextKey) == true
                      ? EzSubSetting.advText
                      : EzSubSetting.qckText,
                  build: (EzSubSetting subSec) => EzTextSettings(config, target: subSec),
                ),
              ],
              target: targetPass,
            )),
        title: config.ezL10n.gSettings,
        showSettings: false,
        fabs: <Widget>[
          // Rebuild (conditional)
          if (config.needsRebuild) ...<Widget>[
            config.spacer,
            EzRebuildFAB(config),
          ],

          // Save/upload config
          config.spacer,
          EzConfigFAB(config),
        ],
      ),
    );
  }
}
""");

    // export.dart
    await File('$dir/lib/screens/export.dart').writeAsString("""$copyright

// Exports //

export 'error.dart';
export 'home.dart';
export 'settings.dart';

// Route names //

/// settings-home
const String settingsHubPath = 'settings-hub';
""");
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('Dart code successfully generated', buffer: readout);
}

/// Localizations config
Future<void> genL10n({
  required EAGConfig config,
  required String dir,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  // Gather setup //

  final String snakeName = ezClassToSnake(l10nClassName(config));
  final String arbPath = EzCM.platform == TargetPlatform.windows
      ? getArbDir(config).replaceAll('/', '\\')
      : getArbDir(config);

  // Make dir
  await ezCmd(
    'mkdir -p $arbPath',
    dir: dir,
    onFailure: onFailure,
    readout: readout,
  );

  // Make files
  try {
    await File('$dir/$arbPath/${snakeName}_ar_EG.arb').writeAsString('''{
  "@@locale": "ar_EG",

  "hsCounterLabel": "لقد ضغطت على الزر هذا العدد من المرات:"
}''');

    await File('$dir/$arbPath/${snakeName}_ar.arb').writeAsString('''{
  "@@locale": "ar",

  "hsCounterLabel": "لقد ضغطت على الزر هذا العدد من المرات:"
}''');

    await File('$dir/$arbPath/${snakeName}_de.arb').writeAsString('''{
  "@@locale": "de",

  "hsCounterLabel": "Sie haben den Knopf so oft gedrückt:"
}''');

    await File('$dir/$arbPath/${snakeName}_en_US.arb').writeAsString('''{
  "@@locale": "en_US",

  "hsCounterLabel": "You have pushed the button this many times:"
}''');

    await File('$dir/$arbPath/${snakeName}_en.arb').writeAsString('''{
  "@@locale": "en",

  "hsCounterLabel": "You have pushed the button this many times:"
}''');

    await File('$dir/$arbPath/${snakeName}_es.arb').writeAsString('''{
  "@@locale": "es",

  "hsCounterLabel": "Has presionado el botón esta cantidad de veces:"
}''');

    await File('$dir/$arbPath/${snakeName}_fil.arb').writeAsString('''{
  "@@locale": "fil",

  "hsCounterLabel": "Maraming beses mo nang pinindot ang buton na ito:"
}''');

    await File('$dir/$arbPath/${snakeName}_fr.arb').writeAsString('''{
  "@@locale": "fr",

  "hsCounterLabel": "Vous avez appuyé sur le bouton ce nombre de fois :"
}''');

    await File('$dir/$arbPath/${snakeName}_hi.arb').writeAsString('''{
  "@@locale": "hi",

  "hsCounterLabel": "आपने बटन इतनी बार दबाया है:"
}''');

    await File('$dir/$arbPath/${snakeName}_ht.arb').writeAsString('''{
  "@@locale": "ht",

  "hsCounterLabel": "Ou peze bouton an plizyè fwa deja:"
}''');

    await File('$dir/$arbPath/${snakeName}_ja.arb').writeAsString('''{
  "@@locale": "ja",

  "hsCounterLabel": "ボタンをこれだけ押しました："
}''');

    await File('$dir/$arbPath/${snakeName}_ko.arb').writeAsString('''{
  "@@locale": "ko",

  "hsCounterLabel": "버튼을 이만큼 눌렀습니다:"
}''');

    await File('$dir/$arbPath/${snakeName}_ru.arb').writeAsString('''{
  "@@locale": "ru",

  "hsCounterLabel": "Вы нажали на кнопку столько раз:"
}''');

    await File('$dir/$arbPath/${snakeName}_sw.arb').writeAsString('''{
  "@@locale": "sw",

  "hsCounterLabel": "Umebonyeza kitufe mara nyingi hivi:"
}''');

    await File('$dir/$arbPath/${snakeName}_uk.arb').writeAsString('''{
  "@@locale": "uk",

  "hsCounterLabel": "Ви натискали кнопку стільки разів:"
}''');

    await File('$dir/$arbPath/${snakeName}_zh_CN.arb').writeAsString('''{
  "@@locale": "zh_CN",

  "hsCounterLabel": "你按了这么多次按钮："
}''');

    await File('$dir/$arbPath/${snakeName}_zh.arb').writeAsString('''{
  "@@locale": "zh",

  "hsCounterLabel": "你按了这么多次按钮："
}''');

    await File('$dir/l10n.yaml').writeAsString(config.l10nConfig);
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('Localizations successfully generated', buffer: readout);
}

/// analysis_options.yaml
Future<void> genAnalysis({
  required EAGConfig config,
  required String dir,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  try {
    await File('$dir/analysis_options.yaml').writeAsString(config.analysisOptions);
  } catch (e) {
    onFailure(e.toString());
  }

  ezLog(
    'Analysis options (lint rules) successfully generated',
    buffer: readout,
  );
}

/// Launch config
Future<void> genVSCode({
  required EAGConfig config,
  required String dir,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  // Make dir
  await ezCmd(
    'mkdir -p .vscode',
    dir: dir,
    onFailure: onFailure,
    readout: readout,
  );

  // Make file
  try {
    await File('$dir/.vscode/launch.json').writeAsString(config.vsCodeConfig);
  } catch (e) {
    onFailure(e.toString());
  }

  ezLog('VS Code launch config successfully generated', buffer: readout);
}
