import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsAppearanceSettings extends StatelessWidget {
  const SettingsAppearanceSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsButtonTitle(title: context.l10n.appearance),
        NeoKelasContainer(
          padding: 8.vertical,
          child: Column(
            children: [
              SettingsButton(
                leadingIcon: LucideIcons.languages,
                title: context.l10n.language,
                subtitle: context.read<AppBloc>().languageCode,
                onTap: () {},
              ),
              SettingsButton(
                leadingIcon: LucideIcons.sunMoon,
                title: context.l10n.theme,
                subtitle: context.read<AppBloc>().themeMode,
                onTap: () {},
              ),
            ].separatedBy(Divider(indent: 16, endIndent: 16, thickness: 0.3)),
          ),
        ),
      ].separatedBy(16.h),
    );
  }
}
