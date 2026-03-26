import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    this.leadingIcon,
    required this.title,
    this.trailing,
    this.subtitle,
    required this.onTap,
  });

  final IconData? leadingIcon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap.call();
      },
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: (leadingIcon != null)
          ? NeoKelasContainer(
              backgroundColor: context.colors.onSurface,
              child: Icon(size: 20, leadingIcon, color: context.colors.surface),
            )
          : null,
      title: Text(
        title,
        style: context.text.titleSmall?.copyWith(
          color: context.colors.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: (subtitle != null) ? Text(subtitle!) : null,
      trailing: (trailing != null)
          ? trailing
          : Icon(
              size: 20,
              LucideIcons.chevronRight,
              color: context.colors.onSurface,
            ),
    );
  }
}
