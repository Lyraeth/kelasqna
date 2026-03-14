import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasTextFormField extends StatefulWidget {
  final String? textFieldName;
  final Color? textFieldBackgroundColor;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final String hintText;
  final bool? obscureText;
  @Deprecated(
    "validator and validatorString have been deprecated. "
    "Validation and error messages are now fully handled by the errorMessage "
    "returned from the backend, so local validators are no longer required.",
  )
  final FormFieldValidator<String?>? validator;
  @Deprecated(
    "validator and validatorString have been deprecated. "
    "Validation and error messages are now fully handled by the errorMessage "
    "returned from the backend, so local validators are no longer required.",
  )
  final String? validatorString;
  final List<Widget>? trailing;
  final double? height;
  final int? maxLines;
  final int? minLines;
  final TextAlignVertical? textAlignVertical;
  final bool? readOnly;
  final Color? foregroundTextColor;
  final EdgeInsetsGeometry? margin;

  const NeoKelasTextFormField({
    super.key,
    required this.hintText,
    this.margin,
    this.controller,
    this.textFieldName,
    this.validatorString,
    this.textFieldBackgroundColor,
    this.contentPadding,
    this.obscureText,
    this.validator,
    this.trailing,
    this.height,
    this.maxLines,
    this.minLines,
    this.foregroundTextColor,
    this.textAlignVertical,
    this.readOnly,
  });

  // : assert(
  //    (validator == null && validatorString != null) ||
  //        (validator != null && validatorString == null),
  //    'Cannot provide both a validator and a validatorString',
  //  );

  @override
  State<NeoKelasTextFormField> createState() => _NeoKelasTextFormFieldState();
}

class _NeoKelasTextFormFieldState extends State<NeoKelasTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.textFieldName != null) ...[
          Text(
            widget.textFieldName!,
            style: context.text.titleMedium?.copyWith(
              color: context.colors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],

        8.h,

        NeoKelasContainer(
          height: widget.height,
          padding: 4.onlyLeft,
          margin: widget.margin,
          backgroundColor:
              widget.textFieldBackgroundColor ??
              context.colors.surfaceContainer,
          child: widget.trailing != null
              ? Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textAlignVertical: widget.textAlignVertical,
                        maxLines: widget.maxLines ?? 1,
                        minLines: widget.minLines,
                        controller: widget.controller,
                        obscureText: widget.obscureText ?? false,
                        style: context.text.bodyMedium?.copyWith(
                          color: context.colors.onSurface,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          contentPadding: widget.contentPadding ?? 8.all,
                          errorStyle: context.text.labelMedium?.copyWith(
                            color: context.colors.error,
                          ),
                          hintText: widget.hintText,
                          hintStyle: context.text.labelMedium?.copyWith(
                            color:
                                widget.foregroundTextColor ??
                                context.colors.onSurfaceVariant,
                          ),
                        ),
                        readOnly: widget.readOnly ?? false,
                      ),
                    ),

                    if (widget.trailing != null) ...[...?widget.trailing, 16.w],
                  ],
                )
              : TextFormField(
                  controller: widget.controller,
                  obscureText: widget.obscureText ?? false,
                  textAlignVertical: widget.textAlignVertical,
                  maxLines: widget.maxLines ?? 1,
                  minLines: widget.minLines,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.colors.onSurface,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: widget.contentPadding ?? 8.all,
                    errorStyle: context.text.labelMedium?.copyWith(
                      color: context.colors.error,
                    ),
                    hintText: widget.hintText,
                    hintStyle: context.text.labelMedium?.copyWith(
                      color:
                          widget.foregroundTextColor ??
                          context.colors.onSurfaceVariant,
                    ),
                  ),
                  readOnly: widget.readOnly ?? false,
                ),
        ),
      ],
    );
  }
}
