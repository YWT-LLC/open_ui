/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:flutter/material.dart';

class EzNewLine extends StatelessWidget {
  /// [Text.style] passthrough
  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [Text.textAlign] passthrough
  /// Defaults to [TextAlign.start]
  final TextAlign? textAlign;

  /// Quick wrapper for creating a [TextStyle]d '' [Text]
  const EzNewLine(this.style, {super.key, this.textAlign});

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: Text('', style: style, textAlign: textAlign ?? TextAlign.start),
      );
}

class EzRichLine extends EzPlainText {
  /// Quick wrapper for creating a [TextStyle]d '\n' [EzPlainText]
  const EzRichLine({super.style}) : super(text: '\n');
}

class EzText extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// [Text.data] passthrough
  final String text;

  /// [Text.style] passthrough
  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// [Text.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [Text.maxLines] passthrough
  final int? maxLines;

  /// [Text.overflow] passthrough
  final TextOverflow? overflow;

  /// [EzTextBackground.shape] passthrough
  final EzButtonShape? shape;

  /// [EzTextBackground.baseColor] passthrough
  final Color? baseColor;

  /// [EzTextBackground.backgroundColor] passthrough
  final Color? backgroundColor;

  /// Quick wrapper for creating [Text] with a default [EzTextBackground]
  /// [style] defaults to [TextTheme.bodyLarge]
  const EzText(
    this.config, {
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.semanticsLabel,
    this.maxLines,
    this.overflow,
    this.shape,
    this.baseColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => EzTextBackground(
        config,
        text: Text(
          text,
          style: style ?? config.bodyStyle,
          textAlign: textAlign,
          semanticsLabel: semanticsLabel,
          maxLines: maxLines,
          overflow: overflow,
        ),
        shape: shape,
        baseColor: baseColor,
        backgroundColor: backgroundColor,
      );
}

class EzTextBackground extends StatelessWidget {
  /// EzConfig Provider
  final EzCP config;

  /// The [Widget] that needs a background
  /// Doesn't have to be [Text]
  final Widget text;

  /// Optional override
  /// Defaults to [EdgeInsets.all] w/ [EzCP.marginVal]
  /// Override is always present, default is only present when [EzCP.textBackgroundOpacity] >= [oneP]
  final EdgeInsets? padding;

  /// Optional border override ([BoxDecoration] passthrough)
  final BorderRadiusGeometry? borderRadius;

  /// Optional shape override
  final EzButtonShape? shape;

  /// Uses [EzCP.textBackgroundOpacity]
  /// Defaults to [ColorScheme.surfaceContainer]
  final Color? baseColor;

  /// Full override
  final Color? backgroundColor;

  /// Create a [Container] for your [text] with a background color that automatically responds to [lightTextBackgroundOpacityKey]/[darkTextBackgroundOpacityKey]
  const EzTextBackground(
    this.config, {
    super.key,
    required this.text,
    this.padding,
    this.shape,
    this.borderRadius,
    this.baseColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: padding ??
            ((backgroundColor == null && config.textBackgroundOpacity < oneP)
                ? EdgeInsets.zero
                : EdgeInsets.all(config.marginVal)),
        decoration: BoxDecoration(
          color: backgroundColor ??
              (baseColor ?? config.colors.surfaceContainer).withValues(
                alpha: config.textBackgroundOpacity,
              ),
          borderRadius: borderRadius ?? (shape ?? config.buttonShape).textRadius,
        ),
        child: text,
      );
}

class EzTextField extends StatefulWidget {
  /// [TextFormField] passthrough
  final Iterable<String>? autofillHints;

  /// [TextFormField] passthrough
  final AutovalidateMode? autovalidateMode;

  /// [TextFormField] passthrough
  final TextEditingController? controller;

  /// [ConstrainedBox] passthrough
  final BoxConstraints constraints;

  /// [ConstrainedBox] passthrough
  /// Always [constraints] if unprovided
  final BoxConstraints? errorConstraints;

  /// [TextFormField] passthrough
  final FocusNode? focusNode;

  /// [InputDecoration] passthrough
  final String hintText;

  /// Optional [Semantics.label]
  final String? label;

  /// [TextFormField] passthrough
  final TextInputType? keyboardType;

  /// [TextFormField] passthrough
  final int? maxLines;

  /// [TextFormField] passthrough
  final void Function(String)? onChanged;

  /// [TextFormField] passthrough
  final void Function()? onEditingComplete;

  /// [TextFormField] passthrough
  final void Function(String)? onFieldSubmitted;

  /// [TextFormField] passthrough
  final void Function()? onTap;

  /// [TextFormField] passthrough
  final bool onTapAlwaysCalled;

  /// [TextFormField] passthrough
  final Function(PointerDownEvent)? onTapOutside;

  /// [TextFormField] passthrough
  final bool readOnly;

  /// [TextFormField] passthrough
  final TextStyle? style;

  /// [TextFormField] passthrough
  final TextAlign textAlign;

  /// [TextFormField] passthrough
  final TextInputAction? textInputAction;

  /// [TextFormField] passthrough
  final String? Function(String?)? validator;

  /// [TextFormField] wrapped in a stateful [ConstrainedBox] to auto-handle error text
  /// Also has some custom defaults
  const EzTextField({
    super.key,
    this.autofillHints,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.controller,
    required this.constraints,
    this.errorConstraints,
    this.focusNode,
    required this.hintText,
    this.label,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onTap,
    this.onTapAlwaysCalled = true,
    this.onTapOutside,
    this.readOnly = false,
    this.style,
    this.textAlign = TextAlign.center,
    this.textInputAction,
    required this.validator,
  });

  @override
  State<EzTextField> createState() => _EzTextFieldState();
}

class _EzTextFieldState extends State<EzTextField> {
  bool error = false;

  Widget core() => TextFormField(
        autofillHints: widget.autofillHints,
        autovalidateMode: widget.autovalidateMode,
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: InputDecoration(hintText: widget.hintText),
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onFieldSubmitted,
        onTap: widget.onTap,
        onTapAlwaysCalled: widget.onTapAlwaysCalled,
        onTapOutside: widget.onTapOutside,
        readOnly: widget.readOnly,
        style: widget.style,
        textAlign: widget.textAlign,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
      );

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: error ? widget.errorConstraints ?? widget.constraints : widget.constraints,
        child: widget.label == null
            ? core()
            : Semantics(
                label: widget.controller == null
                    ? widget.label
                    : widget.controller!.text.isEmpty
                        ? '${widget.label}: ${widget.hintText}'
                        : '${widget.label}: ${widget.controller!.text}',
                textField: true,
                readOnly: widget.readOnly,
                child: ExcludeSemantics(child: core()),
              ),
      );
}
