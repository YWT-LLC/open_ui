/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzLocaleSetting extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [Locale]s to [skip]
  final Set<Locale>? skip;

  /// Set of [String] language codes you'd like to flip the flag
  final Set<String> inDistress;

  /// [EzElevatedIconButton] for updating the current [Locale]
  /// Opens a [BottomSheet] with a [EzElevatedIconButton] for each supported [Locale]
  const EzLocaleSetting(
    this.config, {
    super.key,
    this.skip,
    this.inDistress = const <String>{'US'},
  });

  @override
  State<EzLocaleSetting> createState() => _LocaleSettingState();
}

class _LocaleSettingState extends State<EzLocaleSetting> {
  // Init //

  @override
  void initState() {
    super.initState();
    locales = List<Locale>.from(OUILang.supportedLocales);

    if (widget.skip != null && widget.skip!.isNotEmpty) {
      locales.removeWhere((final Locale locale) => widget.skip!.contains(locale));
    }
  }

  // Return the build //

  late final List<Locale> locales;

  @override
  Widget build(BuildContext context) => Semantics(
        label: widget.config.ezL10n.ssLanguage,
        button: true,
        hint: widget.config.ezL10n.ssLangHint,
        child: ExcludeSemantics(
          child: EzElevatedIconButton(
            widget.config,
            onPressed: () => ezModal(
              widget.config,
              context: context,
              builder: (BuildContext mCon) => ezModalScroll(
                widget.config,
                children: <Widget>[
                  EzWrap(
                    children: locales
                        .map(
                          (Locale locale) => Padding(
                            padding: EzInsets.wrap(widget.config.spacing),
                            child: EzElevatedIconButton(
                              widget.config,
                              onPressed: () async {
                                // Check for no change
                                if (locale == widget.config.locale) {
                                  Navigator.of(mCon).pop();
                                  return;
                                }

                                // Gather && set data
                                final List<String> localeData = <String>[locale.languageCode];
                                if (locale.countryCode != null) {
                                  localeData.add(locale.countryCode!);
                                }
                                await EzCM.setStringList(appLocaleKey, localeData);

                                // Refresh the UI
                                await widget.config.rebuildLocale();
                              },
                              icon: ezFlag(
                                widget.config,
                                locale: locale,
                                inDistress: widget.inDistress.contains(locale.countryCode),
                              ),
                              label: ezLocaleName(locale, mCon),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  widget.config.spacer,
                ],
              ),
            ),
            icon: ezFlag(
              widget.config,
              locale: widget.config.locale,
              inDistress: widget.inDistress.contains(widget.config.locale.countryCode),
            ),
            label: widget.config.ezL10n.ssLanguage,
          ),
        ),
      );
}
