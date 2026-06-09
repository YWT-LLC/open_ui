/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Mimics the [AppBar.leading] back button
/// But can also be used in [AppBar.actions] for left handed layouts
class EzBackAction extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  const EzBackAction(this.config, {super.key});

  @override
  Widget build(BuildContext context) => ezRootNav.currentState!.canPop()
      ? EzIconButton(
          config,
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: config.ezL10n.gBack,
          icon: Icon(
            Icons.arrow_back,
            semanticLabel: config.ezL10n.gBack,
            size: config.titleStyle!.fontSize,
          ),
        )
      : const SizedBox.shrink();
}
