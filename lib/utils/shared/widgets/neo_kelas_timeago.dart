import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:timeago/timeago.dart' as timeago;

class NeoKelasTimeago extends StatelessWidget {
  const NeoKelasTimeago({super.key, required this.time, this.textColor});

  final DateTime time;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      timeago.format(time),
      style: context.text.labelMedium?.copyWith(
        color: textColor ?? context.colors.onSurfaceVariant,
      ),
    );
  }
}
