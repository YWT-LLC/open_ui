/* open_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';
import '../screens/export.dart';

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsButton extends StatelessWidget {
  final EzCP config;
  final BuildContext parentContext;

  /// [EzMenuButton] for opening the settings
  const SettingsButton(this.config, {required this.parentContext, super.key});

  @override
  Widget build(BuildContext context) => EzMenuButton(
        config,
        onPressed: () => parentContext.goNamed(settingsHubPath),
        icon: EzIcon(config, Icons.settings),
        label: config.ezL10n.gSettings,
      );
}

class UploadButton extends StatelessWidget {
  final EzCP config;

  final Future<void> Function(EAGConfig) onUpload;

  /// [EzMenuButton] for uploading a config
  const UploadButton(this.config, {required this.onUpload, super.key});

  @override
  Widget build(BuildContext context) => EzMenuButton(
        config,
        onPressed: () async {
          final FilePickerResult? result = await FilePicker.pickFiles(
            type: FileType.custom,
            allowedExtensions: <String>['json'],
          );

          if (result != null && result.files.single.path != null) {
            final String filePath = result.files.single.path!;
            final String fileContent = await File(filePath).readAsString();

            try {
              final Map<String, dynamic> jsonData = jsonDecode(fileContent);
              final EAGConfig config = EAGConfig.fromJson(jsonData);

              await onUpload(config);
            } catch (e) {
              if (context.mounted) {
                ezSnackBar(config, context: context, message: e.toString());
              }
            }
          }
        },
        icon: EzIcon(config, Icons.upload),
        label: config.ezL10n.ssLoadConfig,
      );
}

class OpenSourceButton extends StatelessWidget {
  final EzCP config;

  /// [EzMenuButton] for opening the EFUI GitHub repo
  const OpenSourceButton(this.config, {super.key});

  @override
  Widget build(BuildContext context) => EzMenuLink(
        config,
        uri: Uri.parse('https://github.com/Empathetech-LLC/empathetech_flutter_ui'),
        icon: EzIcon(config, LineIcons.github),
        label: config.ezL10n.gOpenSource,
        semanticsLabel: '${config.ezL10n.gOpenSource}: ${config.ezL10n.gEFUISourceHint}',
      );
}
