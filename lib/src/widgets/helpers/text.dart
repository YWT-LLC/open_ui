/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../open_ui.dart';

import 'package:material_ui/material_ui.dart';

class EzNewLine extends StatelessWidget {
  final TextStyle? style;

  /// Defaults to [TextAlign.start]
  final TextAlign? textAlign;

  /// A blank [Text] Widget with [style], wrapped in [ExcludeSemantics]
  const EzNewLine(this.style, {super.key, this.textAlign});

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
          child: Text(
        '',
        style: style,
        textAlign: textAlign ?? TextAlign.start,
      ));
}

class EzRichLine extends EzPlainText {
  /// [EzPlainText] w/ '\n'
  const EzRichLine({super.style}) : super(text: '\n');
}

class EzText extends StatelessWidget {
  final EzCP config;
  final String text;

  /// Defaults to [EzCP.bodyStyle]
  final TextStyle? style;

  final TextAlign? textAlign;
  final String? semanticsLabel;
  final int? maxLines;
  final TextOverflow? overflow;
  final EzButtonShape? shape;
  final EzSwitchColor? baseFill;
  final EzSwitchColor? replaceFill;

  /// Quick wrapper for creating [Text] with a default [EzTextBackground]
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
    this.baseFill,
    this.replaceFill,
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
        baseFill: baseFill,
        replaceFill: replaceFill,
      );
}

class EzTextBackground extends StatelessWidget {
  final EzCP config;

  /// The [Widget] that needs a background
  /// [Text] is merely the recommended widget
  final Widget text;

  final EzButtonShape? shape;

  /// Full override, ignores [EzCP.textBackgroundOpacity]
  /// Defaults to (a responsive) [EdgeInsets.all] w/ [EzCP.marginVal]
  final EdgeInsets? padding;

  final BorderRadiusGeometry? borderRadius;

  /// Partial override, still responds to [EzCP.textBackgroundOpacity]
  /// Defaults to [EzCP.surfaceContainerFill]
  final EzSwitchColor? baseFill;

  /// Full override, ignores [EzCP.textBackgroundOpacity]
  final EzSwitchColor? replaceFill;

  /// Create a [Container] for your [text]
  /// All [Gradient]s become [Color]s - this is for readability!
  const EzTextBackground(
    this.config, {
    super.key,
    required this.text,
    this.shape,
    this.padding,
    this.borderRadius,
    this.baseFill,
    this.replaceFill,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: padding ??
            ((replaceFill == null && config.textBackgroundOpacity < oneP)
                ? EdgeInsets.zero
                : EdgeInsets.all(config.marginVal)),
        decoration: config.boxDeco(
          fill: replaceFill ?? (baseFill ?? config.surfaceContainerFill),
          opacity: config.textBackgroundOpacity,
          borderRadius: borderRadius ?? (shape ?? config.buttonShape).textRadius,
        ),
        child: text,
      );
}

class EzTextField extends StatefulWidget {
  final bool autofocus;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final String? initialValue;
  final BoxConstraints constraints;

  /// Always [constraints] if unprovided
  final BoxConstraints? errorConstraints;

  final FocusNode? focusNode;
  final bool obscureText;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  /// Optional [Semantics] label
  final String? label;

  final TextInputType? keyboardType;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final bool onTapAlwaysCalled;
  final Function(PointerDownEvent)? onTapOutside;
  final bool readOnly;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  /// [TextFormField] wrapped in a stateful [ConstrainedBox] to auto-handle error text
  /// And some other custom defaults
  const EzTextField({
    super.key,
    this.autofocus = false,
    this.autofillHints,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.controller,
    this.initialValue,
    required this.constraints,
    this.errorConstraints,
    this.focusNode,
    this.obscureText = false,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
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
        autofocus: widget.autofocus,
        autofillHints: widget.autofillHints,
        autovalidateMode: widget.autovalidateMode,
        controller: widget.controller,
        initialValue: widget.initialValue,
        focusNode: widget.focusNode,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
        ),
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
