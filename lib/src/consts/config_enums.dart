/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

//* Shared *//

// EzConfig values //

/// enum [String] 'none'
const String esNone = 'none';

/// enum [String] 'system'
const String esSystem = 'system';

const Set<String> ezEnumVals = <String>{
  esNone,
  esSystem,
  esPill,
  esRect,
  esRoundRect,
  esLeftGram,
  esRightGram,
  esGem,
  esJewel,
  esTurnX,
  esTurnY,
  esRotate,
  esSlideX,
  esSlideY,
  esZoom,
};

//* Box Fit *//

/// Library for getting a [BoxFit] from its name
/// '' && `null` both map to `null`
final Map<String?, BoxFit?> boxFitLookup = <String?, BoxFit?>{
  BoxFit.contain.name: BoxFit.contain,
  BoxFit.cover.name: BoxFit.cover,
  BoxFit.fill.name: BoxFit.fill,
  BoxFit.fitHeight.name: BoxFit.fitHeight,
  BoxFit.fitWidth.name: BoxFit.fitWidth,
  BoxFit.none.name: BoxFit.none,
  BoxFit.scaleDown.name: BoxFit.scaleDown,
  '': null,
  null: null,
};

//* Button shapes *//

enum EzButtonShape {
  pill,
  rect,
  roundRect,
  leftGram,
  rightGram,
  gem,
  jewel,
}

// EzConfig values //

/// enum [String] 'pill'
const String esPill = 'pill';

/// enum [String] 'rect'
const String esRect = 'rect';

/// enum [String] 'roundRect'
const String esRoundRect = 'roundRect';

/// enum [String] 'leftGram'
const String esLeftGram = 'leftGram';

/// enum [String] 'rightGram'
const String esRightGram = 'rightGram';

/// enum [String] 'gem'
const String esGem = 'gem';

/// enum [String] 'jewel'
const String esJewel = 'jewel';

// enum Config //

/// EzButtonShape config
extension EBSConfig on EzButtonShape {
  OutlinedBorder get shape => switch (this) {
        EzButtonShape.pill => const RoundedSuperellipseBorder(borderRadius: ezPillEdge),
        EzButtonShape.rect => const RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.zero,
          ),
        EzButtonShape.roundRect => const RoundedRectangleBorder(borderRadius: ezRoundEdge),
        EzButtonShape.leftGram => const ParallelogramBorder(lefty: true),
        EzButtonShape.rightGram => const ParallelogramBorder(lefty: false),
        EzButtonShape.gem => const GemBorder(),
        EzButtonShape.jewel => BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(gemSlope),
          ),
      };

  String get value => switch (this) {
        EzButtonShape.pill => esPill,
        EzButtonShape.rect => esRect,
        EzButtonShape.roundRect => esRoundRect,
        EzButtonShape.leftGram => esLeftGram,
        EzButtonShape.rightGram => esRightGram,
        EzButtonShape.gem => esGem,
        EzButtonShape.jewel => esJewel,
      };

  /// Defaults to [EzTransitionType.system]
  static EzButtonShape lookup(String? value) => switch (value) {
        esRect => EzButtonShape.rect,
        esRoundRect => EzButtonShape.roundRect,
        esLeftGram => EzButtonShape.leftGram,
        esRightGram => EzButtonShape.rightGram,
        esGem => EzButtonShape.gem,
        esJewel => EzButtonShape.jewel,
        esPill || _ => EzButtonShape.pill,
      };

  String get name => switch (this) {
        EzButtonShape.pill => EzConfig.l10n.dsPill,
        EzButtonShape.rect => EzConfig.l10n.dsRectangle,
        EzButtonShape.roundRect => EzConfig.l10n.dsRoundRectangle,
        EzButtonShape.leftGram => EzConfig.l10n.dsLeftGram,
        EzButtonShape.rightGram => EzConfig.l10n.dsRightGram,
        EzButtonShape.gem => EzConfig.l10n.dsGem,
        EzButtonShape.jewel => EzConfig.l10n.dsJewel,
      };
}

//* Page transitions *//

enum EzTransitionType {
  none,
  system,
  turnX,
  turnY,
  rotate,
  slideX,
  slideY,
  zoom,
}

// EzConfig values //

/// enum [String] 'turnX'
const String esTurnX = 'turnX';

/// enum [String] 'turnY'
const String esTurnY = 'turnY';

/// enum [String] 'rotate'
const String esRotate = 'rotate';

/// enum [String] 'slideX'
const String esSlideX = 'slideX';

/// enum [String] 'slideY'
const String esSlideY = 'slideY';

/// enum [String] 'zoom'
const String esZoom = 'zoom';

// enum Config //

/// EzTransitionType config
extension ETTConfig on EzTransitionType {
  Icon get icon => switch (this) {
        EzTransitionType.none => const Icon(Icons.cancel),
        EzTransitionType.system => Icon(EzConfig.onMobile
            ? EzConfig.platform == TargetPlatform.iOS
                ? Icons.phone_iphone
                : Icons.phone_android
            : Icons.computer),
        EzTransitionType.turnX => const Icon(Icons.flip),
        EzTransitionType.turnY => const Icon(Icons.u_turn_left),
        EzTransitionType.rotate => const Icon(Icons.rotate_90_degrees_cw),
        EzTransitionType.slideX => Icon(
            EzConfig.isLTR ? Icons.keyboard_double_arrow_left : Icons.keyboard_double_arrow_right),
        EzTransitionType.slideY => const Icon(Icons.keyboard_double_arrow_up),
        EzTransitionType.zoom => const Icon(Icons.zoom_in),
      };

  String get value => switch (this) {
        EzTransitionType.none => esNone,
        EzTransitionType.system => esSystem,
        EzTransitionType.turnX => esTurnX,
        EzTransitionType.turnY => esTurnY,
        EzTransitionType.rotate => esRotate,
        EzTransitionType.slideX => esSlideX,
        EzTransitionType.slideY => esSlideY,
        EzTransitionType.zoom => esZoom,
      };

  /// Defaults to [EzTransitionType.system]
  static EzTransitionType lookup(String? value) => switch (value) {
        esNone => EzTransitionType.none,
        esTurnX => EzTransitionType.turnX,
        esTurnY => EzTransitionType.turnY,
        esRotate => EzTransitionType.rotate,
        esSlideX => EzTransitionType.slideX,
        esSlideY => EzTransitionType.slideY,
        esZoom => EzTransitionType.zoom,
        esSystem || _ => EzTransitionType.system,
      };

  String get name => switch (this) {
        EzTransitionType.none => EzConfig.l10n.dsNone,
        EzTransitionType.system => EzConfig.l10n.dsSystem,
        EzTransitionType.turnX => EzConfig.l10n.dsTurnX,
        EzTransitionType.turnY => EzConfig.l10n.dsTurnY,
        EzTransitionType.rotate => EzConfig.l10n.dsRotate,
        EzTransitionType.slideX => EzConfig.l10n.dsSlideX,
        EzTransitionType.slideY => EzConfig.l10n.dsSlideY,
        EzTransitionType.zoom => EzConfig.l10n.dsZoom,
      };
}

//* Animation curve *//

/// enum [String] 'bounce'
const String esBounce = 'bounce';

/// enum [String] 'ease'
const String esEase = 'ease';

/// enum [String] 'elastic'
const String esElastic = 'elastic';

/// enum [String] 'linear'
const String esLinear = 'linear';

enum EzAnimationCurve { bounce, ease, elastic, linear }

extension EACConfig on EzAnimationCurve {
  String get value => switch (this) {
        EzAnimationCurve.bounce => esBounce,
        EzAnimationCurve.ease => esEase,
        EzAnimationCurve.elastic => esElastic,
        EzAnimationCurve.linear => esLinear,
      };

  Curve get curve => switch (this) {
        EzAnimationCurve.bounce => Curves.bounceInOut,
        EzAnimationCurve.ease => Curves.easeInOut,
        EzAnimationCurve.elastic => Curves.elasticInOut,
        EzAnimationCurve.linear => Curves.linear,
      };

  String get name => switch (this) {
        EzAnimationCurve.bounce => EzConfig.l10n.dsBounce,
        EzAnimationCurve.ease => EzConfig.l10n.dsEase,
        EzAnimationCurve.elastic => EzConfig.l10n.dsElastic,
        EzAnimationCurve.linear => EzConfig.l10n.dsLinear,
      };

  static EzAnimationCurve lookup(String? value) => switch (value) {
        esBounce => EzAnimationCurve.bounce,
        esElastic => EzAnimationCurve.elastic,
        esLinear => EzAnimationCurve.linear,
        esEase || _ => EzAnimationCurve.ease,
      };

  static Curve translate(String? value) => switch (value) {
        esBounce => Curves.bounceInOut,
        esElastic => Curves.elasticInOut,
        esLinear => Curves.linear,
        esEase || _ => Curves.easeInOut,
      };
}
