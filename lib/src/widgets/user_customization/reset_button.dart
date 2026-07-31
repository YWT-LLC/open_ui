/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzResetButton extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Set to false for a 'Reset' [ElevatedButton.icon] label rather than 'Reset all'
  /// Also, when true there will be a local 'Reset all' switch
  /// When false, the current [EzCM.updateBoth] value is used
  final bool all;

  /// [EzAlertDialog.title] that shows on click
  final String Function()? dynamicTitle;

  /// [EzCM.reset] skip passthrough
  /// Moot if [onConfirm] is provided
  final Set<String>? resetSkip;

  /// [ezRichUndoWarning] passthrough
  final Set<String>? saveSkip;

  /// Override what happens when the user choses to reset
  /// Defaults to [EzCM.reset]
  /// DO NOT include an [EzCP.rebuildUI] or [Navigator.pop], these are included automatically
  final Future<void> Function()? onConfirm;

  /// Override what happens when the user choses not to reset
  /// DO NOT include a [Navigator.pop], it is included automatically
  final void Function()? onDeny;

  /// Optional [Icon.size] overwrite
  final double? iconSize;

  /// [EzElevatedIconButton] for clearing user settings
  const EzResetButton(
    this.config, {
    super.key,
    this.all = true,
    this.saveSkip,
    this.dynamicTitle,
    this.resetSkip,
    this.onConfirm,
    this.onDeny,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        config,
        style: ElevatedButton.styleFrom(
          backgroundColor: config.colors.surface.a < focusOpacity
              ? config.colors.surface.withValues(alpha: focusOpacity)
              : config.colors.surface,
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (_) {
            bool updateBoth = true;

            return StatefulBuilder(
              builder: (BuildContext dCon, StateSetter setDialog) => EzAlertDialog(
                config,
                title: Text(
                  dynamicTitle?.call() ?? config.ezL10n.ssResetAll,
                  textAlign: TextAlign.center,
                ),
                contents: all
                    ? <Widget>[
                        ezRichUndoWarning(config, context: context),
                        config.margin,
                        EzSwitchPair(
                          config,
                          key: ValueKey<String>('ubs-$updateBoth'),
                          value: updateBoth,
                          text: config.ezL10n.ssResetBoth,
                          onChanged: (bool? choice) {
                            if (choice == null) return;
                            setDialog(() => updateBoth = choice);
                          },
                        ),
                      ]
                    : <Widget>[ezRichUndoWarning(config, context: context)],
                actions: ezActionPair(
                  config,
                  onConfirm: () => config.rebuildUI(changes: () async {
                    if (onConfirm == null) {
                      await EzCM.reset(
                        config.isDark,
                        skip: resetSkip,
                        forceOne: !updateBoth,
                        forceBoth: updateBoth,
                      );
                    } else {
                      await onConfirm!.call();
                    }
                  }),
                  confirmIsDestructive: true,
                  onDeny: () {
                    if (onDeny == null) {
                      doNothing();
                    } else {
                      onDeny!.call();
                    }
                    if (dCon.mounted) Navigator.of(dCon).pop();
                  },
                ),
                needsClose: false,
              ),
            );
          },
        ),
        icon: Icon(
          Icons.refresh,
          size: iconSize ?? config.iconSize,
        ),
        label: all ? config.ezL10n.gResetAll : config.ezL10n.gReset,
      );
}
