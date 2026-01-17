import 'package:flutter/material.dart';
import 'package:kelasqna/utils/utils.dart';

import 'neo_kelas_container.dart';

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
          Utils.getTranslatedLabel(widget.textFieldName),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),

        SizedBox(height: 8),

        NeoKelasContainer(
          padding: const EdgeInsets.only(left: 4),
          containerColor:
              widget.textFieldBackgroundColor ??
              Theme.of(context).colorScheme.surface,
          child: widget.trailing != null
              ? Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: widget.controller,
                        obscureText: widget.obscureText ?? false,
                        decoration: InputDecoration(
                          contentPadding:
                              widget.contentPadding ?? const EdgeInsets.all(8),
                          errorStyle: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                        ),
                        validator:
                            widget.validator ??
                            (value) {
                              if (value == null || value.isEmpty) {
                                return Utils.getTranslatedLabel(
                                  widget.validatorString!,
                                );
                              }
                              return null;
                            },
                      ),
                    ),

                    if (widget.trailing != null) ...[...?widget.trailing],
                  ],
                )
              : TextFormField(
                  controller: widget.controller,
                  obscureText: widget.obscureText ?? false,
                  decoration: InputDecoration(
                    contentPadding:
                        widget.contentPadding ?? const EdgeInsets.all(8),
                    errorStyle: Theme.of(context).textTheme.labelMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                  validator:
                      widget.validator ??
                      (value) {
                        if (value == null || value.isEmpty) {
                          return Utils.getTranslatedLabel(
                            widget.validatorString!,
                          );
                        }
                        return null;
                      },
                ),
        ),
      ],
    );
  }
}
