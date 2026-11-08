/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';

class EzScrollView extends StatefulWidget {
  final EzCP config;
  final ScrollController? controller;
  final bool? thumbVisibility;

  /// If true, when there is scrollable content, a halo of [ColorScheme.secondary] will be shown
  final bool showScrollHint;

  final Axis scrollDirection;

  /// Only useful when [scrollDirection] is [Axis.horizontal]
  /// Is passed to the [SingleChildScrollView]s [EzRow]
  final bool reverseHands;

  final bool? primary;
  final ScrollPhysics? physics;
  final Widget? child;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  /// Optionally jump to the center of the scroll upon creation
  final bool startCentered;

  /// Replacement to original [child] parameter
  /// [children] will be placed into an [EzRow] or [Column] based on [scrollDirection]
  final List<Widget>? children;

  /// [SingleChildScrollView] (and [Scrollbar]) wrapper
  /// If [children] are provided the original child parameter will be an [EzRow] or [Column] based on [scrollDirection]
  /// Behaves like a standard [SingleChildScrollView] if [child] is provided
  /// Parameters from [Scrollbar], [SingleChildScrollView] and [EzRow]/[Column] are supported
  const EzScrollView(
    this.config, {
    super.key,

    // Scrollbar
    this.controller,
    this.thumbVisibility,
    this.showScrollHint = false,

    // SingleChildScrollView
    this.scrollDirection = Axis.vertical,
    this.reverseHands = false,
    this.primary,
    this.physics = const BouncingScrollPhysics(),
    this.child,

    // EzRow/Column parameters
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.startCentered = false,
    this.children,
  }) : assert(
          (child == null) != (children == null),
          'Either child or children should be provided, but not both.',
        );

  @override
  State<EzScrollView> createState() => _EzScrollViewState();
}

class _EzScrollViewState extends State<EzScrollView> {
  // Define the build data //

  late final ScrollController controller;

  bool canScrollUp = false;
  bool canScrollDown = false;

  // Define custom functions //

  /// onEnter for showScrollHint
  void hoverScroll(PointerEnterEvent event, {required bool forward}) {
    if (!controller.hasClients) return;

    controller.animateTo(
      forward ? controller.position.maxScrollExtent : 0.0,
      duration: ezDuration(widget.config.animDur),
      curve: widget.config.animCurve,
    );
  }

  /// onExit for showScrollHint
  void stopScroll(PointerExitEvent event) {
    if (!controller.hasClients) return;
    controller.position.hold(() {});
  }

  // Init //

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? ScrollController();

    if (widget.startCentered) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !controller.hasClients) return;

        final double position = controller.position.maxScrollExtent / 2;
        controller.jumpTo(position);
      });
    }

    if (widget.showScrollHint) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !controller.hasClients) return;

        final ScrollPosition pos = controller.position;
        final bool up = pos.pixels > 0;
        final bool down = pos.pixels < pos.maxScrollExtent;

        if (up || down) {
          setState(() {
            canScrollUp = up;
            canScrollDown = down;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define the contextual build data //

    Widget core = SingleChildScrollView(
      scrollDirection: widget.scrollDirection,
      primary: widget.primary,
      physics: widget.physics,
      controller: controller,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      child: (widget.child != null)
          ? widget.child!
          : (widget.scrollDirection == Axis.vertical)
              ? EzCol(
                  mainAxisSize: widget.mainAxisSize,
                  mainAxisAlignment: widget.mainAxisAlignment,
                  crossAxisAlignment: widget.crossAxisAlignment,
                  children: widget.children!,
                )
              : EzRow(
                  widget.config,
                  mainAxisSize: widget.mainAxisSize,
                  mainAxisAlignment: widget.mainAxisAlignment,
                  crossAxisAlignment: widget.crossAxisAlignment,
                  reverseHands: widget.reverseHands,
                  children: widget.children!,
                ),
    );

    if (widget.thumbVisibility ?? widget.config.showScroll) {
      core = Scrollbar(controller: controller, thumbVisibility: true, child: core);
    }

    // Return the build //

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: widget.thumbVisibility ?? widget.config.showScroll,
        dragDevices: widget.scrollDirection == Axis.vertical
            ? <PointerDeviceKind>{
                PointerDeviceKind.invertedStylus,
                PointerDeviceKind.stylus,
                PointerDeviceKind.touch,
                PointerDeviceKind.trackpad,
                PointerDeviceKind.unknown,
              } // No mouse
            : PointerDeviceKind.values.toSet(),
      ),
      child: widget.showScrollHint
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notif) {
                final ScrollMetrics metrics = notif.metrics;
                final bool up = metrics.pixels > 0;
                final bool down = metrics.pixels < metrics.maxScrollExtent;

                if (up != canScrollUp || down != canScrollDown) {
                  setState(() {
                    canScrollUp = up;
                    canScrollDown = down;
                  });
                }
                return false;
              },
              child: Stack(
                children: <Widget>[
                  core,

                  // Up/left
                  if (canScrollUp)
                    widget.scrollDirection == Axis.vertical
                        ? Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            child: ExcludeSemantics(
                              child: MouseRegion(
                                onEnter: (PointerEnterEvent event) =>
                                    hoverScroll(event, forward: false),
                                onExit: stopScroll,
                                child: EzIcon(
                                  widget.config,
                                  Icons.arrow_upward,
                                  fill: widget.config.secondaryFill,
                                ),
                              ),
                            ),
                          )
                        : Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: ExcludeSemantics(
                              child: MouseRegion(
                                onEnter: (PointerEnterEvent event) =>
                                    hoverScroll(event, forward: false),
                                onExit: stopScroll,
                                child: EzIcon(
                                  widget.config,
                                  Icons.chevron_left,
                                  fill: widget.config.secondaryFill,
                                ),
                              ),
                            ),
                          ),

                  // Down/right
                  if (canScrollDown)
                    widget.scrollDirection == Axis.vertical
                        ? Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: ExcludeSemantics(
                              child: MouseRegion(
                                onEnter: (PointerEnterEvent event) =>
                                    hoverScroll(event, forward: true),
                                onExit: stopScroll,
                                child: EzIcon(
                                  widget.config,
                                  Icons.arrow_downward,
                                  fill: widget.config.secondaryFill,
                                ),
                              ),
                            ),
                          )
                        : Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: ExcludeSemantics(
                              child: MouseRegion(
                                onEnter: (PointerEnterEvent event) =>
                                    hoverScroll(event, forward: true),
                                onExit: stopScroll,
                                child: EzIcon(
                                  widget.config,
                                  Icons.chevron_right,
                                  fill: widget.config.secondaryFill,
                                ),
                              ),
                            ),
                          ),
                ],
              ),
            )
          : core,
    );
  }
}

class EzScrollBlocker extends NotificationListener<ScrollNotification> {
  final Widget kid;

  /// Widget alias for a [ScrollNotification] based [NotificationListener] that's always true
  EzScrollBlocker(this.kid, {super.key})
      : super(onNotification: (ScrollNotification notification) => true, child: kid);
}
