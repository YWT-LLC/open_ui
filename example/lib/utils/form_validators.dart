/* open_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// Allows letters (upper and lower case) and underscores
String? validateAppName(
  EzCP config,
  String? value, {
  Function? onSuccess,
  Function? onFailure,
}) {
  if (value == null || value.isEmpty) {
    onFailure?.call();
    return '${config.ezL10n.gRequired}; ${l10n(config).csInvalidName.toLowerCase()}';
  } else if (!appNamePattern.hasMatch(value)) {
    onFailure?.call();
    return l10n(config).csInvalidName;
  } else {
    onSuccess?.call();
    return null;
  }
}

String? validatePublisher(
  EzCP config,
  String? value, {
  Function? onSuccess,
  Function? onFailure,
}) {
  if (value == null || value.isEmpty) {
    onFailure?.call();
    return config.ezL10n.gRequired;
  }

  onSuccess?.call();
  return null;
}

String? validateDescription(
  EzCP config,
  String? value, {
  Function? onSuccess,
  Function? onFailure,
}) {
  if (value == null || value.isEmpty) {
    onFailure?.call();
    return config.ezL10n.gRequired;
  }

  onSuccess?.call();
  return null;
}

/// Validates name.extension domains
String? validateDomain(
  EzCP config,
  String? value, {
  Function? onSuccess,
  Function? onFailure,
}) {
  if (value == null || value.isEmpty) {
    onFailure?.call();
    return '${config.ezL10n.gRequired}; ${l10n(config).csInvalidName}';
  } else if (!domainPattern.hasMatch(value)) {
    onFailure?.call();
    return l10n(config).csInvalidDomain;
  } else {
    onSuccess?.call();
    return null;
  }
}
