/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';

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
  esBounce,
  esEase,
  esElastic,
  esLinear,
};

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
  Curve get curve => switch (this) {
        EzAnimationCurve.bounce => Curves.bounceInOut,
        EzAnimationCurve.ease => Curves.easeInOut,
        EzAnimationCurve.elastic => Curves.elasticInOut,
        EzAnimationCurve.linear => Curves.linear,
      };

  String get value => switch (this) {
        EzAnimationCurve.bounce => esBounce,
        EzAnimationCurve.ease => esEase,
        EzAnimationCurve.elastic => esElastic,
        EzAnimationCurve.linear => esLinear,
      };

  String name(OUILang l10n) => switch (this) {
        EzAnimationCurve.bounce => l10n.dsBounce,
        EzAnimationCurve.ease => l10n.dsEase,
        EzAnimationCurve.elastic => l10n.dsElastic,
        EzAnimationCurve.linear => l10n.dsLinear,
      }
          .replaceAll(' ', '\n');

  static Curve translate(String? value) => switch (value) {
        esBounce => Curves.bounceInOut,
        esElastic => Curves.elasticInOut,
        esLinear => Curves.linear,
        _ => Curves.easeInOut,
      };

  static EzAnimationCurve? lookup(String? value) => switch (value) {
        esBounce => EzAnimationCurve.bounce,
        esEase => EzAnimationCurve.ease,
        esElastic => EzAnimationCurve.elastic,
        esLinear => EzAnimationCurve.linear,
        _ => null,
      };

  /// Defaults to [EzAnimationCurve.ease]
  static EzAnimationCurve safeLookup(String? value) => switch (value) {
        esBounce => EzAnimationCurve.bounce,
        esElastic => EzAnimationCurve.elastic,
        esLinear => EzAnimationCurve.linear,
        _ => EzAnimationCurve.ease,
      };
}

//* Box Fit *//

/// Library for getting a [BoxFit] from its name
/// '' && `null` both map to `null`
final Map<String?, BoxFit?> boxFitLib = <String?, BoxFit?>{
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

enum EzButtonShape { pill, rect, roundRect, leftGram, rightGram, gem, jewel }

// enum values //

/// 4.0
const double ezRoundRadius = 4.0;

/// 64.0
const double ezPillRadius = 64.0;

/// 12.0
const double gramSlope = 12.0;

/// 16.0
const double jewelSlope = 16.0;

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
  String get value => switch (this) {
        EzButtonShape.pill => esPill,
        EzButtonShape.rect => esRect,
        EzButtonShape.roundRect => esRoundRect,
        EzButtonShape.leftGram => esLeftGram,
        EzButtonShape.rightGram => esRightGram,
        EzButtonShape.gem => esGem,
        EzButtonShape.jewel => esJewel,
      };

  BorderRadius get radius => switch (this) {
        EzButtonShape.pill => const BorderRadius.all(Radius.circular(ezPillRadius)),
        EzButtonShape.rect => BorderRadius.zero,
        EzButtonShape.roundRect => const BorderRadius.all(Radius.circular(ezRoundRadius)),
        EzButtonShape.leftGram => BorderRadius.zero,
        EzButtonShape.rightGram => BorderRadius.zero,
        EzButtonShape.gem => BorderRadius.zero,
        EzButtonShape.jewel => BorderRadius.circular(jewelSlope),
      };

  OutlinedBorder get shape => switch (this) {
        EzButtonShape.pill => RoundedSuperellipseBorder(borderRadius: radius),
        EzButtonShape.rect => const RoundedRectangleBorder(),
        EzButtonShape.roundRect => RoundedRectangleBorder(borderRadius: radius),
        EzButtonShape.leftGram => const ParallelogramBorder(lefty: true),
        EzButtonShape.rightGram => const ParallelogramBorder(lefty: false),
        EzButtonShape.gem => const GemBorder(),
        EzButtonShape.jewel => BeveledRectangleBorder(borderRadius: radius),
      };

  BorderRadius get textFieldRadius => switch (this) {
        EzButtonShape.pill => const BorderRadius.only(
            topLeft: Radius.circular(ezRoundRadius),
            topRight: Radius.circular(ezRoundRadius),
          ),
        EzButtonShape.rect => BorderRadius.zero,
        EzButtonShape.roundRect => const BorderRadius.only(
            topLeft: Radius.circular(ezRoundRadius),
            topRight: Radius.circular(ezRoundRadius),
          ),
        EzButtonShape.leftGram => BorderRadius.zero,
        EzButtonShape.rightGram => BorderRadius.zero,
        EzButtonShape.gem => BorderRadius.zero,
        EzButtonShape.jewel => const BorderRadius.only(
            topLeft: Radius.circular(jewelSlope),
            topRight: Radius.circular(jewelSlope),
          ),
      };

  String name(OUILang l10n) => switch (this) {
        EzButtonShape.pill => l10n.dsPill,
        EzButtonShape.rect => l10n.dsRectangle,
        EzButtonShape.roundRect => l10n.dsRoundRectangle,
        EzButtonShape.leftGram => l10n.dsLeftGram,
        EzButtonShape.rightGram => l10n.dsRightGram,
        EzButtonShape.gem => l10n.dsGem,
        EzButtonShape.jewel => l10n.dsJewel,
      }
          .replaceAll(' ', '\n');

  static EzButtonShape? lookup(String? value) => switch (value) {
        esPill => EzButtonShape.pill,
        esRect => EzButtonShape.rect,
        esRoundRect => EzButtonShape.roundRect,
        esLeftGram => EzButtonShape.leftGram,
        esRightGram => EzButtonShape.rightGram,
        esGem => EzButtonShape.gem,
        esJewel => EzButtonShape.jewel,
        _ => null,
      };

  /// Defaults to [EzButtonShape.pill]
  static EzButtonShape safeLookup(String? value) => switch (value) {
        esRect => EzButtonShape.rect,
        esRoundRect => EzButtonShape.roundRect,
        esLeftGram => EzButtonShape.leftGram,
        esRightGram => EzButtonShape.rightGram,
        esGem => EzButtonShape.gem,
        esJewel => EzButtonShape.jewel,
        _ => EzButtonShape.pill,
      };
}

//* Page transitions *//

enum EzTransitionType { none, system, turnX, turnY, rotate, slideX, slideY, zoom }

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

  String name(OUILang l10n) => switch (this) {
        EzTransitionType.none => l10n.dsNone,
        EzTransitionType.system => l10n.dsSystem,
        EzTransitionType.turnX => l10n.dsTurnX,
        EzTransitionType.turnY => l10n.dsTurnY,
        EzTransitionType.rotate => l10n.dsRotate,
        EzTransitionType.slideX => l10n.dsSlideX,
        EzTransitionType.slideY => l10n.dsSlideY,
        EzTransitionType.zoom => l10n.dsZoom,
      }
          .replaceAll(' ', '\n');

  Icon icon(EzCP config) => switch (this) {
        EzTransitionType.none => EzIcon(config, Icons.cancel),
        EzTransitionType.system => EzIcon(
            config,
            EzCM.onMobile
                ? EzCM.platform == TargetPlatform.iOS
                    ? Icons.phone_iphone
                    : Icons.phone_android
                : Icons.computer,
          ),
        EzTransitionType.turnX => EzIcon(config, Icons.flip),
        EzTransitionType.turnY => EzIcon(config, Icons.u_turn_left),
        EzTransitionType.rotate => EzIcon(config, Icons.rotate_90_degrees_cw),
        EzTransitionType.slideX => EzIcon(
            config,
            config.isLTR ? Icons.keyboard_double_arrow_left : Icons.keyboard_double_arrow_right,
          ),
        EzTransitionType.slideY => EzIcon(config, Icons.keyboard_double_arrow_up),
        EzTransitionType.zoom => EzIcon(config, Icons.zoom_in),
      };

  /// Defaults to [EzTransitionType.system]
  static EzTransitionType safeLookup(String? value) => switch (value) {
        esNone => EzTransitionType.none,
        esTurnX => EzTransitionType.turnX,
        esTurnY => EzTransitionType.turnY,
        esRotate => EzTransitionType.rotate,
        esSlideX => EzTransitionType.slideX,
        esSlideY => EzTransitionType.slideY,
        esZoom => EzTransitionType.zoom,
        _ => EzTransitionType.system,
      };
}
