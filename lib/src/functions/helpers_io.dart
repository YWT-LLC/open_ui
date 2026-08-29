/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:io';
import 'package:flutter/services.dart';

/// True if [Platform.isAndroid] or [Platform.isIOS]
bool mobileCheck() => Platform.isAndroid || Platform.isIOS;

/// Get the current [TargetPlatform] the slow (and reliable) way
/// Checking each [Platform].is
/// [TargetPlatform.fuchsia] is currently absorbed by [TargetPlatform.linux]
TargetPlatform getHostPlatform() {
  if (Platform.isAndroid) {
    return TargetPlatform.android;
  } else if (Platform.isIOS) {
    return TargetPlatform.iOS;
  } else if (Platform.isMacOS) {
    return TargetPlatform.macOS;
  } else if (Platform.isWindows) {
    return TargetPlatform.windows;
  } else {
    return TargetPlatform.linux;
  }
}
