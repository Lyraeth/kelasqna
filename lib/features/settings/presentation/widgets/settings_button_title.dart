import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class SettingsButtonTitle extends StatelessWidget {
  const SettingsButtonTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.text.labelLarge?.copyWith(
            color: context.colors.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(child: Divider(indent: 16, thickness: 0.5)),
      ],
    );
  }
}
