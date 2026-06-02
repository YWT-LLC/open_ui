/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzScaffold extends Scaffold {
  final int seed;
  final List<Widget> fabs;

  EzScaffold({
    required this.seed,
    super.appBar,
    super.drawer,
    super.endDrawer,
    required super.body,
    super.backgroundColor,
    required this.fabs,
  }) : super(
          key: ValueKey<int>(seed),
          floatingActionButton: EzCol(children: fabs),
          floatingActionButtonLocation: EzConfig.isLefty
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
          resizeToAvoidBottomInset: false,
        );
}
