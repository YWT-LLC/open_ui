/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class EzVideoPlayer extends StatefulWidget {
  /// [VideoPlayerController] passthrough
  final VideoPlayerController controller;

  /// [String] label for screen readers
  final String semantics;

  /// [AspectRatio.aspectRatio] for the video
  final double aspectRatio;

  /// [BoxConstraints.maxHeight] for the video
  final double maxHeight;

  /// [BoxConstraints.maxWidth] for the video
  final double maxWidth;

  /// Whether the video player is in fullscreen mode
  final bool fullscreen;

  /// Whether the video has captions available
  final bool hasCaptions;

  /// Seconds to skip forward/backward on arrow key press
  final int skipTime;

  /// Initial playback speed
  final double speed;

  /// Include volume controls
  final bool hasAudio;

  /// Starting volume
  final double startingVolume;

  /// Amount of seconds the controls should show on mobile after user interaction
  final int mobileDelay;

  /// Whether the video should begin upon initialization
  final bool autoPlay;

  /// Whether the video should replay when complete
  final bool autoLoop;

  /// An Empathetech video player
  const EzVideoPlayer({
    super.key,
    required this.controller,
    required this.semantics,
    required this.aspectRatio,
    required this.maxHeight,
    required this.maxWidth,
    this.fullscreen = false,
    this.hasCaptions = false,
    this.skipTime = 10,
    this.speed = 1.0,
    this.hasAudio = true,
    this.startingVolume = 0.0,
    this.mobileDelay = 3,
    this.autoPlay = true,
    this.autoLoop = false,
  });

  @override
  State<EzVideoPlayer> createState() => _EzVideoPlayerState();
}

class _EzVideoPlayerState extends State<EzVideoPlayer> {
  // Define the build data //

  late final int videoLength = widget.controller.value.duration.inMilliseconds;
  bool hovering = false;
  Timer? mobileHover;

  late double currSpeed = widget.speed;

  double? savedVolume;
  Timer? showVolume;

  bool showCaptions = false;
  final MenuController subMenuControl = MenuController();
  int captionStyle = 1;

  bool twinRunning = false;

  // Define custom functions //

  void handleMobileHover() {
    if (!EzConfig.onMobile) return;

    mobileHover?.cancel();
    if (!hovering) setState(() => hovering = true);

    mobileHover = Timer(
      Duration(seconds: widget.mobileDelay),
      () => setState(() => hovering = false),
    );
  }

  Future<void> play(VideoPlayerValue value) async {
    if (value.isCompleted) await widget.controller.seekTo(Duration.zero);
    await widget.controller.play();
    handleMobileHover();
  }

  Future<void> pause() async {
    await widget.controller.pause();
    handleMobileHover();
  }

  Future<void> mute(VideoPlayerValue value) async {
    savedVolume = value.volume;
    await widget.controller.setVolume(0.0);
    handleMobileHover();
  }

  Future<void> unMute() async {
    await widget.controller.setVolume(savedVolume ?? 1.0);
    handleMobileHover();
  }

  Future<void> skipForward(VideoPlayerValue value) =>
      widget.controller.seekTo(value.position + Duration(seconds: widget.skipTime));

  Future<void> skipBackward(VideoPlayerValue value) =>
      widget.controller.seekTo(value.position - Duration(seconds: widget.skipTime));

  void showVolumeLabel() {
    showVolume?.cancel();
    showVolume = Timer(
      const Duration(milliseconds: 500),
      () => showVolume?.cancel(),
    );
  }

  /// Get the percent of the total video that is complete from the passed [Duration]
  double pComplete(Duration position) {
    return (position.isNegative || position.inMilliseconds == 0)
        ? 0
        : position.inMilliseconds / videoLength;
  }

  /// Get the [Duration] value that corresponds to the passed [completion]
  Duration findP(double completion) => completion >= 1
      ? Duration(milliseconds: videoLength)
      : Duration(milliseconds: (videoLength * completion).round());

  Future<void> enterFullscreen() async {
    await pause();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    if (widget.aspectRatio >= 1.0) {
      await SystemChrome.setPreferredOrientations(
        const <DeviceOrientation>[
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
      );
    } else {
      await SystemChrome.setPreferredOrientations(
        const <DeviceOrientation>[DeviceOrientation.portraitUp],
      );
    }

    setState(() => twinRunning = true);
    if (mounted) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Center(
                child: EzVideoPlayer(
                  controller: widget.controller,
                  semantics: widget.semantics,
                  aspectRatio: widget.aspectRatio,
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  fullscreen: true,
                  hasCaptions: widget.hasCaptions,
                  skipTime: widget.skipTime,
                  speed: currSpeed,
                  hasAudio: widget.hasAudio,
                  startingVolume: widget.controller.value.volume,
                  mobileDelay: widget.mobileDelay,
                  autoPlay: false,
                  autoLoop: widget.autoLoop,
                ),
              ),
            ),
          ),
        ),
      );
    }
    if (mounted) setState(() => twinRunning = false);

    await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge); // TODO: whatever the base app is using
    await SystemChrome.setPreferredOrientations(
      const <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ], // TODO: whatever the base app is using
    );
  }

  // Init //

  @override
  void initState() {
    super.initState();
    setupVideo();
  }

  Future<void> setupVideo() async {
    await widget.controller.setVolume(widget.startingVolume);
    await widget.controller.setPlaybackSpeed(widget.speed);
    await widget.controller.setLooping(widget.autoLoop);

    if (!widget.controller.value.isInitialized) {
      await widget.controller.initialize();
    }

    if (widget.autoPlay) await play(widget.controller.value);
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final double controlsHeight =
        (3 * EzConfig.marginVal + 2 * (EzConfig.iconSize + EzConfig.padding));

    final TextStyle? labelStyle = EzConfig.styles.labelLarge?.copyWith(color: Colors.white);

    final SliderThemeData sliderTheme = SliderThemeData(
      activeTrackColor: EzConfig.colors.secondary,
      inactiveTrackColor: halfWhite,
      thumbColor: EzConfig.colors.primary,
    );

    // Return the build //

    return Semantics(
      label: widget.semantics,
      child: ValueListenableBuilder<VideoPlayerValue>(
        valueListenable: widget.controller,
        builder: (_, VideoPlayerValue value, __) => Focus(
          autofocus: true,
          onKeyEvent: (_, KeyEvent event) {
            if (event is KeyDownEvent) {
              switch (event.logicalKey) {
                // Up/Down -> volume control (if relevant)
                case LogicalKeyboardKey.arrowUp:
                  if (widget.hasAudio) {
                    double newVol = value.volume + 0.05;
                    if (newVol > 1.0) newVol = 1.0;

                    widget.controller.setVolume(newVol);
                    showVolumeLabel();
                  }
                  return KeyEventResult.handled;
                case LogicalKeyboardKey.arrowDown:
                  if (widget.hasAudio) {
                    double newVol = value.volume - 0.05;
                    if (newVol < 0.0) newVol = 0.0;

                    widget.controller.setVolume(newVol);
                    showVolumeLabel();
                  }
                  return KeyEventResult.handled;

                // Left/Right -> time skip
                case LogicalKeyboardKey.arrowRight:
                  skipForward(value);
                  return KeyEventResult.handled;
                case LogicalKeyboardKey.arrowLeft:
                  skipBackward(value);
                  return KeyEventResult.handled;

                // Space -> play/pause
                case LogicalKeyboardKey.space:
                  value.isPlaying ? pause() : play(value);
                  return KeyEventResult.handled;

                // C -> captions toggle (if relevant)
                case LogicalKeyboardKey.keyC:
                  if (widget.hasCaptions) {
                    setState(() => showCaptions = !showCaptions);
                    return KeyEventResult.handled;
                  } else {
                    return KeyEventResult.ignored;
                  }

                // F -> enter fullscreen (if not already)
                case LogicalKeyboardKey.keyF:
                  if (!widget.fullscreen) enterFullscreen();

                // Esc -> exit fullscreen (if relevant)
                case LogicalKeyboardKey.escape:
                  if (widget.fullscreen) {
                    Navigator.of(context).pop(widget.controller.value.position);
                  }

                default:
                  return KeyEventResult.ignored;
              }
            }
            return KeyEventResult.ignored;
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => hovering = true),
            onExit: (_) => setState(() => hovering = false),
            child: Stack(
              fit: StackFit.passthrough,
              clipBehavior: Clip.none,
              children: <Widget>[
                // Video
                ExcludeSemantics(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: widget.maxHeight,
                      maxWidth: widget.maxWidth,
                    ),
                    color: Colors.black,
                    child: AspectRatio(
                      aspectRatio: widget.aspectRatio,
                      child: twinRunning ? const SizedBox.shrink() : VideoPlayer(widget.controller),
                    ),
                  ),
                ),

                // Volume label (shows on arrow up/down)
                Positioned(
                  left: 0,
                  right: 0,
                  top: EzConfig.spacing * 2,
                  child: EzAnimVis(
                    mod: 0.5,
                    visible: showVolume?.isActive == true,
                    forceType: EzTransitionType.none,
                    forceFade: true,
                    kid: ExcludeSemantics(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Row seems weird, but it prevents the Text from auto-expanding
                          EzText(
                            '${(value.volume * 100).toStringAsFixed(0)}%',
                            style: switch (captionStyle) {
                              4 => EzConfig.styles.displayLarge?.copyWith(color: Colors.white),
                              3 => EzConfig.styles.headlineLarge?.copyWith(color: Colors.white),
                              2 => EzConfig.styles.titleLarge?.copyWith(color: Colors.white),
                              1 => EzConfig.styles.bodyLarge?.copyWith(color: Colors.white),
                              _ => labelStyle,
                            },
                            textAlign: TextAlign.center,
                            backgroundColor: halfBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Layer for taps, gestures, and key events
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: controlsHeight,
                  child: ExcludeSemantics(
                    child: GestureDetector(
                      onTap: () async {
                        if (EzConfig.onMobile) {
                          mobileHover?.cancel();

                          hovering ? setState(() => hovering = false) : handleMobileHover();
                        } else {
                          value.isPlaying ? await pause() : await play(value);
                        }
                      },
                      onDoubleTapDown: (TapDownDetails tap) async {
                        final RenderBox mySpace = context.findRenderObject() as RenderBox;

                        (tap.localPosition.dx < mySpace.size.width / 2)
                            ? await skipBackward(value)
                            : await skipForward(value);
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),

                // Captions
                if (showCaptions)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom:
                        (hovering || subMenuControl.isOpen) ? controlsHeight : EzConfig.marginVal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Row seems weird, but it prevents the Text from auto-expanding
                        ExcludeSemantics(
                          child: EzText(
                            value.caption.text,
                            style: switch (captionStyle) {
                              4 => EzConfig.styles.displayLarge?.copyWith(color: Colors.white),
                              3 => EzConfig.styles.headlineLarge?.copyWith(color: Colors.white),
                              2 => EzConfig.styles.titleLarge?.copyWith(color: Colors.white),
                              1 => EzConfig.styles.bodyLarge?.copyWith(color: Colors.white),
                              _ => labelStyle,
                            },
                            textAlign: TextAlign.center,
                            backgroundColor: halfBlack,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Controls
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: controlsHeight,
                  child: EzAnimVis(
                    mod: 0.5,
                    visible: hovering || subMenuControl.isOpen || !value.isPlaying,
                    forceType: EzTransitionType.none,
                    forceFade: true,
                    kid: Container(
                      decoration: const BoxDecoration(color: halfBlack),
                      child: EzCol(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Time seeker
                          SizedBox(
                            height: EzConfig.iconSize,
                            width: double.infinity,
                            child: SliderTheme(
                              data: sliderTheme,
                              child: Slider(
                                value: pComplete(value.position),
                                onChangeStart: (_) async {
                                  await pause();
                                  if (EzConfig.onMobile) {
                                    mobileHover?.cancel();
                                  }
                                },
                                onChanged: (double value) => widget.controller.seekTo(findP(value)),
                                onChangeEnd: (_) async {
                                  await play(value);
                                  handleMobileHover();
                                },
                              ),
                            ),
                          ),
                          EzConfig.margin,

                          // Buttons
                          NotificationListener<ScrollNotification>(
                            onNotification: (_) {
                              handleMobileHover();
                              return false;
                            },
                            child: EzScrollView(
                              scrollDirection: Axis.horizontal,
                              showScrollHint: true,
                              children: <Widget>[
                                EzConfig.rowSpacer,

                                // Play/pause
                                Padding(
                                  padding: EdgeInsets.only(right: EzConfig.spacing),
                                  child: value.isPlaying
                                      ? EzIconButton(
                                          onPressed: pause,
                                          tooltip: EzConfig.l10n.gPause,
                                          icon: EzIcon(Icons.pause),
                                        )
                                      : EzIconButton(
                                          onPressed: () => play(value),
                                          tooltip: EzConfig.l10n.gPlay,
                                          icon: EzIcon(
                                              value.isCompleted ? Icons.replay : Icons.play_arrow),
                                        ),
                                ),

                                // Volume toggle
                                if (widget.hasAudio) ...<Widget>[
                                  (value.volume == 0.0)
                                      ? EzIconButton(
                                          onPressed: unMute,
                                          tooltip: EzConfig.l10n.gUnMute,
                                          icon: EzIcon(Icons.volume_mute),
                                        )
                                      : EzIconButton(
                                          onPressed: () => mute(value),
                                          tooltip: EzConfig.l10n.gMute,
                                          icon: EzIcon(Icons.volume_up),
                                        ),

                                  // Volume slider
                                  Padding(
                                    padding: EdgeInsets.only(right: EzConfig.spacing),
                                    child: SizedBox(
                                      height: EzConfig.iconSize,
                                      width: 100,
                                      child: SliderTheme(
                                        data: sliderTheme,
                                        child: Slider(
                                          value: value.volume,
                                          onChangeStart: (_) {
                                            if (EzConfig.onMobile) {
                                              mobileHover?.cancel();
                                            }
                                          },
                                          onChanged: (double value) =>
                                              widget.controller.setVolume(value),
                                          onChangeEnd: (_) => handleMobileHover(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],

                                // Time label
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: EzConfig.spacing,
                                  ),
                                  child: Text(
                                    '${ezVideoTime(value.position)} / ${ezVideoTime(value.duration)}',
                                    style: labelStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                // Playback speed selector
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: EzConfig.spacing,
                                  ),
                                  child: EzRow(
                                    reverseHands: false,
                                    children: <Widget>[
                                      EzIconButton(
                                        enabled: currSpeed > 0.25,
                                        onPressed: () async {
                                          setState(() => currSpeed -= 0.25);
                                          await widget.controller.setPlaybackSpeed(currSpeed);
                                          handleMobileHover();
                                        },
                                        tooltip:
                                            '${EzConfig.l10n.gDecrease} ${EzConfig.l10n.gPlaybackSpeed.toLowerCase()}',
                                        icon: EzIcon(Icons.remove),
                                      ),
                                      EzConfig.rowMargin,
                                      Tooltip(
                                        message: EzConfig.l10n.gPlaybackSpeed,
                                        child: EzCol(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.speed,
                                              size: EzConfig.iconSize * 0.75,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              currSpeed.toStringAsFixed(2),
                                              style: labelStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      EzConfig.rowMargin,
                                      EzIconButton(
                                        enabled: currSpeed < 2.0,
                                        onPressed: () async {
                                          setState(() => currSpeed += 0.25);
                                          await widget.controller.setPlaybackSpeed(currSpeed);
                                          handleMobileHover();
                                        },
                                        tooltip:
                                            '${EzConfig.l10n.gIncrease} ${EzConfig.l10n.gPlaybackSpeed.toLowerCase()}',
                                        icon: EzIcon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),

                                // Captions
                                if (widget.hasCaptions)
                                  Padding(
                                    padding: EdgeInsets.only(right: EzConfig.spacing),
                                    child: MenuAnchor(
                                      controller: subMenuControl,
                                      builder: (_, __, ___) => EzIconButton(
                                        onPressed: () => subMenuControl.isOpen
                                            ? subMenuControl.close()
                                            : setState(() => showCaptions = !showCaptions),
                                        onLongPress: () => subMenuControl.isOpen
                                            ? subMenuControl.close()
                                            : subMenuControl.open(),
                                        tooltip:
                                            '${EzConfig.l10n.gCaptions}\n${EzConfig.l10n.gCaptionsHint}',
                                        fauxDisabled: !showCaptions,
                                        icon: EzIcon(Icons.subtitles),
                                      ),
                                      menuChildren: <Widget>[
                                        EzMenuButton(
                                          label: EzConfig.l10n.tsDisplay,
                                          textStyle: EzConfig.styles.displayLarge,
                                          textAlign: TextAlign.center,
                                          onPressed: () => setState(() => captionStyle = 4),
                                        ),
                                        EzMenuButton(
                                          label: EzConfig.l10n.tsHeadline,
                                          textStyle: EzConfig.styles.headlineLarge,
                                          textAlign: TextAlign.center,
                                          onPressed: () => setState(() => captionStyle = 3),
                                        ),
                                        EzMenuButton(
                                          label: EzConfig.l10n.tsTitle,
                                          textStyle: EzConfig.styles.titleLarge,
                                          textAlign: TextAlign.center,
                                          onPressed: () => setState(() => captionStyle = 2),
                                        ),
                                        EzMenuButton(
                                          label: EzConfig.l10n.tsBody,
                                          textStyle: EzConfig.styles.bodyLarge,
                                          textAlign: TextAlign.center,
                                          onPressed: () => setState(() => captionStyle = 1),
                                        ),
                                        EzMenuButton(
                                          label: EzConfig.l10n.tsLabel,
                                          textStyle: EzConfig.styles.labelLarge,
                                          textAlign: TextAlign.center,
                                          onPressed: () => setState(() => captionStyle = 0),
                                        ),
                                      ],
                                    ),
                                  ),

                                // FullScreen
                                EzIconButton(
                                  icon: EzIcon(
                                      widget.fullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
                                  onPressed: () async => widget.fullscreen
                                      ? Navigator.of(context).pop(widget.controller.value.position)
                                      : await enterFullscreen(),
                                  tooltip: 'Fullscreen', // TODO: l10n
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const int _milisPerSec = 1000;
const int _milisPerMin = 60000;
const int _milisPerOur = 3600000;

String _tooTwo(int n) => n.toString().padLeft(2, '0');

/// Format [duration] into a video time format
/// Defaults to 'mm:ss', and will adapt to 'hh:mm:ss' if necessary
/// Optionally [showMili]
String ezVideoTime(Duration duration, {bool showMili = false}) {
  int miliSecs = duration.inMilliseconds;

  final int hours = ((miliSecs as double) / (_milisPerOur as double)).floor();
  final String hourS = _tooTwo(hours);

  miliSecs -= (hours * _milisPerOur);

  final int minutes = ((miliSecs as double) / (_milisPerMin as double)).floor();
  final String minS = _tooTwo(minutes);

  miliSecs -= (minutes * _milisPerMin);

  final int seconds = ((miliSecs as double) / (_milisPerSec as double)).floor();
  final String secS = _tooTwo(seconds);

  miliSecs -= (seconds * _milisPerSec);
  final String miliS = showMili ? ':${_tooTwo(miliSecs)}' : '';

  return hours > 0 ? '$hourS:$minS:$secS$miliS' : '$minS:$secS$miliS';
}
