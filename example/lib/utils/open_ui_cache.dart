/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class OpenUICache extends EzAppCache {
  Locale _locale;
  Lang _l10n;

  OpenUICache(Locale locale, Lang l10n)
      : _locale = locale,
        _l10n = l10n;

  @override
  void init(_) {}

  @override
  Future<void> rebuild(EzCP config) async {
    if (_locale != config.locale) {
      _locale = config.locale;
      _l10n = await Lang.delegate.load(config.locale);
    }
  }
}

OpenUICache _cache(EzCP config) => config.appCache! as OpenUICache;

Lang l10n(EzCP config) => _cache(config)._l10n;
