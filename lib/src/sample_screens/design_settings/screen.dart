/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'button_settings.dart';
import 'page_settings.dart';
import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

// TODO: add \n's to the names of the page transitions (button style too?)

class EzDesignSettings extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Current sub-page
  final EzSubSetting target;

  /// Optional additional settings at the top of the button design tab
  /// BYO tailing spacer(s)
  final List<Widget>? prependButton;

  /// Optional additional settings at the top of the page design tab
  /// BYO tailing spacer(s)
  final List<Widget>? prependPage;

  /// Optionally re-label the button style button
  final String? styleLabel;

  /// Whether to include the background image setting
  /// When true, pairs well with [EzScreen], specifically [EzScreen.useImageDecoration]
  final bool includeBackgroundImage;

  /// Optional additional settings at the bottom of the button design tab (above the reset button)
  /// BYO leading spacer, trailing is [resetSpacerButton]
  final List<Widget>? appendButton;

  /// Optional additional settings at the bottom of the page design tab (above the reset button)
  /// BYO leading spacer, trailing is [resetSpacerPage]
  final List<Widget>? appendPage;

  /// Spacer before the [EzResetButton]
  /// Defaults to [EzCP.separator]
  final Widget? resetSpacerButton;

  /// Spacer before the [EzResetButton]
  /// Defaults to [EzCP.separator]
  final Widget? resetSpacerPage;

  /// Additional [EzCM] keys for the local [EzResetButton]
  /// [darkButtonDesignKeys] by default
  final Set<String>? resetExtraDarkButton;

  /// Additional [EzCM] keys for the local [EzResetButton]
  /// [lightButtonDesignKeys] by default
  final Set<String>? resetExtraLightButton;

  /// Additional [EzCM] keys for the local [EzResetButton]
  /// [darkPageDesignKeys] by default
  final Set<String>? resetExtraDarkPage;

  /// Additional [EzCM] keys for the local [EzResetButton]
  /// [lightPageDesignKeys] by default
  final Set<String>? resetExtraLightPage;

  /// [EzResetButton.resetSkip] passthrough
  final Set<String>? resetSkipButton;

  /// [EzResetButton.saveSkip] passthrough
  final Set<String>? saveSkipButton;

  /// [EzResetButton.resetSkip] passthrough
  final Set<String>? resetSkipPage;

  /// [EzResetButton.saveSkip] passthrough
  final Set<String>? saveSkipPage;

  /// Empathetech image settings
  /// Recommended to use as a [Scaffold.body]
  const EzDesignSettings(
    this.config, {
    super.key,
    required this.target,

    // Button
    this.prependButton,
    this.appendButton,
    this.styleLabel,
    this.resetSpacerButton,
    this.resetExtraDarkButton,
    this.resetExtraLightButton,
    this.resetSkipButton,
    this.saveSkipButton,

    // Page
    this.prependPage,
    this.appendPage,
    this.includeBackgroundImage = true,
    this.resetSpacerPage,
    this.resetExtraDarkPage,
    this.resetExtraLightPage,
    this.resetSkipPage,
    this.saveSkipPage,
  });

  @override
  Widget build(BuildContext context) => EzFauxCarousel(
        config,
        position: target.isFirst ? 0 : 1,
        delta: target.isFirst ? -1 : 1,
        animMod: 0.5,
        child: (target == EzSubSetting.butDesign)
            ? ButtonDesign(
                config,
                prepend: prependButton,
                append: appendButton,
                styleLabel: styleLabel,
                resetSpacer: resetSpacerButton ?? config.separator,
                resetExtraDark: resetExtraDarkButton,
                resetExtraLight: resetExtraLightButton,
                resetSkip: resetSkipButton,
                saveSkip: saveSkipButton,
              )
            : PageDesign(
                config,
                prepend: prependPage,
                includeBackgroundImage: includeBackgroundImage,
                append: appendPage,
                resetSpacer: resetSpacerPage ?? config.separator,
                resetExtraDark: resetExtraDarkPage,
                resetExtraLight: resetExtraLightPage,
                resetSkip: resetSkipPage,
                saveSkip: saveSkipPage,
              ),
      );
}
