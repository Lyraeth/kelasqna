import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasBadge extends StatelessWidget {
  const NeoKelasBadge({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return NeoKelasContainer(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      backgroundColor: color,
      child: Text(
        label,
        style: context.text.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
