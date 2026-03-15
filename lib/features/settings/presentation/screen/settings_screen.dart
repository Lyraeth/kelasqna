import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceContainer,
      appBar: SettingsAppBar(),
      body: Padding(
        padding: 16.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsProfileSettings(),
            SettingsAppearanceSettings(),
          ].separatedBy(24.h),
        ),
      ),
    );
  }
}
