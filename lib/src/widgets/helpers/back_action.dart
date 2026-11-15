/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

/// Mimics the [AppBar.leading] back button
/// But can also be used in [AppBar.actions] for left handed layouts
class EzBackAction extends StatelessWidget {
  final EzCP config;

  const EzBackAction(this.config, {super.key});

  @override
  Widget build(BuildContext context) => (ezRootNav.currentState?.canPop() ?? false)
      ? EzIconTouch(
          config,
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: config.ezL10n.gBack,
          icon: Icons.arrow_back,
          iconSize: config.titleStyle!.fontSize,
          backgroundFill: config.surfaceDimFiller,
        )
      : const SizedBox.shrink();
}
