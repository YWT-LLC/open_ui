/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

class EzSettingsHub extends StatefulWidget {
  final EzCP config;

  /// Where the magic happens
  final List<EzSettingsSection> pages;

  /// Optional starting point (default 0/last visited)
  final int? target;

  /// Settings landing page
  const EzSettingsHub(
    this.config, {
    super.key,
    required this.pages,
    this.target,
  });

  @override
  State<EzSettingsHub> createState() => _EzSettingsHubState();
}

class _EzSettingsHubState extends State<EzSettingsHub> {
  // Define the build data //

  int delta = 0;

  late int startingPos = widget.target ?? EzCM.hubPos;
  late EzSettingsSection currSection;
  late EzSubSetting currSubSec;

  // Init //

  @override
  void initState() {
    super.initState();

    if (startingPos > widget.pages.length || startingPos < 0) startingPos = 0;
    currSection = widget.pages[startingPos];
    currSubSec = currSection.fromStorage();
  }

  // Return the build //

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
          EzSegmentedButton<EzSettingsSection>(
            widget.config,
            segments: widget.pages
                .map((EzSettingsSection type) =>
                    ButtonSegment<EzSettingsSection>(value: type, icon: type.icon))
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
                ? EzCol(
                    children: <Widget>[
                      widget.config.margin,
                      EzScrollView(
                        widget.config,
                        scrollDirection: Axis.horizontal,
                        reverseHands: true,
                        showScrollHint: true,
                        children: <Widget>[
                          // Subsection selector
                          EzSegmentedButton<EzSubSetting>(
                            widget.config,
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
                      EzDivider(widget.config, height: widget.config.spacing),
                      widget.config.spacer,
                    ],
                  )
                : const SizedBox.shrink(),
          ),

          // Current section
          EzFauxCarousel(
            widget.config,
            position: currSection.position,
            delta: delta,
            child: currSection.build(currSubSec),
          ),
          widget.config.separator,
        ],
      );
}
