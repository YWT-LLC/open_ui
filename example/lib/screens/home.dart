/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../screens/export.dart';
import '../utils/export.dart';
import '../widgets/export.dart';

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:after_layout/after_layout.dart';
import 'package:open_ui/open_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin<HomeScreen> {
  //* Define the build data *//

  // Platform data //

  final bool isDesktop = kIsWeb
      ? false
      : (EzCM.platform == TargetPlatform.linux ||
          EzCM.platform == TargetPlatform.macOS ||
          EzCM.platform == TargetPlatform.windows);

  final bool isMac = !kIsWeb && EzCM.platform == TargetPlatform.macOS;
  final bool isWindows = !kIsWeb && EzCM.platform == TargetPlatform.windows;

  late final String homePath = isDesktop
      ? isWindows
          ? Platform.environment['UserProfile'] ?? ''
          : Platform.environment['HOME'] ?? ''
      : '';

  late final String docsPath = isDesktop
      ? isWindows
          ? '$homePath\\Documents'
          : '$homePath/Documents'
      : '';

  // Form data //

  final TextEditingController nameTC = TextEditingController(text: EzCM.get(nameBackupKey));
  late String namePreview = l10n(configWatcher(context)).csNamePreview;
  bool validName = false;

  final TextEditingController publisherTC = TextEditingController(
    text: EzCM.get(publisherBackupKey),
  );
  late String pubPreview = l10n(configWatcher(context)).csPubPreview;

  final TextEditingController descriptionTC = TextEditingController(
    text: EzCM.get(descriptionBackupKey),
  );

  final TextEditingController domainTC = TextEditingController(text: EzCM.get(domainBackupKey));
  bool exampleDomain = false;

  late final int currYear = DateTime.now().year;

  final ExpansibleController advancedEC = ExpansibleController();
  late final TextEditingController workPathTC = TextEditingController(text: docsPath);

  final ExpansibleController copyrightEC = ExpansibleController();
  late final TextEditingController copyrightTC = TextEditingController(text: copyrightDefault);

  final ExpansibleController licenseEC = ExpansibleController();
  String license = gnuKey;

  final ExpansibleController l10nEC = ExpansibleController();
  final TextEditingController l10nTC = TextEditingController(text: l10nDefault);

  final ExpansibleController analysisEC = ExpansibleController();
  final TextEditingController analysisTC = TextEditingController(text: analysisDefault);

  final ExpansibleController launchEC = ExpansibleController();
  late final TextEditingController launchTC = TextEditingController(text: vscDefault);

  late final TextEditingController flutterPathTC = TextEditingController();

  bool canGen = true;

  //* Define custom functions *//

  void updateName(String name) {
    final String previous = namePreview;
    validName = true;
    namePreview = name;

    launchTC.text = launchTC.text.replaceAll(
      previous.replaceAll('_', '-'),
      namePreview.replaceAll('_', '-'),
    );
    copyrightTC.text = copyrightTC.text.replaceAll(previous, namePreview);
    setState(() {});
  }

  void updatePublisher(String pub) {
    final String previous = pubPreview;
    pubPreview = pub;

    copyrightTC.text = copyrightTC.text.replaceAll(previous, pubPreview);
    setState(() {});
  }

  /// Validate the code gen file path (Desktop only)
  Future<bool> checkPath(EzCP config, TextEditingController controller) async {
    if (await Directory(controller.text).exists()) return true;

    final String badPath = l10n(config).csBadPath;

    // Disable interaction
    setState(() {
      canGen = false;
      advancedEC.expand();
      controller.text = badPath;
    });

    // Wait a sec
    await Future<void>.delayed(ezReadingTime(config, badPath));

    // Re-enable interaction
    setState(() => canGen = true);

    return false;
  }

  //* Init *//

  @override
  void initState() {
    super.initState();
    ezWindowNamer(thisAppName);
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    // Shared changes from relevant backups
    final String? bName = EzCM.get(nameBackupKey);
    final String? bPub = EzCM.get(publisherBackupKey);

    if (bName != null && bName.isNotEmpty) {
      updateName(bName);
    }
    if (bPub != null && bPub.isNotEmpty) {
      updatePublisher(bPub);
    }

    // Set path (for mac)
    if (!isMac) return;

    final ValueNotifier<String> flutterPath = ValueNotifier<String>('');
    await ezCmd('which flutter', dir: '/', debug: false, readout: flutterPath);

    final String success = flutterPath.value
        .split('\n')
        .firstWhere((String line) => line.contains('flutter/bin'), orElse: () => '');

    if (success.isNotEmpty) {
      final String finalPath = success.replaceAll('flutter/bin/flutter', 'flutter/bin');
      setState(() => flutterPathTC.text = finalPath);
    }
  }

  //* Return the build *//

  @override
  Widget build(BuildContext context) {
    return Consumer<EzCP>(
      builder: (_, EzCP config, __) => OpenUIScaffold(
        config,
        body: EzScreen(
          config,
          alignment: Alignment.topLeft,
          child: EzScrollView(
            config,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Basic settings //

              // App name
              _BasicField(
                config,
                title: l10n(config).csAppName,
                tip: TextSpan(
                  children: <InlineSpan>[
                    EzPlainText(text: l10n(config).csNameTip),
                    EzPlainText(text: '  -->  ', semanticsLabel: ' ${l10n(config).csBecomes} '),
                    EzPlainText(text: ezTitleToSnake(l10n(config).csNameTip)),
                  ],
                  style: config.bodyStyle,
                ),
                controller: nameTC,
                validator: (String? entry) => validateAppName(
                  config,
                  entry,
                  onSuccess: () async {
                    await EzCM.setString(nameBackupKey, nameTC.text);
                    updateName(nameTC.text);
                  },
                  onFailure: () => setState(() => validName = false),
                ),
                hintText: l10n(config).csNamePreview,
              ),
              config.spacer,

              // Publisher name
              _BasicField(
                config,
                title: l10n(config).csPubName,
                tip: l10n(config).csPubTip,
                controller: publisherTC,
                validator: (String? value) => validatePublisher(
                  config,
                  value,
                  onSuccess: () async {
                    await EzCM.setString(publisherBackupKey, publisherTC.text);
                    updatePublisher(publisherTC.text);
                  },
                ),
                hintText: l10n(config).csPubPreview,
              ),
              config.spacer,

              // Description
              _BasicField(
                config,
                title: l10n(config).csDescription,
                controller: descriptionTC,
                validator: (String? value) => validateDescription(
                  config,
                  value,
                  onSuccess: () async {
                    await EzCM.setString(descriptionBackupKey, descriptionTC.text);
                    setState(() {});
                  },
                ),
                hintText: l10n(config).csDescPreview,
              ),
              config.spacer,

              // Domain name
              EzRow(
                config,
                reverseHands: false,
                children: <Widget>[
                  Flexible(
                    child: EzText(
                      config,
                      text: l10n(config).csDomainName,
                      style: config.titleStyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  EzToolTipper(config, message: l10n(config).csDomainTip),
                ],
              ),
              EzCol(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  EzAnimVis(
                    config,
                    visible: !exampleDomain,
                    mod: 0.5,
                    forceType: EzTransitionType.zoom,
                    forceFade: true,
                    kid: EzTextField(
                      controller: domainTC,
                      constraints: ezTextFieldConstraints(context),
                      hintText: 'com.example',
                      textAlign: TextAlign.start,
                      validator: (String? text) => validateDomain(
                        config,
                        text,
                        onSuccess: () async {
                          await EzCM.setString(domainBackupKey, domainTC.text);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  EzAnimSwitch(
                    config,
                    mod: 0.5,
                    forceType: EzTransitionType.zoom,
                    forceFade: false,
                    child: ConstrainedBox(
                      constraints: ezTextFieldConstraints(context),
                      child: EzSwitchPair(
                        config,
                        key: ValueKey<String>('eds-$exampleDomain'),
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: (exampleDomain || config.isLefty)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        text: config.ezL10n.gNA,
                        semanticsLabel: config.ezL10n.gNAHint,
                        textAlign: TextAlign.start,
                        value: exampleDomain,
                        onChanged: (bool? value) {
                          if (value == null) return;
                          setState(() => exampleDomain = value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              config.separator,

              // Default app config //
              EzRichText(
                config,
                children: <InlineSpan>[
                  EzPlainText(
                    text: l10n(config).csGenApp(
                      isDesktop
                          ? (validName ? namePreview : l10n(config).csTheApp)
                          : l10n(config).csTheConfig,
                    ),
                  ),
                  EzInlineLink(
                    config,
                    text: config.ezL10n.gSettings.toLowerCase(),
                    style: ezSubTitleStyle(config.styles),
                    textAlign: TextAlign.start,
                    onTap: () => context.goNamed(settingsHubPath),
                    hint: config.ezL10n.ssNavHint,
                  ),
                  EzPlainText(
                    text: l10n(
                      config,
                    ).csSetColors(validName ? namePreview : l10n(config).csYourApp),
                  ),
                  EzInlineLink(
                    config,
                    text: l10n(config).csHere,
                    style: ezSubTitleStyle(config.styles),
                    textAlign: TextAlign.start,
                    url: Uri.parse('https://www.canva.com/colors/color-wheel/'),
                    hint: l10n(config).csHereHint,
                  ),
                ],
                style: ezSubTitleStyle(config.styles),
              ),
              config.separator,

              // Advanced settings //
              ExpansionTile(
                controller: advancedEC,
                onExpansionChanged: (_) => setState(() {}),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                showTrailingIcon: false,
                title: EzRow(
                  config,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        l10n(config).csAdvanced,
                        style: config.titleStyle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    config.rowMargin,
                    Semantics(
                      hint: advancedEC.isExpanded ? config.ezL10n.gClose : config.ezL10n.gOpen,
                      button: true,
                      child: ExcludeSemantics(
                        child: EzIconButton(
                          config,
                          icon: Icon(ezVisIcon(config, advancedEC.isExpanded)),
                          onPressed: () =>
                              advancedEC.isExpanded ? advancedEC.collapse() : advancedEC.expand(),
                          tooltip:
                              advancedEC.isExpanded ? config.ezL10n.gClose : config.ezL10n.gOpen,
                        ),
                      ),
                    ),
                  ],
                ),
                children: <Widget>[
                  config.spacer,

                  // Work path picker
                  if (isDesktop) ...<Widget>[
                    Text(
                      l10n(config).csOutputPath,
                      style: config.bodyStyle?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    EzScrollView(
                      config,
                      scrollDirection: Axis.horizontal,
                      reverseHands: true,
                      children: <Widget>[
                        // Text field
                        EzTextField(
                          controller: workPathTC,
                          constraints: ezTextFieldConstraints(context),
                          hintText: docsPath,
                          textAlign: TextAlign.start,
                          readOnly: !canGen,
                          validator: (String? path) =>
                              (path == null || path.isEmpty) ? l10n(config).csPathRequired : null,
                        ),
                        config.rowMargin,

                        // Browse
                        EzIconButton(
                          config,
                          onPressed: () async {
                            final String? selectedDirectory = await FilePicker.getDirectoryPath();
                            if (selectedDirectory == null) return;

                            setState(() {
                              workPathTC.text = selectedDirectory.contains(homePath)
                                  ? '$homePath${selectedDirectory.split(homePath)[1]}'
                                  : selectedDirectory;
                            });
                          },
                          tooltip: l10n(config).csFileBrowser,
                          icon: const Icon(Icons.folder_open),
                        ),
                      ],
                    ),
                    config.spacer,
                  ],

                  // Copyright config
                  _AdvancedSettingsField(
                    config,
                    ec: copyrightEC,
                    title: l10n(config).csCopyright,
                    tip: l10n(config).csCopyrightTip,
                    tc: copyrightTC,
                    hintText: copyrightDefault,
                  ),
                  config.spacer,

                  // LICENSE config
                  _LicensePicker(
                    config,
                    ec: licenseEC,
                    groupValue: license,
                    onChanged: (String? picked) {
                      if (picked != null) {
                        setState(() => license = picked);
                      }
                    },
                  ),
                  config.spacer,

                  // l10n config
                  _AdvancedSettingsField(
                    config,
                    ec: l10nEC,
                    title: 'l10n(config).yaml',
                    tip: l10n(config).csL10nTip,
                    tc: l10nTC,
                    hintText: l10nDefault,
                  ),
                  config.spacer,

                  // Analysis options config
                  _AdvancedSettingsField(
                    config,
                    ec: analysisEC,
                    title: 'analysis_options.yaml',
                    tip: l10n(config).csLintTip,
                    tc: analysisTC,
                    hintText: analysisDefault,
                  ),
                  config.spacer,

                  // VS Code launch config
                  _AdvancedSettingsField(
                    config,
                    ec: launchEC,
                    title: '.vscode/launch.json',
                    tip: l10n(config).csLaunchTip,
                    tc: launchTC,
                    hintText: vscDefault,
                  ),
                ],
              ),
              advancedEC.isExpanded
                  ? config.separator
                  : EzDivider(
                      config.spacing * 3,
                      constraints: ezTextFieldConstraints(context, prop: 0.333),
                    ),

              // Flutter path picker (Mac only)
              if (isMac) ...<Widget>[
                // Title
                EzRow(
                  config,
                  reverseHands: false,
                  children: <Widget>[
                    Flexible(
                      child: EzText(
                        config,
                        text: l10n(config).csFlutterPath,
                        style: config.titleStyle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    EzToolTipper(config, message: l10n(config).csNoSpaces),
                  ],
                ),

                // Picker
                EzScrollView(
                  config,
                  scrollDirection: Axis.horizontal,
                  reverseHands: true,
                  children: <Widget>[
                    // Text box
                    EzTextField(
                      controller: flutterPathTC,
                      constraints: ezTextFieldConstraints(context),
                      hintText:
                          isWindows ? 'example_path\\flutter\\bin' : 'example_path/flutter/bin',
                      textAlign: TextAlign.start,
                      readOnly: !canGen,
                      validator: (String? path) =>
                          (path == null || path.isEmpty) ? l10n(config).csPathRequired : null,
                    ),
                    config.rowMargin,

                    // Browse
                    EzIconButton(
                      config,
                      onPressed: () async {
                        final String? selectedDirectory = await FilePicker.getDirectoryPath(
                          dialogTitle: l10n(config).csFlutterPath,
                        );

                        if (selectedDirectory == null) return;

                        setState(() {
                          flutterPathTC.text = selectedDirectory.contains(homePath)
                              ? '$homePath${selectedDirectory.split(homePath)[1]}'
                              : selectedDirectory;
                        });
                      },
                      tooltip: l10n(config).csFileBrowser,
                      icon: const Icon(Icons.folder_open),
                    ),
                  ],
                ),
                config.margin,
                EzRichText(
                  config,
                  children: <InlineSpan>[
                    EzPlainText(text: '${l10n(config).csNotInstalled} ', style: config.bodyStyle),
                    EzInlineLink(
                      config,
                      text: l10n(config).rsInstall,
                      style: config.bodyStyle,
                      textAlign: TextAlign.start,
                      url: Uri.parse(installFlutter),
                      hint: l10n(config).rsInstallHint,
                      tooltip: installFlutter,
                    ),
                    EzPlainText(text: '.', style: config.bodyStyle),
                  ],
                ),
                config.separator,
              ],

              // Make it so //
              EzScrollView(
                config,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  // Save config
                  EzElevatedIconButton(
                    config,
                    enabled: canGen,
                    onPressed: () async {
                      if (validName &&
                          publisherTC.text.isNotEmpty &&
                          (exampleDomain || validateDomain(config, domainTC.text) == null) &&
                          descriptionTC.text.isNotEmpty &&
                          (!isDesktop ||
                              ((!isMac || await checkPath(config, flutterPathTC)) &&
                                  await checkPath(config, workPathTC))) &&
                          context.mounted) {
                        context.goNamed(
                          archiveScreenPath,
                          extra: EAGConfig(
                            appName: nameTC.text,
                            publisherName: publisherTC.text,
                            appDescription: descriptionTC.text,
                            domainName: exampleDomain ? 'com.example' : domainTC.text,
                            appDefaults: Map<String, dynamic>.fromEntries(
                              allEZConfigKeys.keys.map(
                                (String key) => MapEntry<String, dynamic>(key, EzCM.get(key)),
                              ),
                            ),
                            flutterPath: isMac ? flutterPathTC.text : null,
                            workPath: isDesktop ? workPathTC.text : null,
                            copyright: copyrightTC.text,
                            license: pickLicense(
                              license: license,
                              appName: nameTC.text,
                              publisher: publisherTC.text,
                              description: descriptionTC.text,
                              year: currYear.toString(),
                            ),
                            l10nConfig: l10nTC.text,
                            analysisOptions: analysisTC.text,
                            vsCodeConfig: launchTC.text,
                          ),
                        );
                      } else {
                        setState(() => canGen = false);
                        await ezSnackBar(
                          config,
                          context: context,
                          message: '${l10n(config).csInvalidFields}.\n${l10n(config).csRequired}.',
                        ).closed;
                        setState(() => canGen = true);
                      }
                    },
                    icon: EzIcon(config, Icons.save),
                    label: config.ezL10n.ssSaveConfig,
                  ),

                  // Generate app
                  if (isDesktop) ...<Widget>[
                    config.spacer,
                    EzElevatedIconButton(
                      config,
                      enabled: canGen,
                      onPressed: () async {
                        if (validName &&
                            publisherTC.text.isNotEmpty &&
                            (exampleDomain || validateDomain(config, domainTC.text) == null) &&
                            descriptionTC.text.isNotEmpty &&
                            (!isMac || await checkPath(config, flutterPathTC)) &&
                            await checkPath(config, workPathTC) &&
                            context.mounted) {
                          context.goNamed(
                            generateScreenPath,
                            extra: EAGConfig(
                              appName: nameTC.text,
                              publisherName: publisherTC.text,
                              appDescription: descriptionTC.text,
                              domainName: exampleDomain ? 'com.example' : domainTC.text,
                              appDefaults: Map<String, dynamic>.fromEntries(
                                allEZConfigKeys.keys.map(
                                  (String key) => MapEntry<String, dynamic>(key, EzCM.get(key)),
                                ),
                              ),
                              flutterPath: isMac ? flutterPathTC.text : null,
                              workPath: workPathTC.text,
                              copyright: copyrightTC.text,
                              license: pickLicense(
                                license: license,
                                appName: nameTC.text,
                                publisher: publisherTC.text,
                                description: descriptionTC.text,
                                year: currYear.toString(),
                              ),
                              l10nConfig: l10nTC.text,
                              analysisOptions: analysisTC.text,
                              vsCodeConfig: launchTC.text,
                            ),
                          );
                        } else {
                          setState(() => canGen = false);
                          await ezSnackBar(
                            config,
                            context: context,
                            message:
                                '${l10n(config).csInvalidFields}.\n${l10n(config).csRequired}.',
                          ).closed;
                          setState(() => canGen = true);
                        }
                      },
                      icon: EzIcon(config, Icons.build),
                      label: l10n(config).csGenerate,
                    ),
                  ],
                ],
              ),
              EzFooter(config, textAlign: TextAlign.start),
            ],
          ),
        ),
        title: l10n(config).csPageTitle,
        onUpload: (EAGConfig toLoad) async {
          // Disable buttons
          setState(() => canGen = false);

          // Gather everything
          nameTC.text = toLoad.appName;
          await EzCM.setString(nameBackupKey, toLoad.appName);
          namePreview = toLoad.appName;
          validName = true;

          publisherTC.text = toLoad.publisherName;
          await EzCM.setString(publisherBackupKey, toLoad.publisherName);
          pubPreview = toLoad.publisherName;

          descriptionTC.text = toLoad.appDescription;
          await EzCM.setString(descriptionBackupKey, toLoad.appDescription);

          domainTC.text = toLoad.domainName;
          if (toLoad.domainName == 'com.example') {
            exampleDomain = true;
          } else {
            await EzCM.setString(domainBackupKey, toLoad.domainName);
          }

          await EzCM.loadConfig(config, toLoad: toLoad.appDefaults);

          if (toLoad.flutterPath != null &&
              isMac &&
              await Directory(toLoad.flutterPath!).exists()) {
            flutterPathTC.text = toLoad.flutterPath!;
          }

          if (toLoad.workPath != null && await Directory(toLoad.workPath!).exists()) {
            workPathTC.text = toLoad.workPath!;
          }

          copyrightTC.text = toLoad.copyright;

          if (toLoad.license.contains('GNU General Public License')) {
            license = gnuKey;
          } else if (toLoad.license.contains('MIT License')) {
            license = mitKey;
          } else if (toLoad.license.contains('ISC License')) {
            license = iscKey;
          } else if (toLoad.license.contains('Apache License')) {
            license = apacheKey;
          } else if (toLoad.license.contains('Mozilla Public License')) {
            license = mozillaKey;
          } else if (toLoad.license.contains('free and unencumbered')) {
            license = unlicenseKey;
          } else if (toLoad.license.contains('WHAT THE FU')) {
            license = dwtfywKey;
          } else {
            license = gnuKey;
          }

          l10nTC.text = toLoad.l10nConfig;
          analysisTC.text = toLoad.analysisOptions;
          launchTC.text = toLoad.vsCodeConfig;

          // Enable buttons
          setState(() => canGen = true);
        },
        fabs: <Widget>[
          config.spacer,
          ResetFAB(
            config,
            clear: () async {
              nameTC.clear();
              await EzCM.remove(nameBackupKey);
              namePreview = l10n(config).csNamePreview;
              validName = false;

              publisherTC.clear();
              await EzCM.remove(publisherBackupKey);
              pubPreview = l10n(config).csPubPreview;

              descriptionTC.clear();
              await EzCM.remove(descriptionBackupKey);

              domainTC.clear();
              await EzCM.remove(domainBackupKey);
              exampleDomain = false;

              flutterPathTC.clear();

              advancedEC.collapse();

              workPathTC.text = docsPath;

              copyrightEC.collapse();
              copyrightTC.text = copyrightDefault;

              licenseEC.collapse();
              license = gnuKey;

              l10nEC.collapse();
              l10nTC.text = l10nDefault;

              analysisEC.collapse();
              analysisTC.text = analysisDefault;

              launchEC.collapse();
              launchTC.text = vscDefault;
            },
            state: () => setState(() {}),
          ),
        ],
        isHome: true,
      ),
    );
  }

  @override
  void dispose() {
    nameTC.dispose();
    publisherTC.dispose();
    descriptionTC.dispose();
    domainTC.dispose();
    advancedEC.dispose();
    workPathTC.dispose();
    copyrightEC.dispose();
    copyrightTC.dispose();
    l10nEC.dispose();
    l10nTC.dispose();
    analysisEC.dispose();
    analysisTC.dispose();
    launchEC.dispose();
    launchTC.dispose();
    flutterPathTC.dispose();
    super.dispose();
  }

  /// .vscode launch config with debug run and release install
  late String vscDefault = '''{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "run-${namePreview.replaceAll('_', '-')}",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "program": "lib/main.dart",
    },
    {
      "name": "install-${namePreview.replaceAll('_', '-')}",
      "request": "launch",
      "type": "dart",
      "flutterMode": "release",
      "program": "lib/main.dart",
    },
  ]
}''';

  /// Recommended l10n config
  static const String l10nDefault = '''arb-dir: lib/l10n
output-dir: lib/l10n
template-arb-file: lang_en.arb
output-localization-file: lang.dart
output-class: Lang
use-deferred-loading: true
gen-inputs-and-outputs-list: lib/l10n
required-resource-attributes: false
format: true
suppress-warnings: false''';

  /// Recommended lints
  static const String analysisDefault = '''include: package:flutter_lints/flutter.yaml

analyzer:
  exclude: [lib/l10n/**]

linter:
  rules:
    always_declare_return_types: true
    always_specify_types: true
    avoid_catching_errors: true
    avoid_null_checks_in_equality_operators: true
    avoid_redundant_argument_values: true
    avoid_types_as_parameter_names: true
    avoid_void_async: true
    await_only_futures: true
    camel_case_types: true
    cancel_subscriptions: true
    close_sinks: true
    constant_identifier_names: true
    empty_catches: true
    file_names: true
    hash_and_equals: true
    library_names: true
    library_prefixes: true
    non_constant_identifier_names: true
    package_names: true
    prefer_asserts_with_message: true
    prefer_conditional_assignment: true
    prefer_const_constructors: true
    prefer_const_declarations: true
    prefer_final_fields: true
    prefer_final_in_for_each: true
    prefer_final_locals: true
    prefer_function_declarations_over_variables: true
    prefer_if_null_operators: true
    prefer_single_quotes: true
    provide_deprecation_message: true
    test_types_in_equals: true
    unawaited_futures: true
    unnecessary_async: true
    unnecessary_late: true
    unnecessary_library_name: true
    unnecessary_new: true
    use_build_context_synchronously: true
    use_full_hex_values_for_flutter_colors: true''';

  /// Gets copied to the top of every dart file
  /// Includes the app name, publisher, and year of generation
  late String copyrightDefault = '''/* $namePreview
 * Copyright (c) $currYear $pubPreview. All rights reserved.
 * See LICENSE for distribution and usage details.
 */''';
}

class _BasicField extends StatelessWidget {
  final EzCP config;
  final String title;
  final dynamic tip;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;

  const _BasicField(
    this.config, {
    required this.title,
    this.tip,
    required this.controller,
    required this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) => EzCol(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Title
          EzRow(
            config,
            reverseHands: false,
            children: <Widget>[
              Flexible(
                child: EzText(
                  config,
                  text: title,
                  style: config.titleStyle,
                  textAlign: TextAlign.start,
                ),
              ),
              if (tip != null)
                tip.runtimeType == String
                    ? EzToolTipper(config, message: tip)
                    : EzToolTipper(config, richMessage: tip),
            ],
          ),

          // Field
          EzTextField(
            controller: controller,
            constraints: ezTextFieldConstraints(context),
            hintText: hintText,
            textAlign: TextAlign.start,
            validator: validator,
          ),
        ],
      );
}

class _AdvancedSettingsField extends StatefulWidget {
  final EzCP config;

  final ExpansibleController ec;
  final String title;
  final dynamic tip;

  final TextEditingController tc;
  final String hintText;
  // final String? Function(String?)? validator;

  const _AdvancedSettingsField(
    this.config, {
    required this.ec,
    required this.title,
    this.tip,
    required this.tc,
    required this.hintText,
    // this.validator,
  });

  @override
  State<_AdvancedSettingsField> createState() => _AdvancedSettingsFieldState();
}

class _AdvancedSettingsFieldState extends State<_AdvancedSettingsField> {
  @override
  Widget build(BuildContext context) => Theme(
        data: widget.config.theme.copyWith(
          dividerColor: widget.config.colors.surfaceContainer,
          dividerTheme: DividerThemeData(
            color: widget.config.colors.surfaceContainer,
            space: 0,
            thickness: 0,
          ),
        ),
        child: ExpansionTile(
          controller: widget.ec,
          onExpansionChanged: (_) => setState(() {}),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          showTrailingIcon: false,
          title: EzRow(
            widget.config,
            children: <Widget>[
              Flexible(
                child:
                    Text(widget.title, style: widget.config.bodyStyle, textAlign: TextAlign.start),
              ),
              widget.config.rowMargin,
              Semantics(
                label:
                    widget.ec.isExpanded ? widget.config.ezL10n.gClose : widget.config.ezL10n.gOpen,
                button: true,
                child: ExcludeSemantics(
                  child: EzIconButton(
                    widget.config,
                    onPressed: () =>
                        widget.ec.isExpanded ? widget.ec.collapse() : widget.ec.expand(),
                    tooltip: widget.ec.isExpanded
                        ? widget.config.ezL10n.gClose
                        : widget.config.ezL10n.gOpen,
                    icon: Icon(ezVisIcon(widget.config, widget.ec.isExpanded)),
                  ),
                ),
              ),
              if (widget.tip != null) ...<Widget>[
                widget.tip.runtimeType == String
                    ? EzToolTipper(widget.config, message: widget.tip)
                    : EzToolTipper(widget.config, richMessage: widget.tip),
              ],
            ],
          ),
          children: <Widget>[
            widget.config.margin,
            EzTextField(
              controller: widget.tc,
              constraints: ezTextFieldConstraints(context),
              hintText: widget.hintText,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              validator: null,
            ),
          ],
        ),
      );
}

class _LicensePicker extends StatefulWidget {
  final EzCP config;
  final ExpansibleController ec;
  final String groupValue;
  final void Function(String?) onChanged;

  const _LicensePicker(
    this.config, {
    required this.ec,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<_LicensePicker> createState() => _LicensePickerState();
}

class _LicensePickerState extends State<_LicensePicker> {
  Widget radio({required String title, required String value}) => EzCol(
        children: <Widget>[
          EzTextButton(
            widget.config,
            text: title,
            textAlign: TextAlign.center,
            onPressed: () => widget.onChanged(value),
          ),
          ExcludeSemantics(child: EzRadio<String>(widget.config, value: value)),
        ],
      );

  @override
  Widget build(BuildContext context) => Theme(
        data: widget.config.theme.copyWith(
          dividerColor: widget.config.colors.surfaceContainer,
          dividerTheme: DividerThemeData(
            color: widget.config.colors.surfaceContainer,
            space: 0,
            thickness: 0,
          ),
        ),
        child: ExpansionTile(
          controller: widget.ec,
          onExpansionChanged: (_) => setState(() {}),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          showTrailingIcon: false,
          title: EzRow(
            widget.config,
            children: <Widget>[
              Flexible(
                child: Text('LICENSE', textAlign: TextAlign.start, style: widget.config.bodyStyle),
              ),
              widget.config.rowMargin,
              Semantics(
                label:
                    widget.ec.isExpanded ? widget.config.ezL10n.gClose : widget.config.ezL10n.gOpen,
                button: true,
                child: ExcludeSemantics(
                  child: EzIconButton(
                    widget.config,
                    onPressed: () =>
                        widget.ec.isExpanded ? widget.ec.collapse() : widget.ec.expand(),
                    tooltip: widget.ec.isExpanded
                        ? widget.config.ezL10n.gClose
                        : widget.config.ezL10n.gOpen,
                    icon: Icon(ezVisIcon(widget.config, widget.ec.isExpanded)),
                  ),
                ),
              ),
              widget.config.rowMargin,
              EzToolTipper(
                widget.config,
                richMessage: EzInlineLink(
                  widget.config,
                  text: 'https://choosealicense.com/',
                  textAlign: TextAlign.center,
                  url: Uri.parse('https://choosealicense.com/'),
                  hint: l10n(widget.config).csLicenseDocs,
                ),
              ),
            ],
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: widget.config.marginVal),
              child: RadioGroup<String>(
                groupValue: widget.groupValue,
                onChanged: widget.onChanged,
                child: EzScrollView(
                  widget.config,
                  scrollDirection: Axis.horizontal,
                  thumbVisibility: false,
                  showScrollHint: true,
                  children: <Widget>[
                    widget.config.rowMargin,
                    radio(title: 'GNU GPLv3', value: gnuKey),
                    widget.config.rowSpacer,
                    radio(title: 'MIT', value: mitKey),
                    widget.config.rowSpacer,
                    radio(title: 'ISC', value: iscKey),
                    widget.config.rowSpacer,
                    radio(title: 'Apache 2.0', value: apacheKey),
                    widget.config.rowSpacer,
                    radio(title: 'Mozilla 2.0', value: mozillaKey),
                    widget.config.rowSpacer,
                    radio(title: 'Unlicense', value: unlicenseKey),
                    widget.config.rowSpacer,
                    radio(title: 'DWTFYW', value: dwtfywKey),
                    widget.config.rowMargin,
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
