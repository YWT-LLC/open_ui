/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

/// [debugPrint] alias; for permanent logging
/// Reserving [debugPrint] for temporary logging makes them easier to remove when the time comes
/// Optionally provide a [prefix] to make log filtering easier (include spaces!)
/// Also supports logging to a [String] 'buffer' (aka [ValueNotifier])
void ezLog(String message, {String prefix = '', int? wrapWidth, ValueNotifier<String>? buffer}) {
  debugPrint(prefix + message, wrapWidth: wrapWidth);
  if (buffer != null) buffer.value += ('$message\n');
}
