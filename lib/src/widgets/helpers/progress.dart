/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:flutter/material.dart';

class EzProgress extends StatelessWidget {
  final EzCP config;

  /// YWT logo to replace the [CircularProgressIndicator]
  const EzProgress(this.config, {super.key});

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints.tight(Size.square(config.iconSize + config.padding)),
        child: ywt.YWTime(
          semantics: 'Loading', // TODO
          colorScheme: config.colors,
        ),
      );
}
