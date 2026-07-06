/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EzThemeCoin extends StatefulWidget {
  final EzCP config;
  final bool enabled;

  /// [EzIconButton] for toggling [EzCM.updateBoth]
  const EzThemeCoin(this.config, {super.key, this.enabled = true});

  @override
  State<EzThemeCoin> createState() => _EzThemeCoinState();
}

class _EzThemeCoinState extends State<EzThemeCoin> {
  bool both = EzCM.updateBoth;

  @override
  Widget build(BuildContext context) {
    final String editing = widget.config.ezL10n.gEditing +
        (both
            ? widget.config.ezL10n.gBothThemes
            : (widget.config.isDark
                ? widget.config.ezL10n.gDarkTheme
                : widget.config.ezL10n.gLightTheme));
    final String reverse = both
        ? (widget.config.isDark
            ? '${widget.config.ezL10n.gThe} ${widget.config.ezL10n.gDarkTheme.toLowerCase()}'
            : '${widget.config.ezL10n.gThe} ${widget.config.ezL10n.gLightTheme.toLowerCase()}')
        : widget.config.ezL10n.gBothThemes;

    return Semantics(
      button: true,
      hint: '$editing. ${widget.config.ezL10n.gEditingHint} $reverse.',
      child: ExcludeSemantics(
        child: EzIconButton(
          widget.config,
          enabled: widget.enabled,
          icon: (widget.enabled && both)
              ? const FaIcon(FontAwesomeIcons.yinYang)
              : Icon(widget.config.isDark ? Icons.dark_mode : Icons.light_mode),
          onPressed: () async {
            await EzCM.setBool(updateBothKey, !both);
            setState(() => both = !both);
          },
          onLongPress: () async {
            await EzCM.setBool(isDarkThemeKey, !widget.config.isDark);
            await widget.config.rebuildThemeMode();
          },
          tooltip: editing,
        ),
      ),
    );
  }
}
