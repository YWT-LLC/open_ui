/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_saver/file_saver.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ArchiveScreen extends StatefulWidget {
  final EAGConfig archive;

  const ArchiveScreen(this.archive, {super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  // Define the build data //

  GeneratorState genState = GeneratorState.running;
  String failureMessage = '';

  final bool isDesktop = EzCM.platform == TargetPlatform.linux ||
      EzCM.platform == TargetPlatform.macOS ||
      EzCM.platform == TargetPlatform.windows;

  // Define custom functions //

  /// Save the EAGConfig
  Future<void> archive(EzCP config) async {
    late final String? savedConfig;
    try {
      savedConfig = await FileSaver.instance.saveAs(
        name: '${widget.archive.appName}_eag_config.json',
        bytes: utf8.encode(jsonEncode(widget.archive.toJson())),
        mimeType: MimeType.json,
      );
    } catch (e) {
      setState(() {
        failureMessage = e.toString();
        genState = GeneratorState.failed;
      });
    }

    (savedConfig != null && savedConfig.endsWith('.json'))
        ? setState(() => genState = GeneratorState.successful)
        : setState(() {
            failureMessage = '${config.ezL10n.ssWrongConfigExt} .json...\n\n$savedConfig';
            genState = GeneratorState.failed;
          });
  }

  Widget header(EzCP config) => switch (genState) {
        GeneratorState.running => SizedBox(
            height: heightOf(context) / 3,
            width: double.infinity,
            child: EmpathyLoading(
              semantics: config.ezL10n.gLoadingAnim,
              colorScheme: config.colors,
            ),
          ),
        GeneratorState.successful => Center(
            child: SuccessHeader(
              config,
              richMessage: EzRichText(
                config,
                children: <InlineSpan>[
                  EzPlainText(text: config.ezL10n.ssConfigSaved(archivePath())),
                  if (!isDesktop) ...<InlineSpan>[
                    EzPlainText(text: l10n(config).asUseIt),
                    EzInlineLink(
                      config,
                      text: thisAppName,
                      style: ezSubTitleStyle(config.styles),
                      textAlign: TextAlign.center,
                      url: Uri.parse(openUIReleases),
                      hint: config.ezL10n.gOpenUIReleases,
                    ),
                    EzPlainText(text: l10n(config).asToGen(widget.archive.appName)),
                  ]
                ],
                style: ezSubTitleStyle(config.styles),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        GeneratorState.failed => Center(child: FailureHeader(config, message: failureMessage)),
      };

  // Return the build //

  bool ran = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<EzCP>(builder: (_, EzCP config, __) {
      if (!ran) {
        ran = true;
        archive(config);
      }

      return OpenUIScaffold(
        config,
        body: EzScreen(config, alignment: Alignment.topCenter, child: header(config)),
        title: l10n(config).asPageTitle,
        running: genState == GeneratorState.running,
      );
    });
  }
}
