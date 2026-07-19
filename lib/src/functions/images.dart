/* empathetech_flutter_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Returns and [AssetImage], [NetworkImage], or [FileImage] based on the [path]
ImageProvider ezImageProvider(String path, {double? scale}) {
  if (EzCM.isPathAsset(path)) {
    return efuiAssetPaths.contains(path) ? efuiImageLookup[path]! : AssetImage(path);
  } else if (ezUrlCheck(path)) {
    return NetworkImage(path, scale: scale ?? 1.0);
  } else {
    return FileImage(File(path), scale: scale ?? 1.0);
  }
}

/// Wraps an [ImagePicker] in a try/catch
/// Provide [prefsPath] to auto save successful results to [config]
Future<String?> ezImagePicker(
  EzCP config, {
  required BuildContext context,
  required ImageSource source,
  String? prefsPath,
}) async {
  try {
    final XFile? picked = await ImagePicker().pickImage(source: source);
    if (picked == null) return null;

    if (prefsPath != null) await EzCM.setString(prefsPath, picked.path);
    return picked.path;
  } on Exception catch (e) {
    final String errorMsg = '${config.ezL10n.dsImgSetFailed}\n${e.toString()}';
    (context.mounted)
        ? await ezLogAlert(config, context: context, message: errorMsg)
        : ezLog(errorMsg);
    return null;
  }
}
