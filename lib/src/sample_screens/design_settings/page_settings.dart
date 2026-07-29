/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PageDesign extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Optional settings to add to the start of the sub-page
  final List<Widget>? prepend;

  final bool includeBackgroundImage;

  /// Optional settings to add to the end o the sub-page
  final List<Widget>? append;

  /// Defaults to [EzCP.separator]
  final Widget? resetSpacer;

  /// Optional extra keys to reset (when [EzCP.isDark])
  final Set<String>? resetExtraDark;

  /// Optional extra keys to reset (when ![EzCP.isDark])
  final Set<String>? resetExtraLight;

  /// Keys that shouldn't be reset by the local [EzResetButton]
  final Set<String>? resetSkip;

  /// Keys that shouldn't be saved by (save option in) the local [EzResetButton]
  final Set<String>? saveSkip;

  const PageDesign(
    this.config, {
    super.key,
    required this.prepend,
    this.includeBackgroundImage = true,
    required this.append,
    this.resetSpacer,
    required this.resetExtraDark,
    required this.resetExtraLight,
    required this.resetSkip,
    required this.saveSkip,
  });

  // Return the build //

  @override
  Widget build(BuildContext context) => EzCol(
        children: <Widget>[
          // Optional 'before' settings
          if (prepend != null) ...prepend!,

          // Margin
          EzMarginSetting(config),
          config.spacer,

          // Spacing
          EzSpacingSetting(config),

          // Background image
          if (includeBackgroundImage) ...<Widget>[
            config.spacer,
            EzScrollView(
              config,
              scrollDirection: Axis.horizontal,
              startCentered: true,
              child: config.isDark
                  ? EzImageSetting(
                      config,
                      pathKey: darkBackgroundImageKey,
                      fitKey: darkBackgroundFitKey,
                      sourceKey: darkBackgroundSourceKey,
                      label: config.ezL10n.dsBackgroundImg.replaceAll(' ', '\n'),
                    )
                  : EzImageSetting(
                      config,
                      pathKey: lightBackgroundImageKey,
                      fitKey: lightBackgroundFitKey,
                      sourceKey: darkBackgroundSourceKey,
                      label: config.ezL10n.dsBackgroundImg.replaceAll(' ', '\n'),
                    ),
            ),
          ],
          config.separator,

          // Page transition
          if (!kIsWeb) ...<Widget>[_PageTransitionSetting(config), config.spacer],

          // Animation duration
          _AnimDurSetting(config),

          // After background
          if (append != null) ...append!,

          // Reset button
          resetSpacer ?? config.separator,
          EzResetButton(
            config,
            all: false,
            dynamicTitle: () => config.ezL10n.dsResetPage(ezThemeString(config, bothable: true)),
            onConfirm: () async {
              if (EzCM.updateBoth || config.isDark) {
                await EzCM.removeKeys(<String>{
                  ...darkPageDesignKeys.keys.toSet(),
                  darkColorSchemeImageKey,
                });

                if (resetExtraDark != null) {
                  await EzCM.removeKeys(resetExtraDark!);
                }
              }

              if (EzCM.updateBoth || !config.isDark) {
                await EzCM.removeKeys(<String>{
                  ...lightPageDesignKeys.keys.toSet(),
                  lightColorSchemeImageKey,
                });

                if (resetExtraLight != null) {
                  await EzCM.removeKeys(resetExtraLight!);
                }
              }
            },
            resetSkip: resetSkip,
            saveSkip: saveSkip,
          ),
        ],
      );
}

class _AnimDurSetting extends StatelessWidget {
  final EzCP config;

  const _AnimDurSetting(this.config);

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        config,
        onPressed: () async {
          double animDuration = config.animDur.toDouble();
          EzAnimationCurve curve = EACConfig.safeLookup(
            EzCM.get(config.isDark ? darkAnimationCurveKey : lightAnimationCurveKey),
          );

          await ezModal(
            config,
            context: context,
            builder: (_) => StatefulBuilder(
              builder: (_, StateSetter setModal) => ezModalScroll(
                config,
                children: <Widget>[
                  // Preview
                  SizedBox(
                    key: ValueKey<String>('$animDuration:${curve.curve}'),
                    height: config.iconSize + (config.padding * 2),
                    child: _AnimationPreview(
                      config,
                      duration: animDuration.toInt(),
                      curve: curve.curve,
                    ),
                  ),
                  config.separator,

                  // Slider
                  Text(config.ezL10n.dsMilliseconds, style: config.bodyStyle),
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
                        if (EzCM.updateBoth || config.isDark) {
                          await EzCM.setInt(darkAnimationDurationKey, value.toInt());
                        }
                        if (EzCM.updateBoth || !config.isDark) {
                          await EzCM.setInt(lightAnimationDurationKey, value.toInt());
                        }
                      },
                    ),
                  ),
                  config.spacer,

                  // TODO: make a string + background? + ezdropdown class && use it EVERYWHERE
                  // notably: a scroll, rowMargin, and now flexible!
                  EzRow(
                    config,
                    children: <Widget>[
                      Flexible(child: Text(config.ezL10n.dsCurve, style: config.bodyStyle)),
                      config.margin,
                      EzDropdownMenu<EzAnimationCurve>(
                        config,
                        widthEntry: EzAnimationCurve.elastic.name(config.ezL10n),
                        dropdownMenuEntries: EzAnimationCurve.values
                            .map(
                              (EzAnimationCurve type) => DropdownMenuEntry<EzAnimationCurve>(
                                value: type,
                                label: type.name(config.ezL10n),
                              ),
                            )
                            .toList(),
                        enableSearch: false,
                        initialSelection: curve,
                        onSelected: (EzAnimationCurve? value) async {
                          if (value == null) return;

                          if (EzCM.updateBoth || config.isDark) {
                            await EzCM.setString(darkAnimationCurveKey, value.value);
                          }
                          if (EzCM.updateBoth || !config.isDark) {
                            await EzCM.setString(lightAnimationCurveKey, value.value);
                          }

                          setModal(() => curve = value);
                        },
                      ),
                    ],
                  ),
                  config.separator,

                  // Reset button
                  EzElevatedIconButton(
                    config,
                    onPressed: () async {
                      if (EzCM.updateBoth || config.isDark) {
                        await EzCM.remove(darkAnimationDurationKey);
                        await EzCM.remove(darkAnimationCurveKey);

                        animDuration =
                            (EzCM.getDefault(darkAnimationDurationKey) as int).toDouble();
                        curve = EACConfig.safeLookup(EzCM.getDefault(darkAnimationCurveKey));
                      }
                      if (EzCM.updateBoth || !config.isDark) {
                        await EzCM.remove(lightAnimationDurationKey);
                        await EzCM.remove(lightAnimationCurveKey);

                        animDuration =
                            (EzCM.getDefault(lightAnimationDurationKey) as int).toDouble();
                        curve = EACConfig.safeLookup(EzCM.getDefault(lightAnimationCurveKey));
                      }

                      setModal(() {});
                    },
                    icon: EzIcon(config, Icons.refresh),
                    label: config.ezL10n.gReset,
                  ),
                  config.separator,
                ],
              ),
            ),
          );

          if (animDuration != config.animDur.toDouble() || curve.curve != config.animCurve) {
            await config.rebuildUI(<EzCacheType>{EzCacheType.design});
          }
        },
        label: config.ezL10n.dsAnimStyle,
        icon: EzIcon(config, Icons.timer_outlined),
      );
}

class _AnimationPreview extends StatefulWidget {
  final EzCP config;
  final int duration;
  final Curve curve;

  const _AnimationPreview(this.config, {required this.duration, required this.curve});

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
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
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
              offset: Offset(xOffset * (widget.config.isLTR ? 1.0 : -1.0), 0),
              child: child,
            );
          },
          child: Center(
            child: EzIconButton(
              widget.config,
              onPressed: () =>
                  _controller.isAnimating ? _controller.stop() : _controller.forward(from: 0.0),
              icon: Icon(Icons.play_arrow, semanticLabel: widget.config.ezL10n.dsPlay),
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
  final EzCP config;

  const _PageTransitionSetting(this.config);

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        config,
        onPressed: () async {
          EzTransitionType currType = config.transitionType;
          bool currFade = config.fadedTransition;

          await ezModal(
            config,
            context: context,
            builder: (_) => StatefulBuilder(
              builder: (_, StateSetter setModal) => ezModalScroll(
                config,
                children: <Widget>[
                  // Type choices
                  RadioGroup<EzTransitionType>(
                    groupValue: currType,
                    onChanged: (EzTransitionType? choice) async {
                      if (choice == null) return;

                      if (EzCM.updateBoth || config.isDark) {
                        await EzCM.setString(darkTransitionTypeKey, choice.value);
                      }
                      if (EzCM.updateBoth || !config.isDark) {
                        await EzCM.setString(lightTransitionTypeKey, choice.value);
                      }

                      setModal(() => currType = choice);
                    },
                    child: EzScrollView(
                      config,
                      scrollDirection: Axis.horizontal,
                      thumbVisibility: false,
                      showScrollHint: true,
                      children: EzTransitionType.values
                          .map(
                            (EzTransitionType type) => Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: config.spacing,
                                horizontal: config.spacing / 2,
                              ),
                              child: EzCol(
                                children: <Widget>[
                                  EzTextButton(
                                    config,
                                    text: type.name(config.ezL10n),
                                    textStyle: config.labelStyle,
                                    textAlign: TextAlign.center,
                                    style: TextButton.styleFrom(
                                      backgroundColor: config.colors.surfaceContainer,
                                      padding: EdgeInsets.all(config.marginVal),
                                    ),
                                    onPressed: () async {
                                      if (EzCM.updateBoth || config.isDark) {
                                        await EzCM.setString(darkTransitionTypeKey, type.value);
                                      }
                                      if (EzCM.updateBoth || !config.isDark) {
                                        await EzCM.setString(lightTransitionTypeKey, type.value);
                                      }

                                      setModal(() => currType = type);
                                    },
                                  ),
                                  ExcludeSemantics(
                                    child: EzIconButton(
                                      config,
                                      icon: type.icon(config),
                                      onPressed: () async {
                                        if (EzCM.updateBoth || config.isDark) {
                                          await EzCM.setString(darkTransitionTypeKey, type.value);
                                        }
                                        if (EzCM.updateBoth || !config.isDark) {
                                          await EzCM.setString(lightTransitionTypeKey, type.value);
                                        }

                                        setModal(() => currType = type);
                                      },
                                    ),
                                  ),
                                  ExcludeSemantics(
                                    child: EzRadio<EzTransitionType>(config, value: type),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  config.spacer,

                  // Fade switch
                  EzSwitchPair(
                    config,
                    valueKey: config.isDark ? darkTransitionFadeKey : lightTransitionFadeKey,
                    text: config.ezL10n.dsFadeTransition,
                    afterChanged: (bool? choice) async {
                      if (choice == null) return;

                      if (EzCM.updateBoth) {
                        await EzCM.setBool(
                          config.isDark ? lightTransitionFadeKey : darkTransitionFadeKey,
                          choice,
                        );
                      }

                      setModal(() => currFade = choice);
                    },
                  ),
                  config.separator,
                ],
              ),
            ),
          );

          if (currType != config.transitionType || currFade != config.fadedTransition) {
            await config.rebuildUI(<EzCacheType>{EzCacheType.design});
          }
        },
        icon: EzIcon(config, Icons.slideshow),
        label: config.ezL10n.dsPageTransition,
      );
}
