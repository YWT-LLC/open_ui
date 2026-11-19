/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:material_ui/material_ui.dart';

// Widget(s) //

class EzGradientBorderSide extends BorderSide {
  final Gradient gradient;

  EzGradientBorderSide({
    required this.gradient,
    required super.width,
  }) : super(
          color: gradient.colors.first,
          style: (width <= 0) ? BorderStyle.none : BorderStyle.solid,
        );

  Paint toGradientPaint(Rect rect, {TextDirection? textDirection}) => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = width
    ..shader = gradient.createShader(rect, textDirection: textDirection);

  @override
  bool operator ==(Object other) =>
      other is EzGradientBorderSide && other.gradient == gradient && other.width == width;

  @override
  int get hashCode => Object.hash(gradient, width, style);
}

class EzGradientBoxBorder extends BoxBorder {
  final Gradient gradient;
  final double width;

  const EzGradientBoxBorder({
    required this.gradient,
    required this.width,
  });

  @override
  BorderSide get top => EzGradientBorderSide(gradient: gradient, width: width);

  @override
  BorderSide get bottom => EzGradientBorderSide(gradient: gradient, width: width);

  @override
  bool get isUniform => true;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    if (width <= 0) return;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..shader = gradient.createShader(rect, textDirection: textDirection);

    final Rect inset = rect.deflate(width / 2);

    switch (shape) {
      case BoxShape.circle:
        canvas.drawCircle(inset.center, inset.shortestSide / 2, paint);
      case BoxShape.rectangle:
        (borderRadius == null || borderRadius == BorderRadius.zero)
            ? canvas.drawRect(inset, paint)
            : canvas.drawRRect(borderRadius.toRRect(rect).deflate(width / 2), paint);
    }
  }

  @override
  ShapeBorder scale(double t) => EzGradientBoxBorder(gradient: gradient.scale(t), width: width);

  @override
  bool operator ==(Object other) =>
      other is EzGradientBoxBorder && other.gradient == gradient && other.width == width;

  @override
  int get hashCode => Object.hash(gradient, width);
}

class EzGradientOutlinedBorder extends OutlinedBorder {
  final Gradient gradient;
  final double width;
  final OutlinedBorder base;

  const EzGradientOutlinedBorder({
    required this.gradient,
    required this.width,
    required this.base,
  }) : super(side: BorderSide.none);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      base.getOuterPath(rect, textDirection: textDirection);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      base.getOuterPath(rect.deflate(width), textDirection: textDirection);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (width <= 0) return;

    canvas.drawPath(
      base.getOuterPath(rect.deflate(width / 2), textDirection: textDirection),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..shader = gradient.createShader(rect, textDirection: textDirection),
    );
  }

  @override
  OutlinedBorder copyWith({BorderSide? side}) => this;

  @override
  ShapeBorder scale(double t) => EzGradientOutlinedBorder(
        gradient: gradient.scale(t),
        width: width,
        base: base.scale(t) as OutlinedBorder,
      );

  @override
  bool operator ==(Object other) =>
      other is EzGradientOutlinedBorder &&
      other.gradient == gradient &&
      other.width == width &&
      other.base == base;

  @override
  int get hashCode => Object.hash(gradient, width, base);
}

// Storage //

/// CAW! Do NOT build these with [Alignment.toString]
/// That produces different results on dev vs release... for some reason
const Map<String, AlignmentGeometry> alignLibrary = <String, AlignmentGeometry>{
  // Bottom
  'Alignment.bottomLeft': Alignment.bottomLeft,
  'Alignment.bottomCenter': Alignment.bottomCenter,
  'Alignment.bottomRight': Alignment.bottomRight,

  // Center
  'Alignment.centerLeft': Alignment.centerLeft,
  'Alignment.center': Alignment.center,
  'Alignment.centerRight': Alignment.centerRight,

  // Top
  'Alignment.topLeft': Alignment.topLeft,
  'Alignment.topCenter': Alignment.topCenter,
  'Alignment.topRight': Alignment.topRight,
};

/// Reverse, reverse!
final Map<AlignmentGeometry, String> _alignNames = <AlignmentGeometry, String>{
  for (final MapEntry<String, AlignmentGeometry> entry in alignLibrary.entries)
    entry.value: entry.key,
};

/// Fails to [Alignment.centerLeft] for when [start] is true
/// [Alignment.centerRight] when false
String ezAlignString(
  AlignmentGeometry align, {
  bool start = true,
}) =>
    _alignNames[align] ?? (start ? 'Alignment.centerLeft' : 'Alignment.centerRight');

/// Storage string for [gradient], parsable by [ezLGFromString] and [ezCOG]
String ezLGToString(LinearGradient gradient) => <String>[
      ezAlignString(gradient.begin),
      ezAlignString(gradient.end, start: false),
      ...gradient.colors.map((Color color) => color.toARGB32().toString()),
    ].join(colorSplit);

/// No checks, assumes a valid gradient entry's value is being sent
LinearGradient ezLGFromString(String value) {
  final List<String> parts = value.split(colorSplit);

  return LinearGradient(
    begin: alignLibrary[parts[0]] ?? Alignment.centerLeft,
    end: alignLibrary[parts[1]] ?? Alignment.centerRight,
    colors: parts.sublist(2).map((String color) => Color(int.parse(color))).toList(),
  );
}

const LinearGradient ezRainbowGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ],
);

const EzSwitchColor ezRainbowSwitch = EzSwitchColor(gradient: ezRainbowGradient);

final String ezRainbowString = <String>[
  ezAlignString(Alignment.topCenter),
  ezAlignString(Alignment.bottomCenter),
  Colors.red.toARGB32().toString(),
  Colors.orange.toARGB32().toString(),
  Colors.yellow.toARGB32().toString(),
  Colors.green.toARGB32().toString(),
  Colors.blue.toARGB32().toString(),
  Colors.indigo.toARGB32().toString(),
  Colors.purple.toARGB32().toString(),
].join(colorSplit);

final String ezRainbowAccentString = <String>[
  ezAlignString(Alignment.bottomLeft),
  ezAlignString(Alignment.topRight),
  Colors.redAccent.toARGB32().toString(),
  Colors.orangeAccent.toARGB32().toString(),
  Colors.yellowAccent.toARGB32().toString(),
  Colors.greenAccent.toARGB32().toString(),
  Colors.blueAccent.toARGB32().toString(),
  Colors.indigoAccent.toARGB32().toString(),
  Colors.purpleAccent.toARGB32().toString(),
].join(colorSplit);

const LinearGradient ezProgressGradient = LinearGradient(
  // begin: Alignment.centerLeft,
  // end: Alignment.centerRight,
  colors: <Color>[
    Colors.white,
    Colors.pinkAccent,
    Colors.lightBlueAccent,
    Colors.brown,
    Colors.black,
  ],
);

const EzSwitchColor ezProgressSwitch = EzSwitchColor(gradient: ezProgressGradient);

final String ezProgressString = <String>[
  ezAlignString(Alignment.centerLeft),
  ezAlignString(Alignment.centerRight),
  Colors.white.toARGB32().toString(),
  Colors.pinkAccent.toARGB32().toString(),
  Colors.lightBlueAccent.toARGB32().toString(),
  Colors.brown.toARGB32().toString(),
  Colors.black.toARGB32().toString(),
].join(colorSplit);

final String ezProgressVariantString = <String>[
  ezAlignString(Alignment.centerLeft),
  ezAlignString(Alignment.centerRight),
  Colors.grey.toARGB32().toString(),
  Colors.pink.toARGB32().toString(),
  Colors.blue.toARGB32().toString(),
  Colors.brown.toARGB32().toString(),
  Colors.grey.toARGB32().toString(),
].join(colorSplit);

final String ezYWTGradientString = <String>[
  ezAlignString(Alignment.centerLeft),
  ezAlignString(Alignment.centerRight),
  ywt.ywtEucalyptusHex.toString(),
  ywt.ywtSandHex.toString(),
  ywt.ywtPurpleHex.toString(),
].join(colorSplit);

final String ezErrorGradientString = <String>[
  ezAlignString(Alignment.topLeft),
  ezAlignString(Alignment.bottomRight),
  Colors.blue.toARGB32().toString(),
  Colors.white.toARGB32().toString(),
  Colors.red.toARGB32().toString(),
].join(colorSplit);
