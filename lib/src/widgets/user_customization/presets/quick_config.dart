/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class EzQuickConfig extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// Extra changes for [EzBigButtonsConfig]
  final Future<void> Function(bool)? extraBig;

  /// Extra changes for [EzHighVisibilityConfig]
  final Future<void> Function(bool)? extraVis;

  /// Extra changes for [EzChalkboardConfig]
  final Future<void> Function(bool)? extraChalk;

  /// Extra changes for [EzNebulaConfig]
  final Future<void> Function(bool)? extraNebula;

  /// Extra changes for [EzWallHolesConfig]
  final Future<void> Function(bool)? extraWall;

  /// Opens a [BottomSheet] with [EzElevatedIconButton]s for different presets
  const EzQuickConfig(
    this.config, {
    super.key,
    this.extraBig,
    this.extraVis,
    this.extraChalk,
    this.extraNebula,
    this.extraWall,
  });

  @override
  Widget build(BuildContext context) {
    return EzElevatedIconButton(
      config,
      onPressed: () => ezModal(
        config,
        context: context,
        constraints: BoxConstraints.tight(Size.infinite),
        builder: (_) {
          // Define the build data //

          bool marketplace = false;
          int delta = 0;

          return StatefulBuilder(builder: (_, StateSetter setModal) {
            // Define custom functions //

            void nav(bool choice) {
              delta = choice ? 1 : -1;
              setModal(() => marketplace = choice);
            }

            // Return the build //

            return EzCol(children: <Widget>[
              // Switch
              EzFlipFlop(
                config,
                key: ValueKey<bool>(marketplace),
                init: marketplace,
                onLabel: 'WWW',
                offLabel: 'YWT',
                onChanged: nav,
              ),
              config.spacer,

              // Options
              Expanded(
                child: EzSwipeDetector(
                  rtl: () => marketplace ? doNothing() : nav(true),
                  ltr: () => marketplace ? nav(false) : doNothing,
                  child: EzFauxCarousel(
                    config,
                    position: marketplace ? 1 : 0,
                    delta: delta,
                    child: marketplace
                        ? _ThirdParty(config)
                        : _FirstParty(
                            config,
                            extraBig: extraBig,
                            extraVis: extraVis,
                            extraChalk: extraChalk,
                            extraNebula: extraNebula,
                            extraWall: extraWall,
                          ),
                  ),
                ),
              ),
            ]);
          });
        },
      ),
      icon: EzIcon(config, Icons.edit),
      label: config.ezL10n.ssLoadPreset,
    );
  }
}

class _FirstParty extends StatelessWidget {
  final EzCP config;
  final Future<void> Function(bool)? extraBig;
  final Future<void> Function(bool)? extraVis;
  final Future<void> Function(bool)? extraChalk;
  final Future<void> Function(bool)? extraNebula;
  final Future<void> Function(bool)? extraWall;

  const _FirstParty(
    this.config, {
    required this.extraBig,
    required this.extraVis,
    required this.extraChalk,
    required this.extraNebula,
    required this.extraWall,
  });

  Widget wrapIt(Widget child) => Padding(padding: EzInsets.wrap(config.spacing), child: child);

  @override
  Widget build(BuildContext context) => EzScrollView(config, children: <Widget>[
        EzWrap(children: <Widget>[
          wrapIt(EzBigButtonsConfig(config, updateBoth: false, extra: extraBig)),
          wrapIt(EzHighVisibilityConfig(config, updateBoth: false, extra: extraVis)),
          wrapIt(EzChalkboardConfig(config, autoConfirm: false, extra: extraChalk)),
          wrapIt(EzNebulaConfig(config, autoConfirm: false, extra: extraNebula)),
          wrapIt(EzWallHolesConfig(config, autoConfirm: false, extra: extraWall)),
        ]),
        EzSpacer(config.spacing * 1.5),
      ]);
}

class _ThirdParty extends StatefulWidget {
  final EzCP config;

  const _ThirdParty(this.config);

  @override
  State<_ThirdParty> createState() => _ThirdPartyState();
}

class _ThirdPartyState extends State<_ThirdParty> {
  // Define the build data //

  final TextEditingController emailCon = TextEditingController();
  final TextEditingController paswdCon = TextEditingController();

  bool showPwd = false;

  // Define custom functions //

  String? _noEmpty(String? toCheck) =>
      (toCheck == null || toCheck.isEmpty) ? 'Cannot be empty' : null;

  String? _validateEmail(String? toCheck) =>
      _noEmpty(toCheck) ?? (EmailValidator.validate(toCheck!) ? null : 'Invalid email');

  // Return the build //

  Widget wrapIt(Widget child) =>
      Padding(padding: EzInsets.wrap(widget.config.spacing), child: child);

  @override
  Widget build(BuildContext context) => EzScrollView(widget.config, children: <Widget>[
        AutofillGroup(
          child: EzCol(children: <Widget>[
            // Email field
            EzTextField(
              constraints: ezTextFieldConstraints(context),
              controller: emailCon,
              textAlign: TextAlign.start,
              hintText: 'Enter email',
              autofillHints: const <String>[AutofillHints.email],
              validator: _validateEmail,
            ),
            widget.config.spacer,

            // Password field
            EzTextField(
              constraints: ezTextFieldConstraints(context),
              controller: paswdCon,
              obscureText: !showPwd,
              textAlign: TextAlign.start,
              hintText: 'Enter password',
              autofillHints: const <String>[AutofillHints.password],
              suffixIcon: EzIconTouch(
                widget.config,
                icon: showPwd ? Icons.visibility : Icons.visibility_off,
                tooltip: showPwd ? 'Hide password' : 'Show password',
                onPressed: () => setState(() => showPwd = !showPwd),
              ),
              validator: (_) => null,
              onFieldSubmitted: (String pwd) async {
                final String? error = 'nyi'; // await login(
                //   appUser: Provider.of<UserProvider>(context, listen: false),
                //   email: emailCon.text,
                //   password: pwd,
                // );

                if (context.mounted && error != null && error.isNotEmpty) {
                  ezLogAlert(widget.config, context: context, message: error);
                }
              },
            ),
          ]),
        ),
        widget.config.separator,

        // Buttons
        EzRowCol.sym(widget.config, children: <Widget>[
          // Login
          EzElevatedIconButton(
            widget.config,
            onPressed: () async {
              closeKeyboard(context);
              if (_validateEmail(emailCon.text) != null) {
                ezLogAlert(widget.config, context: context, message: 'Invalid email!');
                return;
              }

              final String? error = 'nyi'; // await login(
              //   appUser: Provider.of<UserProvider>(context, listen: false),
              //   email: emailCon.text,
              //   password: paswdCon.text,
              // );
              if (context.mounted && error != null && error.isNotEmpty) {
                ezLogAlert(widget.config, context: context, message: error);
              }
            },
            icon: const Icon(Icons.login),
            label: 'Login',
          ),
          widget.config.swapSpacer,

          // Sign up
          EzElevatedIconButton(
            widget.config,
            onPressed: () async {
              closeKeyboard(context);
              if (_validateEmail(emailCon.text) != null) {
                ezLogAlert(widget.config, context: context, message: 'Invalid email!');
                return;
              }

              final String? error = 'nyi'; // await signUp(
              //   appUser: Provider.of<UserProvider>(context, listen: false),
              //   email: emailCon.text,
              //   password: paswdCon.text,
              // );
              if (context.mounted && error != null && error.isNotEmpty) {
                ezLogAlert(widget.config, context: context, message: error);
              }
            },
            icon: const Icon(Icons.edit_note_rounded),
            label: 'Sign up',
          ),
        ]),
        widget.config.separator,
      ]);
}
