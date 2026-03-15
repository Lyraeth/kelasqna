import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        context.l10n.settings,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: context.colors.surfaceContainer,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
