/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';
import './image_editor_io.dart' if (dart.library.html) './image_editor_web.dart';

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class EzImageSetting extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [config] key for the path
  final String pathKey;

  /// [config] key for the [BoxFit]
  /// Nullable - param is required to avoid confusion
  final String? fitKey;

  /// Optional [config] key for the image source
  final String? sourceKey;

  /// [EzElevatedIconButton.label] passthrough
  final String label;

  /// If true, opens an [ezColorPicker] for the user, and saves the hex value (string) as the image path
  final bool allowSolidColor;

  /// Effectively whether the image is nullable
  /// true is recommended
  /// Note: if there is no default value for [pathKey], the reset option will not appear
  final bool allowClear;

  /// Optionally override the clear button label
  /// Moot if [allowClear] is false
  final String? clearLabel;

  /// null will display a choice to the user
  final bool? setColors;

  /// Whether the [EzImageEditor] should be displayed upon successful image selection
  /// [AssetImage]s cannot be edited/will be skipped
  final bool showEditor;

  /// Whether the [BoxFit] options dialog should be displayed upon successful image selection
  final bool showFitOption;

  /// [EzElevatedIconButton] for updating the image at [pathKey]'s path
  const EzImageSetting(
    this.config, {
    super.key,
    required this.pathKey,
    required this.fitKey,
    this.sourceKey,
    required this.label,
    this.allowSolidColor = false,
    this.allowClear = true,
    this.clearLabel,
    this.setColors,
    this.showEditor = true,
    this.showFitOption = true,
  });

  @override
  State<EzImageSetting> createState() => _ImageSettingState();
}

class _ImageSettingState extends State<EzImageSetting> {
  // Define the build data //

  late String? currPath = EzCM.get(widget.pathKey);
  late BoxFit? currFit = (widget.fitKey == null) ? null : boxFitLib[EzCM.get(widget.fitKey!)];

  bool fromLocal = false;

  bool inProgress = false;
  late bool updateTheme = widget.setColors ?? false;

  late final TextEditingController urlController = TextEditingController();

  // Define custom widgets && functions //

  /// Open an [EzAlertDialog] with the [Image]s source information
  Future<void> showSource() async {
    if (currPath == null || currPath == noImageValue) return;

    final String credits =
        (widget.sourceKey == null) ? currPath : EzCM.get(widget.sourceKey!) ?? currPath;

    return showDialog(
      context: context,
      builder: (_) => EzAlertDialog(
        widget.config,
        title: Text(widget.config.ezL10n.gSource, textAlign: TextAlign.center),
        content: ezUrlCheck(credits)
            ? EzLink(
                widget.config,
                text: credits,
                url: Uri.parse(credits),
                backgroundColor: widget.config.colors.surfaceDim,
                hint: widget.config.ezL10n.gOpenLink,
              )
            : Text(credits, textAlign: TextAlign.center),
      ),
    );
  }

  /// Cleanup any custom [File]s
  Future<void> fileCleanup() async {
    if (!EzCM.isKeyAsset(widget.pathKey)) {
      try {
        final File toDelete = File(widget.pathKey);
        await toDelete.delete();
      } catch (e) {
        ezLog(e.toString());
      }
    }
  }

  /// Validate a URL
  String? validateUrl(String? value) => (value == null || value.isEmpty || !ezUrlCheck(value))
      ? widget.config.ezL10n.gValidURL
      : null;

  /// First-layer [ElevatedButton.onPressed]
  /// Opens an options modal and updates the state accordingly
  Future<bool> activateSetting() async {
    // Get an image (path) from the user
    String? newPath = await ezModal<String?>(
      widget.config,
      context: context,
      builder: (BuildContext mCon) => StatefulBuilder(
        builder: (_, StateSetter setModal) => EzScrollView(
          widget.config,
          children: sourceOptions(mCon, setModal),
        ),
      ),
    );

    // Check for quick cases
    if (newPath == noImageValue) return currPath != noImageValue;
    if (newPath == null || newPath.isEmpty) return false;

    // Check if a color was chosen
    final bool isInt = (int.tryParse(newPath) != null);

    // Edit image (when applicable)
    if (!isInt && fromLocal && widget.showEditor && !kIsWeb && !EzCM.isPathAsset(newPath)) {
      if (mounted) {
        final Future<dynamic> Function(String path) toDo = await showDialog(
          context: context,
          builder: (BuildContext dCon) => EzAlertDialog(
            widget.config,
            title: Text(widget.config.ezL10n.dsUseFull, textAlign: TextAlign.center),
            actions: <EzMaterialAction>[
              EzMaterialAction(
                widget.config,
                text: widget.config.ezL10n.gYes,
                onPressed: () => Navigator.of(dCon).pop((_) => Future<dynamic>.value(true)),
              ),
              EzMaterialAction(
                widget.config,
                text: widget.config.ezL10n.dsCrop,
                onPressed: () => Navigator.of(dCon).pop(editImage),
              ),
              EzMaterialAction(
                widget.config,
                text: widget.config.ezL10n.gCancel,
                onPressed: () => Navigator.of(dCon).pop((_) => Future<dynamic>.value(null)),
              ),
            ],
            needsClose: false,
          ),
        );

        final dynamic result = await toDo(newPath);
        switch (result.runtimeType) {
          case const (bool):
            break;
          case const (String):
            newPath = result;
            break;
          default:
            return false;
        }
      }
      // Re-check exit/cancel
      if (newPath == null || newPath.isEmpty || newPath == noImageValue) {
        return false;
      }
    }

    // Choose fit (when applicable)
    if (!isInt && widget.showFitOption && widget.fitKey != null) {
      final bool canceled = (await chooseFit(newPath) == null);
      if (canceled) return false;
    }

    // Set the new path
    final bool setPath = await EzCM.setString(widget.pathKey, newPath);
    if (!setPath) {
      (mounted)
          ? await ezLogAlert(
              widget.config,
              context: context,
              message: widget.config.ezL10n.dsImgSetFailed,
            )
          : ezLog(widget.config.ezL10n.dsImgSetFailed);
      return false;
    }
    currPath = newPath;

    // Update the theme (conditionally)
    if (!isInt && updateTheme) {
      if (EzCM.updateBoth || widget.config.isDark) {
        // If there is little/no text background opacity, set it to 50%
        // Better to have to turn it down than up, they'll be a lot of images where people suddenly won't be able to read
        final double? opacity = EzCM.get(darkTextBackgroundOpacityKey);
        if (opacity == null || opacity <= 0.05) {
          await EzCM.setDouble(darkTextBackgroundOpacityKey, 0.50);
        }

        final String result = await loadImageColorScheme(newPath, Brightness.dark);

        if (result == success) {
          await EzCM.setString(darkColorSchemeImageKey, newPath);
        } else {
          final String errorMsg =
              '$result${ezUrlCheck(newPath) ? '\n\n${widget.config.ezL10n.dsImgPermission}' : ''}';
          (mounted)
              ? await ezLogAlert(
                  widget.config,
                  context: context,
                  title: widget.config.ezL10n.dsImgGetFailed,
                  message: errorMsg,
                )
              : ezLog(errorMsg);
        }
      }

      if (EzCM.updateBoth || !widget.config.isDark) {
        // If there is little/no text background opacity, set it to 50%
        // Better to have to turn it down than up, they'll be a lot of images where people suddenly won't be able to read
        final double? opacity = EzCM.get(lightTextBackgroundOpacityKey);
        if (opacity == null || opacity <= 0.05) {
          await EzCM.setDouble(lightTextBackgroundOpacityKey, 0.50);
        }

        final String result = await loadImageColorScheme(newPath, Brightness.light);

        if (result == success) {
          await EzCM.setString(lightColorSchemeImageKey, newPath);
        } else {
          final String errorMsg =
              '$result${ezUrlCheck(newPath) ? '\n\n${widget.config.ezL10n.dsImgPermission}' : ''}';
          (mounted)
              ? await ezLogAlert(
                  widget.config,
                  context: context,
                  title: widget.config.ezL10n.dsImgGetFailed,
                  message: errorMsg,
                )
              : ezLog(errorMsg);
        }
      }
    }
    return true;
  }

  /// Build the list of [ImageSource] options
  List<Widget> sourceOptions(BuildContext mCon, StateSetter setModal) {
    final List<Widget> options = <Widget>[];
    final String? defaultPath = EzCM.getDefault(widget.pathKey);

    final EdgeInsets wrapPadding = EzInsets.wrap(widget.config.spacing);

    // From camera
    // Only works on mobile
    if (!kIsWeb && EzCM.onMobile) {
      options.add(Padding(
        padding: wrapPadding,
        child: EzElevatedIconButton(
          widget.config,
          onPressed: () async {
            final String? picked = await ezImagePicker(
              widget.config,
              context: context,
              source: ImageSource.camera,
            );

            fromLocal = true;
            if (mCon.mounted) Navigator.of(mCon).pop(picked);
          },
          icon: EzIcon(widget.config, Icons.camera),
          label: widget.config.ezL10n.dsFromCamera,
        ),
      ));
    }

    // From file
    // Doesn't work on Web
    if (!kIsWeb) {
      options.add(Padding(
        padding: wrapPadding,
        child: EzElevatedIconButton(
          widget.config,
          onPressed: () async {
            final String? picked = await ezImagePicker(
              widget.config,
              context: context,
              source: ImageSource.gallery,
            );

            fromLocal = true;
            if (mCon.mounted) Navigator.of(mCon).pop(picked);
          },
          icon: EzIcon(widget.config, Icons.folder),
          label: widget.config.ezL10n.dsFromFile,
        ),
      ));
    }

    // From network
    // Works everywhere
    options.add(Padding(
      padding: wrapPadding,
      child: EzElevatedIconButton(
        widget.config,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext dCon) => EzAlertDialog(
            widget.config,
            title: Text(
              widget.config.ezL10n.gEnterURL,
              textAlign: TextAlign.center,
            ),
            content: Form(
              child: EzPasteField(
                widget.config,
                controller: urlController,
                autofillHints: const <String>[AutofillHints.url],
                decoration: const InputDecoration(hintText: webImgHint),
                validator: validateUrl,
              ),
            ),
            actions: ezActionPair(
              widget.config,
              confirmMsg: widget.config.ezL10n.gApply,
              onConfirm: () async {
                closeKeyboard(dCon);

                // Validate the URL
                final String url = urlController.text.trim();
                if (validateUrl(url) != null) return;

                // Verify that the image is accessible
                try {
                  final Completer<void> completer = Completer<void>();
                  final ImageStream stream = NetworkImage(url).resolve(const ImageConfiguration());

                  late ImageStreamListener listener;
                  listener = ImageStreamListener(
                    // onImage (onSuccess)
                    (_, __) {
                      completer.complete();
                      stream.removeListener(listener);
                    },
                    onError: (Object error, StackTrace? stackTrace) {
                      completer.completeError(error, stackTrace);
                      stream.removeListener(listener);
                    },
                  );

                  stream.addListener(listener);
                  await completer.future;
                } catch (e) {
                  if (dCon.mounted) {
                    Navigator.of(dCon).pop(null);
                  }
                  if (mCon.mounted) {
                    Navigator.of(mCon).pop(null);
                  }

                  final String errorMsg =
                      '${e.toString()}\n\n${widget.config.ezL10n.dsImgPermission}';
                  (mounted)
                      ? await ezLogAlert(
                          widget.config,
                          context: context,
                          title: widget.config.ezL10n.dsImgGetFailed,
                          message: errorMsg,
                        )
                      : ezLog(errorMsg);
                  return;
                }

                // Pop dialogs
                if (dCon.mounted) {
                  Navigator.of(dCon).pop(url);
                }

                if (mCon.mounted) {
                  Navigator.of(mCon).pop(url);
                }
              },
              confirmIsDestructive: true,
              denyMsg: widget.config.ezL10n.gCancel,
              onDeny: () => Navigator.of(dCon).pop(null),
            ),
            needsClose: false,
          ),
        ),
        icon: EzIcon(widget.config, Icons.computer_outlined),
        label: widget.config.ezL10n.dsFromNetwork,
      ),
    ));

    // Solid color (optional)
    if (widget.allowSolidColor) {
      options.add(Padding(
        padding: wrapPadding,
        child: EzElevatedIconButton(
          widget.config,
          onPressed: () async {
            final int? pathARGB = (currPath == null) ? null : int.tryParse(currPath!);
            Color currColor =
                pathARGB == null ? widget.config.colors.surfaceContainer : Color(pathARGB);

            await ezColorPicker(
              widget.config,
              context: context,
              startColor: currColor,
              onColorChange: (Color color) => setModal(() => currColor = color),
              onConfirm: () async {
                await EzCM.setString(
                  widget.pathKey,
                  currColor.toARGB32().toString(),
                );

                if (mCon.mounted) {
                  Navigator.of(mCon).pop(currColor.toARGB32().toString());
                }
              },
              onDeny: doNothing,
            );
          },
          icon: EzIcon(widget.config, Icons.color_lens),
          label: widget.config.ezL10n.dsSolidColor,
        ),
      ));
    }

    // Reset
    if (defaultPath != null && defaultPath != noImageValue) {
      options.add(Padding(
        padding: wrapPadding,
        child: EzElevatedIconButton(
          widget.config,
          onPressed: () async {
            await fileCleanup();
            await EzCM.remove(widget.pathKey);

            if (mCon.mounted) {
              Navigator.of(mCon).pop(defaultPath);
            }
          },
          icon: EzIcon(widget.config, Icons.refresh),
          label: widget.config.ezL10n.dsResetIt,
        ),
      ));
    }

    // Clear (optional)
    if (widget.allowClear) {
      options.add(Padding(
        padding: wrapPadding,
        child: EzElevatedIconButton(
          widget.config,
          onPressed: () async {
            await fileCleanup();
            await EzCM.setString(widget.pathKey, noImageValue);

            if (mCon.mounted) {
              Navigator.of(mCon).pop(noImageValue);
            }
          },
          icon: EzIcon(widget.config, Icons.clear),
          label: widget.clearLabel ?? widget.config.ezL10n.dsClearIt,
        ),
      ));
    }

    // Return the options, with the conditional update theme switch
    return <Widget>[
      if (widget.showFitOption &&
          widget.fitKey != null &&
          currPath != null &&
          currPath != noImageValue) ...<Widget>[
        EzElevatedIconButton(
          widget.config,
          onPressed: () async {
            final bool? changed = await chooseFit(currPath!);
            if (changed == true) {
              await widget.config.rebuildUI(<EzCacheType>{EzCacheType.color, EzCacheType.design});
            }
          },
          icon: EzIcon(widget.config, Icons.image_aspect_ratio),
          label: widget.config.ezL10n.dsReFit,
        ),
        widget.config.spacer,
      ],
      EzWrap(children: options),
      if (widget.setColors == null)
        Padding(
          padding: EdgeInsets.symmetric(vertical: widget.config.spacing / 2),
          child: EzSwitchPair(
            widget.config,
            key: ValueKey<bool>(updateTheme),
            text: widget.config.ezL10n.dsUseForColors,
            value: updateTheme,
            onChanged: (bool? choice) {
              if (choice == null) return;
              setModal(() => updateTheme = choice);
              setState(() {});
            },
          ),
        ),
      widget.config.spacer,
    ];
  }

  /// Opens [EzImageEditor] and overrides the image as necessary
  Future<String?> editImage(String path) async {
    final String? editResult = await ezModal<String?>(
      widget.config,
      context: context,
      enableDrag: false,
      useSafeArea: false,
      isDismissible: false,
      showDragHandle: false,
      builder: (_) => EzImageEditor(widget.config, path: path),
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        minHeight: double.infinity,
      ),
    );

    return (editResult != null && editResult.isNotEmpty) ? editResult : null;
  }

  /// Opens a preview modal for choosing the desired [BoxFit]
  Future<bool?> chooseFit(String path) {
    final double width = widthOf(context) * 0.25;
    final double height = heightOf(context) * 0.25;

    return ezModal<bool?>(
      widget.config,
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (BuildContext fitContext, StateSetter fitState) => EzScrollView(
          widget.config,
          children: <Widget>[
            Text(
              widget.config.ezL10n.dsFit,
              style: widget.config.titleStyle,
              textAlign: TextAlign.center,
            ),
            widget.config.margin,
            RadioGroup<BoxFit>(
              groupValue: currFit,
              onChanged: (BoxFit? value) {
                currFit = value;
                fitState(() {});
              },
              child: EzScrollView(
                widget.config,
                scrollDirection: Axis.horizontal,
                showScrollHint: true,
                primary: false,
                children: <Widget>[
                  widget.config.rowSpacer,
                  fitPreview(
                    path: path,
                    fit: BoxFit.contain,
                    width: width,
                    height: height,
                    modalContext: fitContext,
                    setModal: fitState,
                  ),
                  widget.config.rowSpacer,
                  fitPreview(
                    path: path,
                    fit: BoxFit.cover,
                    width: width,
                    height: height,
                    modalContext: fitContext,
                    setModal: fitState,
                  ),
                  widget.config.rowSpacer,
                  fitPreview(
                    path: path,
                    fit: BoxFit.fill,
                    width: width,
                    height: height,
                    modalContext: fitContext,
                    setModal: fitState,
                  ),
                  widget.config.rowSpacer,
                  fitPreview(
                    path: path,
                    fit: BoxFit.fitWidth,
                    width: width,
                    height: height,
                    modalContext: fitContext,
                    setModal: fitState,
                  ),
                  widget.config.rowSpacer,
                  fitPreview(
                    path: path,
                    fit: BoxFit.fitHeight,
                    width: width,
                    height: height,
                    modalContext: fitContext,
                    setModal: fitState,
                  ),
                  widget.config.rowSpacer,
                  fitPreview(
                    path: path,
                    fit: BoxFit.none,
                    width: width,
                    height: height,
                    modalContext: fitContext,
                    setModal: fitState,
                  ),
                  widget.config.rowSpacer,
                  fitPreview(
                    path: path,
                    fit: BoxFit.scaleDown,
                    width: width,
                    height: height,
                    modalContext: fitContext,
                    setModal: fitState,
                  ),
                  widget.config.rowSpacer,
                ],
              ),
            ),
            widget.config.spacer,
            EzRow(
              widget.config,
              mainAxisAlignment:
                  widget.config.isLefty ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: <Widget>[
                widget.config.rowSpacer,
                EzTextButton(
                  widget.config,
                  onPressed: () => Navigator.of(fitContext).pop(null),
                  text: widget.config.ezL10n.gCancel,
                  textStyle: widget.config.bodyStyle,
                  textAlign: TextAlign.center,
                ),
                widget.config.rowSpacer,
                EzTextButton(
                  widget.config,
                  onPressed: () async {
                    if (currFit != null && widget.fitKey != null) {
                      await EzCM.setString(widget.fitKey!, currFit!.name);
                    }
                    if (fitContext.mounted) {
                      Navigator.of(fitContext).pop(true);
                    }
                  },
                  text: currFit == null ? widget.config.ezL10n.gSkip : widget.config.ezL10n.gApply,
                  textStyle: widget.config.bodyStyle?.copyWith(color: widget.config.colors.primary),
                  textAlign: TextAlign.center,
                ),
                widget.config.rowSpacer,
              ],
            ),
            widget.config.separator,
          ],
        ),
      ),
    );
  }

  /// Creates a mini-[Scaffold] to preview the [BoxFit] option(s)
  Widget fitPreview({
    required String path,
    required BoxFit fit,
    required double width,
    required double height,
    required BuildContext modalContext,
    required StateSetter setModal,
  }) {
    final double toolbarHeight =
        ezTextSize(fit.name, style: widget.config.bodyStyle, context: modalContext).height +
            (widget.config.marginVal * 0.25);

    return EzCol(children: <Widget>[
      GestureDetector(
        onTap: () {
          currFit = fit;
          setModal(() {});
        },
        child: Semantics(
          hint: fit.name,
          image: true,
          button: true,
          child: ExcludeSemantics(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.config.colors.onSurface,
                  width: widget.config.borderWidth,
                ),
                borderRadius: widget.config.textRadius,
              ),
              child: EzCol(
                children: <Widget>[
                  Container(
                    height: toolbarHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: widget.config.colors.surface,
                      borderRadius: widget.config.textFieldRadius,
                    ),
                    child: Text(
                      fit.name,
                      style: widget.config.bodyStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Image(
                      image: ezImageProvider(path),
                      fit: fit,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ExcludeSemantics(child: EzRadio<BoxFit>(widget.config, value: fit)),
    ]);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final int? pathARGB = (currPath == null) ? null : int.tryParse(currPath!);

    return Semantics(
      label: widget.label,
      button: true,
      hint: widget.config.ezL10n.dsImgSettingHint(widget.label),
      child: ExcludeSemantics(
        child: EzElevatedIconButton(
          widget.config,
          onPressed: () async {
            if (inProgress) return;

            setState(() {
              inProgress = true;
              fromLocal = false;
            });
            final bool changed = await activateSetting();

            if (changed) {
              await widget.config.rebuildUI(<EzCacheType>{EzCacheType.color, EzCacheType.design});
            }
            setState(() => inProgress = false);
          },
          onLongPress: inProgress ? doNothing : showSource,
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.config.colors.onSurface,
                width: widget.config.borderWidth,
              ),
            ),
            child: CircleAvatar(
              radius: widget.config.iconSize + widget.config.padding,
              foregroundImage:
                  (inProgress || currPath == null || currPath == noImageValue || pathARGB != null)
                      ? null
                      : ezImageProvider(currPath!),
              backgroundColor: (pathARGB != null) ? Color(pathARGB) : Colors.transparent,
              foregroundColor: widget.config.colors.onSurface,
              child: inProgress
                  ? const CircularProgressIndicator()
                  : (currPath == null || currPath == noImageValue)
                      ? EzIcon(
                          widget.config,
                          Icons.image_search,
                          color: widget.config.colors.primary,
                        )
                      : null,
            ),
          ),
          label: widget.label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }
}
