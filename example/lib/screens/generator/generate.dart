/* open_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'dart:io';
import 'package:xml/xml.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class GenerateScreen extends StatefulWidget {
  final EAGConfig gen;

  const GenerateScreen(this.gen, {super.key});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  // Define the build data //

  final bool isWindows = EzCM.platform == TargetPlatform.windows;
  GeneratorState genState = GeneratorState.running;

  String? failureMessage;
  EzRichText? richFailureMessage;

  /// Quantum supremacy achieved
  bool? showDelete = true;

  String device() => switch (EzCM.platform) {
        TargetPlatform.linux => 'linux',
        TargetPlatform.macOS => 'macos',
        TargetPlatform.windows => 'windows',
        _ => 'chrome',
      };

  late final String workDir = widget.gen.workPath!;

  late final String projDir =
      isWindows ? '$workDir\\${widget.gen.appName}' : '$workDir/${widget.gen.appName}';

  late final String flutterPath = widget.gen.flutterPath == null
      ? ''
      : isWindows
          ? '${widget.gen.flutterPath}\\'
          : '${widget.gen.flutterPath}/';

  ValueNotifier<String> readout = ValueNotifier<String>('');
  final ExpansibleController ec = ExpansibleController();

  // Define custom functions //

  void onFailure(String message) => setState(() {
        failureMessage = message;
        genState = GeneratorState.failed;
      });

  /// The only way to begin
  /// Is by beginning
  Future<void> genStuff(EzCP config) => ezCmd(
        '${flutterPath}flutter create --org ${widget.gen.domainName} ${widget.gen.appName}',
        dir: workDir,
        onSuccess: () => rmUnused(config),
        onFailure: (String message) {
          if (message.contains('not permitted') && EzCM.platform == TargetPlatform.macOS) {
            setState(() {
              showDelete = false;
              richFailureMessage = EzRichText(
                config,
                children: <InlineSpan>[
                  EzPlainText(text: l10n(config).gsNeedPermission),
                  EzPlainText(text: '\n\n${l10n(config).gsSeeNBelieve}'),
                  EzInlineLink(
                    config,
                    text: l10n(config).csHere,
                    style: ezSubTitleStyle(config.styles),
                    textAlign: TextAlign.center,
                    url: Uri.parse(
                        'https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/example/lib/screens/generator/generate.dart'),
                    hint: l10n(config).gsSeeNBelieveHint,
                  ),
                ],
                style: ezSubTitleStyle(config.styles),
                textAlign: TextAlign.center,
              );
              genState = GeneratorState.failed;
            });
          } else if (message.contains('command not found')) {
            setState(() {
              showDelete = null;
              failureMessage = l10n(config).gsNotInstalled;
              genState = GeneratorState.failed;
            });
          } else {
            onFailure(message);
          }
        },
        readout: readout,
      );

  /// Runs immediately after a successful [genStuff]
  Future<void> rmUnused(EzCP config) async {
    const String files = 'analysis_options.yaml pubspec.lock pubspec.yaml README.md';
    const String dirs = 'lib test';

    // Files
    await ezCmd(
      isWindows ? 'del /f /q $files' : 'rm -f $files',
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    // Folders
    await ezCmd(
      isWindows ? 'rmdir /s /q $dirs' : 'rm -rf $dirs',
      dir: projDir,
      onSuccess: () => addStuff(config),
      onFailure: onFailure,
      readout: readout,
    );
  }

  /// Runs immediately after a successful [rmUnused]
  Future<void> addStuff(EzCP config) async {
    await genREADME(
      config: widget.gen,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genVersionTracking(
      config: widget.gen,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genLicense(
      config: widget.gen,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genPubspec(
      config: widget.gen,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genLib(
      config: widget.gen,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genL10n(
      config: widget.gen,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genAnalysis(
      config: widget.gen,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genVSCode(
      config: widget.gen,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await runStuff(config);
  }

  /// Runs immediately after a successful [addStuff]
  /// Last method before completion
  Future<void> runStuff(EzCP config) async {
    late ProcessResult? runResult;
    try {
      // Update entitlements //

      final File macOSDebugEntitlements = File('$projDir/macos/Runner/DebugProfile.entitlements');
      final File macOSReleaseEntitlements = File('$projDir/macos/Runner/Release.entitlements');

      final XmlDocument debugDoc = XmlDocument.parse(await macOSDebugEntitlements.readAsString());
      final XmlDocument releaseDoc =
          XmlDocument.parse(await macOSReleaseEntitlements.readAsString());

      const String networkClientKey = 'com.apple.security.network.client';

      // Check if the entitlements already exist

      if (debugDoc.findAllElements(networkClientKey).isEmpty) {
        // Add the entitlement
        final XmlElement dictionary = debugDoc.rootElement.findElements('dict').first;

        dictionary.children.add(XmlElement(const XmlName.parts(networkClientKey)));
        dictionary.children.add(XmlElement(const XmlName.parts('true')));

        // Save the modified file
        await macOSDebugEntitlements.writeAsString(debugDoc.toXmlString(pretty: true));
      }

      if (releaseDoc.findAllElements(networkClientKey).isEmpty) {
        // Add the entitlement
        final XmlElement dictionary = releaseDoc.rootElement.findElements('dict').first;

        dictionary.children.add(XmlElement(const XmlName.parts(networkClientKey)));
        dictionary.children.add(XmlElement(const XmlName.parts('true')));

        // Save the modified file
        await macOSReleaseEntitlements.writeAsString(releaseDoc.toXmlString(pretty: true));
      }

      // Make sure packages are in order //

      ezLog('clean...', buffer: readout);
      runResult = await Process.run(
        '${flutterPath}flutter',
        <String>['clean'],
        runInShell: true,
        workingDirectory: projDir,
      );
      ezLog(runResult.stdout, buffer: readout);
      ezLog(runResult.stderr, buffer: readout);

      ezLog('pub upgrade...', buffer: readout);
      runResult = await Process.run(
        '${flutterPath}flutter',
        <String>[
          'pub',
          'upgrade',
          '--major-versions',
        ],
        runInShell: true,
        workingDirectory: projDir,
      );
      ezLog(runResult.stdout, buffer: readout);
      ezLog(runResult.stderr, buffer: readout);

      ezLog('pub tighten...', buffer: readout);
      runResult = await Process.run(
        '${flutterPath}flutter',
        <String>[
          'pub',
          'upgrade',
          '--tighten',
        ],
        runInShell: true,
        workingDirectory: projDir,
      );
      ezLog(runResult.stdout, buffer: readout);
      ezLog(runResult.stderr, buffer: readout);

      //  Generate l10n files //

      ezLog('gen-l10n(config)...', buffer: readout);
      runResult = await Process.run(
        '${flutterPath}flutter',
        <String>['gen-l10n'],
        runInShell: true,
        workingDirectory: projDir,
      );
      ezLog(runResult.stdout, buffer: readout);
      ezLog(runResult.stderr, buffer: readout);
    } catch (e) {
      onFailure(e.toString());
    }

    (runResult != null && runResult.exitCode == 0)
        ? setState(() {
            showDelete = false;
            genState = GeneratorState.successful;
          })
        : onFailure(l10n(config).gsPartialSuccess);
  }

  Widget header(EzCP config) => switch (genState) {
        GeneratorState.running => EmpathyLoading(
            semantics: config.ezL10n.gLoadingAnim,
            colorScheme: config.colors,
          ),
        GeneratorState.successful => Center(
            child: SuccessHeader(
              config,
              message: '${widget.gen.appName} ${l10n(config).gsIsReadyIn}\n${widget.gen.workPath}',
            ),
          ),
        GeneratorState.failed => Center(
            child: EzScrollView(
              config,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FailureHeader(
                  config,
                  message: failureMessage,
                  richMessage: richFailureMessage,
                ),
                if (showDelete == true) ...<Widget>[
                  config.spacer,
                  DeleteOption(
                    config,
                    appName: widget.gen.appName,
                    dir: workDir,
                    style: ezSubTitleStyle(config.styles),
                  ),
                ],
                if (showDelete == null) ...<Widget>[
                  config.spacer,
                  LinkOption(config),
                ],
              ],
            ),
          ),
      };

  // Return the build //

  bool ran = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<EzCP>(builder: (_, EzCP config, __) {
      if (!ran) {
        ran = true;
        genStuff(config);
      }

      return OpenUIScaffold(
        config,
        body: EzScreen(
          config,
          child: EzScrollView(config, children: <Widget>[
            SizedBox(
              height: heightOf(context) / 3,
              width: double.infinity,
              child: header(config),
            ),
            Container(
              alignment: Alignment.topCenter,
              constraints: BoxConstraints(
                minWidth: widthOf(context) * 0.667,
                maxWidth: widthOf(context) * 0.667,
              ),
              child: ExpansionTile(
                controller: ec,
                onExpansionChanged: (_) => setState(() {}),
                expandedAlignment: Alignment.topCenter,
                expandedCrossAxisAlignment: CrossAxisAlignment.center,
                showTrailingIcon: false,
                title: EzRow(
                  config,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        l10n(config).gsConsole,
                        style: config.titleStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    config.rowMargin,
                    EzIconButton(
                      config,
                      icon: Icon(
                        ezVisIcon(config, ec.isExpanded),
                        semanticLabel: ec.isExpanded ? config.ezL10n.gClose : config.ezL10n.gOpen,
                      ),
                      onPressed: () => ec.isExpanded ? ec.collapse() : ec.expand(),
                      tooltip: ec.isExpanded ? config.ezL10n.gClose : config.ezL10n.gOpen,
                    ),
                  ],
                ),
                children: <Widget>[
                  ValueListenableBuilder<String>(
                    valueListenable: readout,
                    builder: (_, String value, __) => Text(
                      value,
                      style: config.bodyStyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            config.separator,
          ]),
        ),
        title: l10n(config).gsPageTitle,
        running: genState == GeneratorState.running,
      );
    });
  }
}
