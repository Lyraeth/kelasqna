import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasTimeago extends StatelessWidget {
  const NeoKelasTimeago({super.key, required this.time, this.textColor});

  final String time;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      time,
      style: context.text.labelMedium?.copyWith(
        color: textColor ?? context.colors.onSurfaceVariant,
      ),
    );
  }
}
