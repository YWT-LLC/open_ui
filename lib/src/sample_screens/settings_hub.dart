/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSettingsHub extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Where the magic happens
  final List<EzSettingsSection> pages;

  /// Optional starting point
  /// Defaults to 0/first
  final int? target;

  /// Empathetech settings landing page
  const EzSettingsHub(this.config, {super.key, required this.pages, this.target});

  @override
  State<EzSettingsHub> createState() => _EzSettingsHubState();
}

class _EzSettingsHubState extends State<EzSettingsHub> {
  late EzSettingsSection currSection = widget.pages[widget.target ?? EzCM.hubPos];
  late EzSubSetting currSubSec = currSection.fromStorage();
  int delta = 0;

  @override
  Widget build(BuildContext context) => EzScrollView(
        widget.config,
        children: <Widget>[
          // Section nav
          EzText(
            widget.config,
            text: currSection.title,
            style: widget.config.labelStyle,
            textAlign: TextAlign.center,
          ),
          SegmentedButton<EzSettingsSection>(
            segments: widget.pages
                .map((EzSettingsSection type) => ButtonSegment<EzSettingsSection>(
                      value: type,
                      icon: type.icon,
                    ))
                .toList(),
            selected: <EzSettingsSection>{currSection},
            showSelectedIcon: false,
            onSelectionChanged: (Set<EzSettingsSection> selected) async {
              final EzSettingsSection choice = selected.first;
              delta = choice.position - currSection.position;

              await EzCM.setHubPos(choice.position);

              currSection = choice;
              currSubSec = choice.fromStorage();
              setState(() {});
            },
          ),

          // Sub-section nav (&& divider)
          EzAnimSwitch(
            // Don't use AnimVis, breaks on Global settings
            widget.config,
            mod: 0.75,
            forceType: EzTransitionType.slideY,
            forceFade: true,
            reverse: true,
            child: currSection.subSettings.isNotEmpty
                ? EzCol(children: <Widget>[
                    widget.config.margin,
                    EzScrollView(
                      widget.config,
                      scrollDirection: Axis.horizontal,
                      reverseHands: true,
                      showScrollHint: true,
                      children: <Widget>[
                        // Quick/Advanced selector
                        SegmentedButton<EzSubSetting>(
                          segments: (currSection.subSettings)
                              .map((EzSubSetting sub) => ButtonSegment<EzSubSetting>(
                                    value: sub,
                                    label: Text(sub.label(widget.config.ezL10n)),
                                  ))
                              .toList(),
                          selected: <EzSubSetting>{currSubSec},
                          showSelectedIcon: false,
                          onSelectionChanged: (Set<EzSubSetting> selected) async {
                            final EzSubSetting choice = selected.first;

                            await EzCM.setBool(choice.write.$1, choice.write.$2);
                            setState(() => currSubSec = choice);
                          },
                        ),

                        // Update both toggle
                        widget.config.rowMargin,
                        EzThemeCoin(widget.config, enabled: currSubSec.bothable),
                      ],
                    ),
                    EzDivider(widget.config.spacing),
                    widget.config.spacer,
                  ])
                : const SizedBox.shrink(),
          ),

          // Current section
          EzFauxCarousel(
            widget.config,
            position: currSection.position,
            delta: delta,
            child: currSection.build(currSubSec),
          ),
          EzFooter(widget.config),
        ],
      );
}
