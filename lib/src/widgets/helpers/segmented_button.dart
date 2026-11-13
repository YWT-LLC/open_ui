/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/foundation.dart' show listEquals;

class EzSegmentedButton<T> extends StatelessWidget {
  final EzCP config;

  final List<ButtonSegment<T>> segments;
  final Set<T> selected;
  final void Function(Set<T>)? onSelectionChanged;

  final bool multiSelectionEnabled;
  final bool emptySelectionAllowed;
  final bool showSelectedIcon;
  final Widget? selectedIcon;
  final Axis direction;
  final EdgeInsets? expandedInsets;

  /// Unselected segment background
  /// Defaults to [EzCP.surfaceFill]
  final EzSwitchColor? fill;

  /// Selected segment background
  /// Defaults to [EzCP.primaryFill]
  final EzSwitchColor? selectedFill;

  /// Outline (and divider) color
  /// Defaults to [EzCP.primaryContainerFill]
  final EzSwitchColor? borderFill;

  /// Merged under the fill/border styling, so it can't clobber [fill], [selectedFill], or [borderFill]
  final ButtonStyle? style;

  /// [SegmentedButton] wrapper that supports [Gradient]s via [EzSwitchColor] and a manual background [Paint]er
  const EzSegmentedButton(
    this.config, {
    super.key,
    required this.segments,
    required this.selected,
    this.onSelectionChanged,
    this.multiSelectionEnabled = false,
    this.emptySelectionAllowed = false,
    this.showSelectedIcon = true,
    this.selectedIcon,
    this.direction = Axis.horizontal,
    this.expandedInsets,
    this.fill,
    this.selectedFill,
    this.borderFill,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final EzSwitchColor background = fill ?? config.surfaceFill;
    final EzSwitchColor selectedBackground = selectedFill ?? config.primaryFill;
    final EzSwitchColor border = borderFill ?? config.primaryContainerFill;

    final bool gradientBackground =
        background.gradient != null || selectedBackground.gradient != null;
    final bool gradientBorder = border.gradient != null;

    final ButtonStyle segmentStyle = SegmentedButton.styleFrom(
      backgroundColor: background.color,
      selectedBackgroundColor: selectedBackground.color,
      side: gradientBorder ? BorderSide.none : config.borderSide(fill: border),
      shape: config.outlinedBorder(fill: border),
      tapTargetSize: gradientBackground || gradientBorder ? MaterialTapTargetSize.shrinkWrap : null,
    ).merge(style);

    final Widget button = SegmentedButton<T>(
      segments: segments,
      selected: selected,
      onSelectionChanged: onSelectionChanged,
      multiSelectionEnabled: multiSelectionEnabled,
      emptySelectionAllowed: emptySelectionAllowed,
      showSelectedIcon: showSelectedIcon,
      selectedIcon: selectedIcon,
      direction: direction,
      expandedInsets: expandedInsets,
      style: segmentStyle,
    );

    if (!gradientBackground && !gradientBorder) return button;

    final TextDirection textDirection = Directionality.of(context);
    final List<int> selectedIndices = <int>[
      for (int i = 0; i < segments.length; i++)
        if (selected.contains(segments[i].value)) i,
    ];

    return CustomPaint(
      painter: gradientBackground
          ? _EzSegmentBackgroundPainter(
              shape: config.buttonShape.shape,
              count: segments.length,
              selectedIndices: selectedIndices,
              direction: direction,
              textDirection: textDirection,
              insets: expandedInsets ?? EdgeInsets.zero,
              fill: background,
              selectedFill: selectedBackground,
            )
          : null,
      foregroundPainter: (gradientBorder && config.borderWidth > 0)
          ? _EzSegmentDividerPainter(
              shape: config.buttonShape.shape,
              count: segments.length,
              direction: direction,
              insets: expandedInsets ?? EdgeInsets.zero,
              gradient: border.gradient!,
              width: config.borderWidth,
            )
          : null,
      child: button,
    );
  }
}

/// Rect of segment [index], accounting for [TextDirection.rtl]
Rect _segmentRect(
  Rect bounds,
  int index,
  int count,
  Axis direction,
  TextDirection textDirection,
) {
  switch (direction) {
    case Axis.horizontal:
      final double width = bounds.width / count;
      final int slot = (textDirection == TextDirection.rtl) ? count - 1 - index : index;
      return Rect.fromLTWH(bounds.left + slot * width, bounds.top, width, bounds.height);

    case Axis.vertical:
      final double height = bounds.height / count;
      return Rect.fromLTWH(bounds.left, bounds.top + index * height, bounds.width, height);
  }
}

class _EzSegmentBackgroundPainter extends CustomPainter {
  final OutlinedBorder shape;
  final int count;
  final List<int> selectedIndices;
  final Axis direction;
  final TextDirection textDirection;
  final EdgeInsets insets;
  final EzSwitchColor fill;
  final EzSwitchColor selectedFill;

  const _EzSegmentBackgroundPainter({
    required this.shape,
    required this.count,
    required this.selectedIndices,
    required this.direction,
    required this.textDirection,
    required this.insets,
    required this.fill,
    required this.selectedFill,
  });

  Paint _paintFor(EzSwitchColor switchColor, Rect rect) => (switchColor.gradient == null)
      ? (Paint()..color = switchColor.color!)
      : (Paint()..shader = switchColor.gradient!.createShader(rect, textDirection: textDirection));

  @override
  void paint(Canvas canvas, Size size) {
    if (count == 0) return;

    final Rect bounds = insets.deflateRect(Offset.zero & size);

    canvas
      ..save()
      ..clipPath(shape.getOuterPath(bounds, textDirection: textDirection));

    canvas.drawRect(bounds, _paintFor(fill, bounds));

    final Paint selectedPaint = _paintFor(selectedFill, bounds);
    for (final int index in selectedIndices) {
      canvas.drawRect(
        _segmentRect(bounds, index, count, direction, textDirection),
        selectedPaint,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_EzSegmentBackgroundPainter oldDelegate) =>
      oldDelegate.shape != shape ||
      oldDelegate.count != count ||
      !listEquals(oldDelegate.selectedIndices, selectedIndices) ||
      oldDelegate.direction != direction ||
      oldDelegate.textDirection != textDirection ||
      oldDelegate.insets != insets ||
      oldDelegate.fill.color != fill.color ||
      oldDelegate.fill.gradient != fill.gradient ||
      oldDelegate.selectedFill.color != selectedFill.color ||
      oldDelegate.selectedFill.gradient != selectedFill.gradient;
}

class _EzSegmentDividerPainter extends CustomPainter {
  final OutlinedBorder shape;
  final int count;
  final Axis direction;
  final EdgeInsets insets;
  final Gradient gradient;
  final double width;

  const _EzSegmentDividerPainter({
    required this.shape,
    required this.count,
    required this.direction,
    required this.insets,
    required this.gradient,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (count < 2) return;

    final Rect bounds = insets.deflateRect(Offset.zero & size);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..shader = gradient.createShader(bounds);

    canvas
      ..save()
      ..clipPath(shape.getOuterPath(bounds));

    for (int i = 1; i < count; i++) {
      switch (direction) {
        case Axis.horizontal:
          final double x = bounds.left + bounds.width * i / count;
          canvas.drawLine(Offset(x, bounds.top), Offset(x, bounds.bottom), paint);

        case Axis.vertical:
          final double y = bounds.top + bounds.height * i / count;
          canvas.drawLine(Offset(bounds.left, y), Offset(bounds.right, y), paint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_EzSegmentDividerPainter oldDelegate) =>
      oldDelegate.shape != shape ||
      oldDelegate.count != count ||
      oldDelegate.direction != direction ||
      oldDelegate.insets != insets ||
      oldDelegate.gradient != gradient ||
      oldDelegate.width != width;
}
