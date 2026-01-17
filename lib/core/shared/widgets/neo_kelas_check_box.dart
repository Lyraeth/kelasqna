import 'package:flutter/material.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/utils/utils.dart';

import 'neo_kelas_container.dart';

class NeoKelasCheckBox extends StatefulWidget {
  final bool value;
  final double? width;
  final double? height;
  final void Function(bool?)? onChanged;
  final Color? activeColor;
  final String checkBoxTitle;

  const NeoKelasCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    this.width,
    this.height,
    this.activeColor,
    required this.checkBoxTitle,
  });

  @override
  State<NeoKelasCheckBox> createState() => _NeoKelasCheckBoxState();
}

class _NeoKelasCheckBoxState extends State<NeoKelasCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.height,
          height: widget.height,
          child: NeoKelasContainer(
            containerColor: Theme.of(context).colorScheme.surface,
            child: Checkbox(
              value: widget.value,
              onChanged: widget.onChanged,
              activeColor: widget.activeColor ?? primaryBlue,
              side: BorderSide(color: Colors.black, strokeAlign: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(4),
              ),
            ),
          ),
        ),

        SizedBox(width: 8),

        Text(
          Utils.getTranslatedLabel(widget.checkBoxTitle),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
