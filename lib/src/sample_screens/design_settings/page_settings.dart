/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PageDesign extends StatelessWidget {
  /// Optional settings to add to the start of the sub-page
  final List<Widget>? prepend;

  final bool includeBackgroundImage;

  /// Optional settings to add to the end o the sub-page
  final List<Widget>? append;

  /// How much space between the settings and the local [EzResetButton]
  final Widget resetSpacer;

  /// Optional extra keys to reset (when [EzConfig.isDark])
  final Set<String>? resetExtraDark;

  /// Optional extra keys to reset (when ![EzConfig.isDark])
  final Set<String>? resetExtraLight;

  /// Keys that shouldn't be reset by the local [EzResetButton]
  final Set<String>? resetSkip;

  /// Keys that shouldn't be saved by (save option in) the local [EzResetButton]
  final Set<String>? saveSkip;

  const PageDesign({
    super.key,
    required this.prepend,
    this.includeBackgroundImage = true,
    required this.append,
    this.resetSpacer = const EzSeparator(),
    required this.resetExtraDark,
    required this.resetExtraLight,
    required this.resetSkip,
    required this.saveSkip,
  });

  // Return the build //

  @override
  Widget build(BuildContext context) => EzCol(children: <Widget>[
        // Optional 'before' settings
        if (prepend != null) ...prepend!,

        // Margin
        const EzMarginSetting(),
        EzConfig.spacer,

        // Spacing
        const EzSpacingSetting(),

        // Background image
        if (includeBackgroundImage) ...<Widget>[
          EzConfig.spacer,
          EzScrollView(
            scrollDirection: Axis.horizontal,
            startCentered: true,
            child: EzConfig.isDark
                ? EzImageSetting(
                    pathKey: darkBackgroundImageKey,
                    fitKey: darkBackgroundFitKey,
                    sourceKey: darkBackgroundSourceKey,
                    label: EzConfig.l10n.dsBackgroundImg.replaceAll(' ', '\n'),
                  )
                : EzImageSetting(
                    pathKey: lightBackgroundImageKey,
                    fitKey: lightBackgroundFitKey,
                    sourceKey: darkBackgroundSourceKey,
                    label: EzConfig.l10n.dsBackgroundImg.replaceAll(' ', '\n'),
                  ),
          ),
        ],
        EzConfig.separator,

        // Page transition
        if (!kIsWeb) ...<Widget>[
          const _PageTransitionSetting(),
          EzConfig.spacer,
        ],

        // Animation duration
        const _AnimDurSetting(),

        // After background
        if (append != null) ...append!,

        // Reset button
        resetSpacer,
        EzResetButton(
          all: false,
          dynamicTitle: () => EzConfig.l10n.dsResetPage(ezThemeString(true)),
          onConfirm: () async {
            if (EzConfig.updateBoth || EzConfig.isDark) {
              await EzConfig.removeKeys(<String>{
                ...darkPageDesignKeys.keys.toSet(),
                darkColorSchemeImageKey,
              });

              if (resetExtraDark != null) {
                await EzConfig.removeKeys(resetExtraDark!);
              }
            }

            if (EzConfig.updateBoth || !EzConfig.isDark) {
              await EzConfig.removeKeys(<String>{
                ...lightPageDesignKeys.keys.toSet(),
                lightColorSchemeImageKey,
              });

              if (resetExtraLight != null) {
                await EzConfig.removeKeys(resetExtraLight!);
              }
            }
          },
          resetSkip: resetSkip,
          saveSkip: saveSkip,
        ),
      ]);
}

class _AnimDurSetting extends StatelessWidget {
  const _AnimDurSetting();

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        onPressed: () async {
          double animDuration = EzConfig.animDur.toDouble();
          EzAnimationCurve curve = EACConfig.lookup(
              EzConfig.get(EzConfig.isDark ? darkAnimationCurveKey : lightAnimationCurveKey));

          await ezModal(
            context: context,
            builder: (_) => StatefulBuilder(
              builder: (_, StateSetter setModal) => ezModalScroll(<Widget>[
                // Preview
                SizedBox(
                  key: ValueKey<String>('$animDuration:${curve.curve}'),
                  height: EzConfig.iconSize + (EzConfig.padding * 2),
                  child: _AnimationPreview(animDuration.toInt(), curve.curve),
                ),
                EzConfig.separator,

                // Slider
                Text(
                  EzConfig.l10n.dsMilliseconds,
                  style: EzConfig.styles.bodyLarge,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
                  child: Slider(
                    value: animDuration,
                    min: minAnimationDuration.toDouble(),
                    max: maxAnimationDuration.toDouble(),
                    divisions: 20,
                    label: animDuration.toStringAsFixed(0),
                    onChanged: (double value) => setModal(() => animDuration = value),
                    onChangeEnd: (double value) async {
                      if (EzConfig.updateBoth || EzConfig.isDark) {
                        await EzConfig.setInt(darkAnimationDurationKey, value.toInt());
                      }

                      if (EzConfig.updateBoth || !EzConfig.isDark) {
                        await EzConfig.setInt(lightAnimationDurationKey, value.toInt());
                      }
                    },
                  ),
                ),
                EzConfig.spacer,

                EzRow(children: <Widget>[
                  Flexible(
                    child: Text(
                      EzConfig.l10n.dsCurve,
                      style: EzConfig.styles.bodyLarge,
                    ),
                  ),
                  EzConfig.margin,
                  EzDropdownMenu<EzAnimationCurve>(
                    widthEntry: EzAnimationCurve.elastic.name,
                    dropdownMenuEntries: EzAnimationCurve.values
                        .map((EzAnimationCurve type) => DropdownMenuEntry<EzAnimationCurve>(
                              value: type,
                              label: type.name,
                            ))
                        .toList(),
                    enableSearch: false,
                    initialSelection: curve,
                    onSelected: (EzAnimationCurve? value) async {
                      if (value == null) return;

                      if (EzConfig.updateBoth || EzConfig.isDark) {
                        await EzConfig.setString(darkAnimationCurveKey, value.value);
                      }
                      if (EzConfig.updateBoth || !EzConfig.isDark) {
                        await EzConfig.setString(lightAnimationCurveKey, value.value);
                      }

                      setModal(() => curve = value);
                    },
                  ),
                ]),
                EzConfig.separator,

                // Reset button
                EzElevatedIconButton(
                  onPressed: () async {
                    if (EzConfig.updateBoth || EzConfig.isDark) {
                      await EzConfig.remove(darkAnimationDurationKey);
                      await EzConfig.remove(darkAnimationCurveKey);

                      animDuration =
                          (EzConfig.getDefault(darkAnimationDurationKey) as int).toDouble();
                      curve = EACConfig.lookup(EzConfig.getDefault(darkAnimationCurveKey));
                    }
                    if (EzConfig.updateBoth || !EzConfig.isDark) {
                      await EzConfig.remove(lightAnimationDurationKey);
                      await EzConfig.remove(lightAnimationCurveKey);

                      animDuration =
                          (EzConfig.getDefault(lightAnimationDurationKey) as int).toDouble();
                      curve = EACConfig.lookup(EzConfig.getDefault(lightAnimationCurveKey));
                    }

                    setModal(() {});
                  },
                  icon: const Icon(Icons.refresh),
                  label: EzConfig.l10n.gReset,
                ),
                EzConfig.separator,
              ]),
            ),
          );

          if (animDuration != EzConfig.animDur.toDouble() || curve.curve != EzConfig.animCurve) {
            await EzConfig.rebuildUI();
          }
        },
        label: EzConfig.l10n.dsAnimStyle,
        icon: const Icon(Icons.timer_outlined),
      );
}

class _AnimationPreview extends StatefulWidget {
  final int duration;
  final Curve curve;

  const _AnimationPreview(this.duration, this.curve);

  @override
  State<_AnimationPreview> createState() => _AnimationPreviewState();
}

class _AnimationPreviewState extends State<_AnimationPreview> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  // Init //

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  @override
  void didUpdateWidget(covariant _AnimationPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = Duration(milliseconds: widget.duration);
    }
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, BoxConstraints constraints) => AnimatedBuilder(
          animation: _animation,
          builder: (_, Widget? child) {
            double xOffset;
            final double value = _animation.value;
            final double halfWidth = constraints.maxWidth / 2;

            if (value < 0.5) {
              // Center to edge
              final double progress = value * 2;
              xOffset = progress * halfWidth;
            } else {
              // Opposite edge to center
              final double progress = (value - 0.5) * 2;
              xOffset = -halfWidth + (progress * halfWidth);
            }

            return Transform.translate(
              offset: Offset(xOffset * (EzConfig.isLTR ? 1.0 : -1.0), 0),
              child: child,
            );
          },
          child: Center(
            child: EzIconButton(
              onPressed: () =>
                  _controller.isAnimating ? _controller.stop() : _controller.forward(from: 0.0),
              icon: Icon(
                Icons.play_arrow,
                semanticLabel: EzConfig.l10n.dsPlay,
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _PageTransitionSetting extends StatelessWidget {
  const _PageTransitionSetting();

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        onPressed: () async {
          final EzTransitionType backupType = EzConfig.transitionType;
          final bool backupFade = EzConfig.fadedTransition;

          EzTransitionType currType = backupType;
          bool currFade = backupFade;

          await ezModal(
            context: context,
            builder: (_) => StatefulBuilder(
              builder: (_, StateSetter setModal) => EzCol(children: <Widget>[
                // Type choices
                RadioGroup<EzTransitionType>(
                  groupValue: currType,
                  onChanged: (EzTransitionType? choice) {
                    if (choice != null) setModal(() => currType = choice);
                  },
                  child: EzScrollView(
                    scrollDirection: Axis.horizontal,
                    thumbVisibility: false,
                    showScrollHint: true,
                    children: EzTransitionType.values
                        .map(
                          (EzTransitionType type) => Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: EzConfig.spacing,
                              horizontal: EzConfig.spacing / 2,
                            ),
                            child: EzCol(children: <Widget>[
                              EzTextButton(
                                text: type.name,
                                textStyle: EzConfig.styles.labelLarge,
                                textAlign: TextAlign.center,
                                style: TextButton.styleFrom(
                                  backgroundColor: EzConfig.colors.surfaceContainer,
                                  padding: EzInsets.wrap(EzConfig.marginVal),
                                ),
                                onPressed: () => setModal(() => currType = type),
                              ),
                              ExcludeSemantics(
                                child: EzIconButton(
                                  icon: type.icon,
                                  onPressed: () => setModal(() => currType = type),
                                ),
                              ),
                              ExcludeSemantics(
                                child: EzRadio<EzTransitionType>(value: type),
                              ),
                            ]),
                          ),
                        )
                        .toList(),
                  ),
                ),
                EzConfig.spacer,

                // Fade switch
                EzSwitchPair(
                  valueKey: EzConfig.isDark ? darkTransitionFadeKey : lightTransitionFadeKey,
                  afterChanged: (bool? choice) {
                    if (choice != null) setModal(() => currFade = choice);
                  },
                  text: EzConfig.l10n.dsFadeTransition,
                ),
                EzConfig.separator,
              ]),
            ),
          );

          bool needsRebuild = false;

          if (currType != backupType) {
            if (EzConfig.updateBoth || EzConfig.isDark) {
              await EzConfig.setString(darkTransitionTypeKey, currType.value);
            }
            if (EzConfig.updateBoth || !EzConfig.isDark) {
              await EzConfig.setString(lightTransitionTypeKey, currType.value);
            }
            needsRebuild = true;
          }

          if (currFade != backupFade) {
            if (EzConfig.updateBoth || EzConfig.isDark) {
              await EzConfig.setBool(darkTransitionFadeKey, currFade);
            }
            if (EzConfig.updateBoth || !EzConfig.isDark) {
              await EzConfig.setBool(lightTransitionFadeKey, currFade);
            }
            needsRebuild = true;
          }

          if (needsRebuild) await EzConfig.rebuildUI();
        },
        icon: const Icon(Icons.slideshow),
        label: EzConfig.l10n.dsPageTransition,
      );
}
