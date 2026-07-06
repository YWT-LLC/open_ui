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
  /// EzConfig provider
  final EzCP config;

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
  const EzVideoPlayer(
    this.config, {
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

  bool fbf = false;
  late double speedBackup = widget.speed;

  double? savedVolume;
  Timer? showVolume;

  bool showCaptions = false;
  final MenuController subMenuControl = MenuController();
  int captionStyle = 1;

  bool twinRunning = false;

  // Define custom functions //

  void handleMobileHover() {
    if (!EzCM.onMobile) return;

    mobileHover?.cancel();
    if (!hovering) setState(() => hovering = true);

    mobileHover = Timer(
      Duration(seconds: widget.mobileDelay),
      () => setState(() => hovering = false),
    );
  }

  Future<void> play() async {
    if (widget.controller.value.isCompleted) await widget.controller.seekTo(Duration.zero);
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

  Future<void> skipForward(VideoPlayerValue value) => widget.controller.seekTo(value.position +
      (fbf ? const Duration(milliseconds: 20) : Duration(seconds: widget.skipTime)));

  Future<void> skipBackward(VideoPlayerValue value) => widget.controller.seekTo(value.position -
      (fbf ? const Duration(milliseconds: 20) : Duration(seconds: widget.skipTime)));

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

  /// Enter frame by frame
  Future<void> enterFBF() async {
    speedBackup = widget.controller.value.playbackSpeed;
    await widget.controller.setPlaybackSpeed(0.1);
    setState(() => fbf = true);
  }

  /// Exit frame by frame
  Future<void> exitFBF() async {
    await widget.controller.setPlaybackSpeed(speedBackup);
    setState(() => fbf = false);
  }

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
                  widget.config,
                  controller: widget.controller,
                  semantics: widget.semantics,
                  aspectRatio: widget.aspectRatio,
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  fullscreen: true,
                  hasCaptions: widget.hasCaptions,
                  skipTime: widget.skipTime,
                  speed: widget.controller.value.playbackSpeed,
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
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    await SystemChrome.setPreferredOrientations(EzCM.orientations);
  }

  Future<void> exitFullscreen() async {
    await pause();
    if (mounted) Navigator.of(context).pop(widget.controller.value.position);
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

    if (widget.autoPlay) await play();
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final double controlsHeight =
        (3 * widget.config.marginVal + 2 * (widget.config.iconSize + widget.config.padding));

    final TextStyle? labelStyle = widget.config.labelStyle?.copyWith(color: Colors.white);

    final SliderThemeData sliderTheme = SliderThemeData(
      activeTrackColor: widget.config.colors.secondary,
      inactiveTrackColor: halfWhite,
      thumbColor: widget.config.colors.primary,
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
                // Up -> volume up (if relevant)
                case LogicalKeyboardKey.arrowUp:
                  if (widget.hasAudio) {
                    double newVol = value.volume + 0.05;
                    if (newVol > 1.0) newVol = 1.0;

                    widget.controller.setVolume(newVol);
                    showVolumeLabel();
                  }
                  return KeyEventResult.handled;

                // Down -> volume down (if relevant)
                case LogicalKeyboardKey.arrowDown:
                  if (widget.hasAudio) {
                    double newVol = value.volume - 0.05;
                    if (newVol < 0.0) newVol = 0.0;

                    widget.controller.setVolume(newVol);
                    showVolumeLabel();
                  }
                  return KeyEventResult.handled;

                // Left -> skip backwards
                case LogicalKeyboardKey.arrowLeft:
                  skipBackward(value);
                  return KeyEventResult.handled;

                // Right -> skip forward
                case LogicalKeyboardKey.arrowRight:
                  skipForward(value);
                  return KeyEventResult.handled;

                // Space -> play/pause
                case LogicalKeyboardKey.space:
                  value.isPlaying ? pause() : play();
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
                  if (!widget.fullscreen) {
                    enterFullscreen();
                    return KeyEventResult.handled;
                  } else {
                    return KeyEventResult.ignored;
                  }

                // Esc -> exit fullscreen (if relevant)
                case LogicalKeyboardKey.escape:
                  if (widget.fullscreen) {
                    exitFullscreen();
                    return KeyEventResult.handled;
                  } else {
                    return KeyEventResult.ignored;
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
                  top: widget.config.spacing * 2,
                  child: EzAnimVis(
                    widget.config,
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
                            widget.config,
                            text: '${(value.volume * 100).toStringAsFixed(0)}%',
                            style: switch (captionStyle) {
                              4 => widget.config.displayStyle?.copyWith(color: Colors.white),
                              3 => widget.config.headlineStyle?.copyWith(color: Colors.white),
                              2 => widget.config.titleStyle?.copyWith(color: Colors.white),
                              1 => widget.config.bodyStyle?.copyWith(color: Colors.white),
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
                        if (EzCM.onMobile) {
                          mobileHover?.cancel();

                          hovering ? setState(() => hovering = false) : handleMobileHover();
                        } else {
                          value.isPlaying ? await pause() : await play();
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
                    bottom: (hovering || subMenuControl.isOpen)
                        ? controlsHeight
                        : widget.config.marginVal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Row seems weird, but it prevents the Text from auto-expanding
                        ExcludeSemantics(
                          child: EzText(
                            widget.config,
                            text: value.caption.text,
                            style: switch (captionStyle) {
                              4 => widget.config.displayStyle?.copyWith(color: Colors.white),
                              3 => widget.config.headlineStyle?.copyWith(color: Colors.white),
                              2 => widget.config.titleStyle?.copyWith(color: Colors.white),
                              1 => widget.config.bodyStyle?.copyWith(color: Colors.white),
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
                    widget.config,
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
                            height: widget.config.iconSize,
                            width: double.infinity,
                            child: SliderTheme(
                              data: sliderTheme,
                              child: Slider(
                                value: pComplete(value.position),
                                onChangeStart: (_) async {
                                  await pause();
                                  if (EzCM.onMobile) {
                                    mobileHover?.cancel();
                                  }
                                },
                                onChanged: (double value) => widget.controller.seekTo(findP(value)),
                                onChangeEnd: (_) async {
                                  await play();
                                  handleMobileHover();
                                },
                              ),
                            ),
                          ),
                          widget.config.margin,

                          // Buttons
                          NotificationListener<ScrollNotification>(
                            onNotification: (_) {
                              handleMobileHover();
                              return false;
                            },
                            child: EzScrollView(
                              widget.config,
                              scrollDirection: Axis.horizontal,
                              showScrollHint: true,
                              children: <Widget>[
                                widget.config.rowSpacer,

                                // Play/pause
                                Padding(
                                  padding: EdgeInsets.only(right: widget.config.spacing),
                                  child: value.isPlaying
                                      ? EzIconButton(
                                          widget.config,
                                          onPressed: pause,
                                          tooltip: widget.config.ezL10n.gPause,
                                          icon: const Icon(Icons.pause),
                                        )
                                      : EzIconButton(
                                          widget.config,
                                          onPressed: play,
                                          tooltip: widget.config.ezL10n.gPlay,
                                          icon: Icon(
                                            value.isCompleted ? Icons.replay : Icons.play_arrow,
                                          ),
                                        ),
                                ),

                                // Volume toggle
                                if (widget.hasAudio) ...<Widget>[
                                  (value.volume == 0.0)
                                      ? EzIconButton(
                                          widget.config,
                                          onPressed: unMute,
                                          tooltip: widget.config.ezL10n.gUnMute,
                                          icon: const Icon(Icons.volume_mute),
                                        )
                                      : EzIconButton(
                                          widget.config,
                                          onPressed: () => mute(value),
                                          tooltip: widget.config.ezL10n.gMute,
                                          icon: const Icon(Icons.volume_up),
                                        ),

                                  // Volume slider
                                  Padding(
                                    padding: EdgeInsets.only(right: widget.config.spacing),
                                    child: SizedBox(
                                      height: widget.config.iconSize,
                                      width: 100,
                                      child: SliderTheme(
                                        data: sliderTheme,
                                        child: Slider(
                                          value: value.volume,
                                          onChangeStart: (_) {
                                            if (EzCM.onMobile) {
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
                                    right: widget.config.spacing,
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
                                    right: widget.config.spacing,
                                  ),
                                  child: EzRow(
                                    widget.config,
                                    reverseHands: false,
                                    children: <Widget>[
                                      EzIconButton(
                                        widget.config,
                                        enabled: !fbf && value.playbackSpeed > 0.25,
                                        onPressed: () async {
                                          await widget.controller
                                              .setPlaybackSpeed(value.playbackSpeed - 0.25);
                                          handleMobileHover();
                                        },
                                        tooltip:
                                            '${widget.config.ezL10n.gDecrease} ${widget.config.ezL10n.gPlaybackSpeed.toLowerCase()}',
                                        icon: const Icon(Icons.remove),
                                      ),
                                      widget.config.rowMargin,
                                      Tooltip(
                                        message: widget.config.ezL10n.gPlaybackSpeed,
                                        child: EzCol(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.speed,
                                              size: widget.config.iconSize * 0.75,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              value.playbackSpeed.toStringAsFixed(2),
                                              style: labelStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      widget.config.rowMargin,
                                      EzIconButton(
                                        widget.config,
                                        enabled: !fbf && value.playbackSpeed < 2.0,
                                        onPressed: () async {
                                          await widget.controller
                                              .setPlaybackSpeed(value.playbackSpeed + 0.25);
                                          handleMobileHover();
                                        },
                                        tooltip:
                                            '${widget.config.ezL10n.gIncrease} ${widget.config.ezL10n.gPlaybackSpeed.toLowerCase()}',
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),

                                // Frame by frame
                                Padding(
                                  padding: EdgeInsets.only(right: widget.config.spacing),
                                  child: EzIconButton(
                                    widget.config,
                                    icon: Icon(fbf ? Icons.directions_run : Icons.directions_walk),
                                    onPressed: () async => fbf ? await exitFBF() : await enterFBF(),
                                    tooltip: fbf
                                        ? widget.config.ezL10n.gPlay
                                        : widget.config.ezL10n.gFBF,
                                  ),
                                ),

                                // Captions
                                if (widget.hasCaptions)
                                  Padding(
                                    padding: EdgeInsets.only(right: widget.config.spacing),
                                    child: MenuAnchor(
                                      controller: subMenuControl,
                                      builder: (_, __, ___) => EzIconButton(
                                        widget.config,
                                        onPressed: () => subMenuControl.isOpen
                                            ? subMenuControl.close()
                                            : setState(() => showCaptions = !showCaptions),
                                        onLongPress: () => subMenuControl.isOpen
                                            ? subMenuControl.close()
                                            : subMenuControl.open(),
                                        tooltip:
                                            '${widget.config.ezL10n.gCaptions}\n${widget.config.ezL10n.gCaptionsHint}',
                                        fauxDisabled: !showCaptions,
                                        icon: const Icon(Icons.subtitles),
                                      ),
                                      menuChildren: <Widget>[
                                        EzMenuButton(
                                          widget.config,
                                          label: widget.config.ezL10n.tsDisplay,
                                          textStyle: widget.config.displayStyle,
                                          textAlign: TextAlign.center,
                                          onPressed: () => setState(() => captionStyle = 4),
                                        ),
                                        EzMenuButton(
                                          widget.config,
                                          label: widget.config.ezL10n.tsHeadline,
                                          textStyle: widget.config.headlineStyle,
                                          textAlign: TextAlign.center,
                                          onPressed: () => setState(() => captionStyle = 3),
                                        ),
                                        EzMenuButton(
                                          widget.config,
                                          label: widget.config.ezL10n.tsTitle,
                                          textStyle: widget.config.titleStyle,
                                          textAlign: TextAlign.center,
                                          onPressed: () => setState(() => captionStyle = 2),
                                        ),
                                        EzMenuButton(
                                          widget.config,
                                          label: widget.config.ezL10n.tsBody,
                                          textStyle: widget.config.bodyStyle,
                                          textAlign: TextAlign.center,
                                          onPressed: () => setState(() => captionStyle = 1),
                                        ),
                                        EzMenuButton(
                                          widget.config,
                                          label: widget.config.ezL10n.tsLabel,
                                          textStyle: widget.config.labelStyle,
                                          textAlign: TextAlign.center,
                                          onPressed: () => setState(() => captionStyle = 0),
                                        ),
                                      ],
                                    ),
                                  ),

                                // FullScreen
                                Padding(
                                  padding: EdgeInsets.only(right: widget.config.spacing),
                                  child: EzIconButton(
                                    widget.config,
                                    icon: Icon(
                                      widget.fullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                                    ),
                                    onPressed: () async => widget.fullscreen
                                        ? await exitFullscreen()
                                        : await enterFullscreen(),
                                    tooltip: widget.config.ezL10n.gFullscreen,
                                  ),
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
