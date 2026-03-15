import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.surfaceContainer,
      toolbarHeight: 80,
      title: Text(
        context.l10n.profile,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        NeoKelasContainer(
          width: 40,
          height: 40,
          padding: EdgeInsets.zero,
          margin: 16.onlyRight,
          child: IconButton(
            onPressed: () {
              showCupertinoSheet(
                context: context,
                useNestedNavigation: true,
                builder: (context) {
                  return Material(child: SafeArea(child: SettingsScreen()));
                },
              );
            },
            icon: Icon(
              LucideIcons.settings,
              color: context.colors.onSurface,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
