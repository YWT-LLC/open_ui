/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class FailureHeader extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Core [Text] to display... under 'Failure'
  /// Provide [message] OR [richMessage]
  final String? message;

  /// Core [Text.rich] to display... under 'Failure'
  /// Provide [message] OR [richMessage]
  final EzRichText? richMessage;

  /// header [Widget] for a failed run
  const FailureHeader(
    this.config, {
    super.key,
    this.message,
    this.richMessage,
  }) : assert(
          (message == null) != (richMessage == null),
          'Either message or richMessage must be provided, not both',
        );

  @override
  Widget build(BuildContext context) => EzCol(children: <Widget>[
        // Headline
        Flexible(
          child: EzText(
            config,
            text: config.ezL10n.gFailure,
            style: config.headlineStyle,
            textAlign: TextAlign.center,
          ),
        ),
        config.spacer,

        // Error message
        message != null
            ? Flexible(
                child: EzText(
                  config,
                  text: message!,
                  style: ezSubTitleStyle(config.styles),
                  textAlign: TextAlign.center,
                ),
              )
            : richMessage!,
      ]);
}

class DeleteOption extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Directory that will be rm -rf'd
  final String appName;

  /// Directory to run the rm command in
  final String dir;

  /// [TextStyle] for 'would you like to...'
  final TextStyle? style;

  /// Optional [ezCmd] readout passthrough
  final ValueNotifier<String>? readout;

  /// Iterable [Widget] containing a [EzElevatedIconButton] for wiping the partial build
  const DeleteOption(
    this.config, {
    super.key,
    required this.appName,
    required this.dir,
    required this.style,
    this.readout,
  });

  @override
  Widget build(BuildContext context) => EzCol(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Would you like to...
          EzText(
            config,
            text: l10n(config).rsWouldYou,
            style: style,
            textAlign: TextAlign.center,
          ),
          config.spacer,

          // Wipe it
          EzElevatedIconButton(
            config,
            onPressed: () => ezCmd(
              EzCM.platform == TargetPlatform.windows ? 'rmdir /s /q $appName' : 'rm -rf $appName',
              dir: dir,
              onSuccess: () async {
                await ezSnackBar(config, context: context, message: l10n(config).rsNextTime).closed;
                if (context.mounted) await Navigator.of(context).maybePop();
              },
              onFailure: (String message) async {
                await ezSnackBar(config, context: context, message: l10n(config).rsAnotherOne)
                    .closed;
                if (context.mounted) await Navigator.of(context).maybePop();
              },
              readout: readout,
            ),
            icon: EzIcon(config, Icons.delete),
            label: l10n(config).rsWipe,
          ),
          config.spacer,

          // Leave
          EzElevatedIconButton(
            config,
            onPressed: () => Navigator.of(context).pop(),
            icon: EzIcon(config, Icons.arrow_back),
            label: l10n(config).rsLeave,
          ),
        ],
      );
}

class LinkOption extends StatelessWidget {
  final EzCP config;

  /// Iterable [Widget] containing a [EzElevatedIconButton] for wiping the partial build
  const LinkOption(this.config, {super.key});

  @override
  Widget build(BuildContext context) => EzCol(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          EzText(
            config,
            text: l10n(config).rsWouldYou,
            style: ezSubTitleStyle(config.styles),
            textAlign: TextAlign.center,
          ),
          config.spacer,
          EzElevatedIconLink(
            config,
            url: Uri.parse(installFlutter),
            tooltip: installFlutter,
            hint: l10n(config).rsInstallHint,
            icon: EzIcon(config, Icons.computer),
            label: l10n(config).rsInstall,
          ),
        ],
      );
}
