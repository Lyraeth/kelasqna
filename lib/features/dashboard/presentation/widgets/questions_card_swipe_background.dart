import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class QuestionsCardSwipeBackground extends StatelessWidget {
  const QuestionsCardSwipeBackground({
    super.key,
    required this.alignment,
    required this.color,
    required this.icon,
  });

  final AlignmentGeometry alignment;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      decoration: BoxDecoration(color: color, borderRadius: 16.circular),
      child: Center(
        child: Icon(icon, color: context.colors.onPrimary, size: 48),
      ),
    );
  }
}
