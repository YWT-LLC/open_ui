/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:open_ui/open_ui.dart';

// App config //

/// Open UI
const String thisAppName = 'Open UI';

/// llc.ywt.open_ui
const String thisPackageName = 'llc.ywt.open_ui';

// App form //

final RegExp appNamePattern = RegExp(r'^[a-z0-9_]+$');

final RegExp domainPattern = RegExp(r'^[a-z0-9_]+\.[a-z]+$');

/// https://docs.flutter.dev/get-started/install
const String installFlutter = 'https://docs.flutter.dev/get-started/install';

// App generator //

enum GeneratorState { running, successful, failed }

// EzConfig //

const String nameBackupKey = 'nameBackup';
const String publisherBackupKey = 'publisherBackup';
const String descriptionBackupKey = 'descriptionBackup';
const String domainBackupKey = 'domainBackup';

const Map<String, Object> openUIDefaults = <String, Object>{
  nameBackupKey: '',
  publisherBackupKey: '',
  descriptionBackupKey: '',
  domainBackupKey: '',
};

final Map<String, Object> mobileDefaults = <String, Object>{
  ...openUIDefaults,
  ...ywtMobileConfig,
};

final Map<String, Object> desktopDefaults = <String, Object>{
  ...openUIDefaults,
  ...ywtDesktopConfig,
};
