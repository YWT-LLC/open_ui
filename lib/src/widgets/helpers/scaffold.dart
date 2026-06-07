/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzScaffold extends Scaffold {
  /// [List] of (preferably) [FloatingActionButton]s
  final List<Widget> fabs;

  /// [Scaffold] wrapper with ezPresets
  EzScaffold({
    super.key,
    super.appBar,
    super.drawer,
    super.endDrawer,
    required super.body,
    super.backgroundColor,
    required this.fabs,
  }) : super(
          floatingActionButton: EzCol(children: fabs),
          floatingActionButtonLocation: EzCM.isLefty
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
          resizeToAvoidBottomInset: false,
        );
}
