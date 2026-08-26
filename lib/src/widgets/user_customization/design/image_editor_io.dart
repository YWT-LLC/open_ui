/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../open_ui.dart';

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:extended_image/extended_image.dart';

class EzImageEditor extends StatefulWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [File] path of the image being edited
  final String path;

  /// [ExtendedImageMode.editor] cropAspectRatio passthrough
  /// If null, it will mirror the window's aspect ratio
  /// Use [CropAspectRatios.custom] for freeform
  final double? cropAspectRatio;

  /// [ExtendedImageMode.editor] initialCropAspectRatio passthrough
  /// If null, it will mirror the window's aspect ratio
  /// Use [CropAspectRatios.custom] for freeform
  final double? initialCropAspectRatio;

  /// [ExtendedImageMode.editor] initCropRectType passthrough
  final InitCropRectType initCropRectType;

  /// Allows the user to crop/zoom/rotate the image
  /// Intended to be used in a full-screen modal
  const EzImageEditor(
    this.config, {
    super.key,
    required this.path,
    this.initCropRectType = InitCropRectType.imageRect,
    this.cropAspectRatio,
    this.initialCropAspectRatio,
  }) : assert(
          cropAspectRatio == null ||
              initialCropAspectRatio == null ||
              cropAspectRatio == initialCropAspectRatio,
          'If both cropAspectRatio and initialCropAspectRatio are provided, they must be equal.',
        );

  @override
  State<EzImageEditor> createState() => _EzImageEditorState();
}

class _EzImageEditorState extends State<EzImageEditor> {
  // Define the build data //

  late final Duration rotateDuration = ezDuration(widget.config.animDur, mod: 0.5);

  final ImageEditorController _editorController = ImageEditorController();
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();

  bool processing = false;
  bool lockedAR = true;
  late String fileExt;

  // Define custom functions && widgets //

  double liveAspectRatio() {
    final Size size = MediaQuery.of(context).size;
    return size.width / size.height;
  }

  Widget keyIcon(
    EzCP config, {
    required IconData icon,
    required Color color,
    required String name,
    required String tooltip,
  }) =>
      Tooltip(
        message: tooltip,
        excludeFromSemantics: false,
        child: ExcludeSemantics(
          child: EzCol(children: <Widget>[
            EzIcon(config, icon, color: color),
            widget.config.margin,
            EzText(
              widget.config,
              text: name,
              textAlign: TextAlign.center,
              style: widget.config.labelStyle?.copyWith(color: color),
            ),
          ]),
        ),
      );

  // Init //

  void updateState() => setState(() {});

  @override
  void initState() {
    super.initState();
    _editorController.addListener(updateState);

    // Get the file extension
    final String path = widget.path;
    final int dot = path.lastIndexOf('.');

    fileExt = (dot != -1 && dot < path.length - 1) ? path.substring(dot + 1).toLowerCase() : 'jpg';
    if (fileExt == 'jpeg') fileExt = 'jpg';

    if (!<String>['bmp', 'gif', 'jpg', 'png'].contains(fileExt)) {
      fileExt = 'jpg';
    }
  }

  @override
  Widget build(BuildContext context) => EzCol(mainAxisSize: MainAxisSize.max, children: <Widget>[
        // Top controls
        Padding(
          padding: EdgeInsets.only(
            left: widget.config.marginVal,
            right: widget.config.marginVal,
            top: safeTop(context) + widget.config.spacing,
            bottom: widget.config.spacing,
          ),
          child: EzScrollView(
            widget.config,
            scrollDirection: Axis.horizontal,
            startCentered: true,
            showScrollHint: true,
            children: <Widget>[
              // Undo
              EzIconButton(
                widget.config,
                tooltip: widget.config.ezL10n.gUndo,
                enabled: !processing && _editorController.canUndo,
                onPressed: () {
                  _editorController.undo();
                  setState(() {});
                },
                icon: const Icon(Icons.undo),
              ),
              widget.config.rowSpacer,

              // Redo
              EzIconButton(
                widget.config,
                tooltip: widget.config.ezL10n.gRedo,
                enabled: !processing && _editorController.canRedo,
                onPressed: () {
                  _editorController.redo();
                  setState(() {});
                },
                icon: const Icon(Icons.redo),
              ),
              widget.config.rowSpacer,

              // Reset
              EzIconButton(
                widget.config,
                tooltip: widget.config.ezL10n.gReset,
                enabled: !processing,
                onPressed: () {
                  _editorController.reset();
                  setState(() {});
                },
                icon: const Icon(Icons.refresh),
              ),
              widget.config.rowSpacer,

              // Cancel
              EzIconButton(
                widget.config,
                tooltip: widget.config.ezL10n.gCancel,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),

        // Preview
        Expanded(
          child: ExtendedImage.file(
            File(widget.path),
            fit: BoxFit.contain,
            mode: ExtendedImageMode.editor,
            extendedImageEditorKey: editorKey,
            enableLoadState: true,
            cacheRawData: true,
            initEditorConfigHandler: (_) => EditorConfig(
              cropAspectRatio: lockedAR ? (widget.cropAspectRatio ?? liveAspectRatio()) : null,
              initialCropAspectRatio: widget.initialCropAspectRatio ?? liveAspectRatio(),
              initCropRectType: widget.initCropRectType,
              cropRectPadding: EdgeInsets.only(
                top: widget.config.spacing,
                left: widget.config.spacing,
                right: widget.config.spacing,
              ),
              hitTestSize: max(widget.config.padding, kMinInteractiveDimension),
              controller: _editorController,
            ),
          ),
        ),

        // Bottom controls
        Padding(
          padding: EdgeInsets.only(
            left: widget.config.marginVal,
            right: widget.config.marginVal,
            top: widget.config.spacing,
            bottom: safeBottom(context),
          ),
          child: EzScrollView(
            widget.config,
            scrollDirection: Axis.horizontal,
            startCentered: true,
            showScrollHint: true,
            children: <Widget>[
              // Toggle aspect ratio lock
              EzIconButton(
                widget.config,
                fauxDisabled: !lockedAR,
                icon: const Icon(Icons.aspect_ratio),
                tooltip: widget.config.ezL10n.gLock,
                onPressed: () => setState(() => lockedAR = !lockedAR),
              ),
              widget.config.rowSpacer,

              // Rotate left
              EzIconButton(
                widget.config,
                tooltip: widget.config.ezL10n.dsRotateLeft,
                enabled: !processing,
                onPressed: () {
                  _editorController.rotate(
                    degree: -90.0,
                    rotateCropRect: false,
                    animation: rotateDuration.inMilliseconds > 0 ? true : false,
                    duration: rotateDuration,
                  );
                  setState(() {});
                },
                icon: const Icon(Icons.rotate_left),
              ),
              widget.config.rowSpacer,

              // Rotate right
              EzIconButton(
                widget.config,
                tooltip: widget.config.ezL10n.dsRotateRight,
                enabled: !processing,
                onPressed: () {
                  _editorController.rotate(
                    rotateCropRect: false,
                    animation: rotateDuration.inMilliseconds > 0 ? true : false,
                    duration: rotateDuration,
                  );
                  setState(() {});
                },
                icon: const Icon(Icons.rotate_right),
              ),
              widget.config.rowSpacer,

              // Done
              EzIconButton(
                widget.config,
                tooltip: widget.config.ezL10n.gApply,
                onPressed: () async {
                  // Check exit cases
                  if (processing) return;

                  final ExtendedImageEditorState? state = editorKey.currentState;
                  if (state == null) return;

                  setState(() => processing = true);

                  try {
                    // Get image data
                    final Uint8List imgData = state.rawImageData;
                    img.Image? src = img.decodeImage(imgData);

                    if (src == null) {
                      setState(() => processing = false);
                      return;
                    }

                    // Get the edits
                    final EditActionDetails? editAction = state.editAction;
                    final Rect? cropRect = state.getCropRect();

                    // Apply the edits
                    if (editAction != null) {
                      src = img.bakeOrientation(src);

                      if (editAction.hasRotateDegrees) {
                        src = img.copyRotate(src, angle: editAction.rotateDegrees);
                      }

                      if (editAction.needCrop && cropRect != null) {
                        src = img.copyCrop(
                          src,
                          x: cropRect.left.toInt(),
                          y: cropRect.top.toInt(),
                          width: cropRect.width.toInt(),
                          height: cropRect.height.toInt(),
                        );
                      }
                    }

                    // Encode the image
                    late final Uint8List fileData;
                    switch (fileExt) {
                      case 'bmp':
                        fileData = await compute(img.encodeBmp, src);
                        break;
                      case 'gif':
                        fileData = await compute(img.encodeGif, src);
                        break;
                      case 'png':
                        fileData = await compute(img.encodePng, src);
                        break;
                      default:
                        fileExt = 'jpg';
                        fileData = await compute(img.encodeJpg, src);
                        break;
                    }

                    // Save to a new file
                    final Directory tempDir = await getTemporaryDirectory();
                    final String newPath =
                        '${tempDir.path}/edited_${DateTime.now().millisecondsSinceEpoch}.$fileExt';
                    final File newFile = File(newPath)..writeAsBytesSync(fileData);

                    // Return the new file path
                    setState(() => processing = false);
                    if (context.mounted) {
                      Navigator.pop(context, newFile.path);
                    }
                  } catch (e) {
                    (context.mounted)
                        ? await ezLogAlert(widget.config, context: context, message: e.toString())
                        : ezLog(e.toString());
                    setState(() => processing = false);
                  }
                },
                icon: processing ? const CircularProgressIndicator() : const Icon(Icons.check),
              ),
            ],
          ),
        ),
      ]);

  @override
  void dispose() {
    _editorController.removeListener(updateState);
    _editorController.dispose();
    super.dispose();
  }
}
