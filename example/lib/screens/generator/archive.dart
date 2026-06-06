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
  final EAGConfig config;

  const ArchiveScreen(this.config, {super.key});

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

  /// Save the config
  void archive() async {
    late final String savedConfig;
    try {
      savedConfig = await FileSaver.instance.saveFile(
        name: '${widget.config.appName}_eag_config.json',
        bytes: utf8.encode(jsonEncode(widget.config.toJson())),
        mimeType: MimeType.json,
      );
    } catch (e) {
      setState(() {
        failureMessage = e.toString();
        genState = GeneratorState.failed;
      });
    }

    savedConfig.endsWith('.json')
        ? setState(() => genState = GeneratorState.successful)
        : setState(() {
            failureMessage = '${ezL10n.ssWrongConfigExt} .json...\n\n$savedConfig';
            genState = GeneratorState.failed;
          });
  }

  Widget header(EzCP config) => switch (genState) {
        GeneratorState.running => SizedBox(
            height: heightOf(context) / 3,
            width: double.infinity,
            child: EmpathyLoading(
              semantics: config.l10n.gLoadingAnim,
              colorScheme: config.colors,
            ),
          ),
        GeneratorState.successful => Center(
            child: SuccessHeader(
              richMessage: EzRichText(
                <InlineSpan>[
                  EzPlainText(text: config.l10n.ssConfigSaved(archivePath())),
                  if (!isDesktop) ...<InlineSpan>[
                    EzPlainText(text: l10n.asUseIt),
                    EzInlineLink(
                      thisAppName,
                      style: ezSubTitleStyle(config.styles),
                      textAlign: TextAlign.center,
                      url: Uri.parse(openUIReleases),
                      hint: config.l10n.gOpenUIReleases,
                    ),
                    EzPlainText(text: l10n.asToGen(widget.config.appName)),
                  ]
                ],
                style: ezSubTitleStyle(config.styles),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        GeneratorState.failed => Center(child: FailureHeader(message: failureMessage)),
      };

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => archive());
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Consumer<EzCP>(
      builder: (_, EzCP config, __) => OpenUIScaffold(
        EzScreen(header(config), alignment: Alignment.topCenter),
        title: l10n.asPageTitle,
        running: genState == GeneratorState.running,
      ),
    );
  }
}
