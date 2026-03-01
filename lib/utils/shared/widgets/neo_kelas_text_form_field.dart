import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasTextFormField extends StatefulWidget {
  final String textFieldName;
  final Color? textFieldBackgroundColor;
  final TextEditingController controller;
  final EdgeInsetsGeometry? contentPadding;
  final String? validatorString;
  final bool? obscureText;
  final FormFieldValidator<String?>? validator;
  final List<Widget>? trailing;

  const NeoKelasTextFormField({
    super.key,
    required this.controller,
    required this.textFieldName,
    this.validatorString,
    this.textFieldBackgroundColor,
    this.contentPadding,
    this.obscureText,
    this.validator,
    this.trailing,
  }) : assert(
         (validator == null && validatorString != null) ||
             (validator != null && validatorString == null),
         'Cannot provide both a validator and a validatorString',
       );

  @override
  State<NeoKelasTextFormField> createState() => _NeoKelasTextFormFieldState();
}

class _NeoKelasTextFormFieldState extends State<NeoKelasTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textFieldName,
          style: context.text.titleLarge?.copyWith(
            color: context.colors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),

        16.h,

        NeoKelasContainer(
          padding: 4.onlyLeft,
          backgroundColor:
              widget.textFieldBackgroundColor ?? context.colors.surface,
          child: widget.trailing != null
              ? Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: widget.controller,
                        obscureText: widget.obscureText ?? false,
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
                        ),
                        validator:
                            widget.validator ??
                            (value) {
                              if (value == null || value.isEmpty) {
                                return widget.validatorString!;
                              }
                              return null;
                            },
                      ),
                    ),

                    if (widget.trailing != null) ...[...?widget.trailing, 16.w],
                  ],
                )
              : TextFormField(
                  controller: widget.controller,
                  obscureText: widget.obscureText ?? false,
                  decoration: InputDecoration(
                    contentPadding: widget.contentPadding ?? 8.all,
                    errorStyle: context.text.labelMedium?.copyWith(
                      color: context.colors.error,
                    ),
                  ),
                  validator:
                      widget.validator ??
                      (value) {
                        if (value == null || value.isEmpty) {
                          return widget.validatorString!;
                        }
                        return null;
                      },
                ),
        ),
      ],
    );
  }
}
