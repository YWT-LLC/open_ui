/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

//* BTS *//

/// A *required* [NavigatorState] key for your router config
/// UI redraws/rebuilds assume it is present
final GlobalKey<NavigatorState> ezRootNav = GlobalKey<NavigatorState>();

/// SUCCESS
const String success = 'SUCCESS';

/// example.com/image.jpg
const String webImgHint = 'example.com/image.jpg';

//* Localization *//

const Set<String> cjkCodes = <String>{
  'zh', // Chinese
  'ja', // Japanese
  'ko', // Korean
};

/// Non-conclusive set
const Set<String> rtlCodes = <String>{
  'ar', // Arabic
  'dv', // Divehi (Maldivian)
  'fa', // Persian (Farsi)
  'he', // Hebrew
  'ps', // Pashto
  'sd', // Sindhi
  'ug', // Uyghur
  'ur', // Urdu
  'yi', // Yiddish
};

/// Swipe velocity; 275
const int ezSwipeV = 275;

//* Theme Data *//

/// Opacity for highlight effects; on hover, on focus, etc
/// Doubles as opacity minimum for crucial elements
/// Some things are too important to be broken by user settings
/// 0.12
const double focusOpacity = 0.125;

/// One percent
/// Helpful in many cases, for example whether to show opacity or not
const double oneP = 0.01;

/// One millisecond
/// Helpful for checking whether to show an animation or not
const Duration oneMS = Duration(milliseconds: 1);

/// reliable keyboard opening time
/// 300 milliseconds
const Duration keyTime = Duration(milliseconds: 300);

/// Allows for app images whose default is an asset to be "null"
const String noImageValue = 'noImage';

/// 'MaterialIcons'
/// Useful for creating an [Icon] from an [IconData.codePoint] string
const String matIcons = 'MaterialIcons';

/// 255
const int rMax = 255;

/// Sample string for sizing double input boxes
/// -55.55
const String sampleString = '-55.55';

/// Opacity for text selection highlighting
/// 0.25
const double selectionOpacity = 0.25;

/// 0.333
/// Shadow opacity should be "faster" than surface
/// 1:1 looks foggy
const double shadowMod = 0.333;

const LinearGradient ezRainbow = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
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
