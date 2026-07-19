/* empathetech_flutter_ui
 * Copyright (c) 2022 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzScaffold extends Scaffold {
  /// EzConfig Provider
  final EzCP config;

  /// [List] of (preferably) [FloatingActionButton]s
  final List<Widget> fabs;

  /// [Scaffold] wrapper with ezPresets
  EzScaffold(
    this.config, {
    super.key,
    super.appBar,
    super.drawer,
    super.endDrawer,
    required super.body,
    super.backgroundColor,
    required this.fabs,
  }) : super(
          floatingActionButton: EzCol(children: fabs),
          floatingActionButtonLocation: config.isLefty
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
          resizeToAvoidBottomInset: false,
        );
}
