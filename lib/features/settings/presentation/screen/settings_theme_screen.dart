import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsThemeScreen extends StatelessWidget {
  const SettingsThemeScreen({super.key});

  static const _themes = [
    (mode: ThemeMode.light, icon: LucideIcons.sun),
    (mode: ThemeMode.dark, icon: LucideIcons.moon),
    (mode: ThemeMode.system, icon: LucideIcons.sunMoon),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colors.surfaceContainer,
          appBar: SettingsAppBar(title: context.l10n.themeSetting),
          body: Padding(
            padding: 16.horizontal,
            child: NeoKelasContainer(
              padding: 8.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _themes
                    .map((t) {
                      final isSelected = state.themeMode == t.mode;
                      final label = switch (t.mode) {
                        ThemeMode.light => context.l10n.lightMode,
                        ThemeMode.dark => context.l10n.darkMode,
                        ThemeMode.system => context.l10n.system,
                      };

                      return _ThemeTile(
                        icon: t.icon,
                        label: label,
                        isSelected: isSelected,
                        onTap: () {
                          if (!isSelected) {
                            context.read<AppBloc>().add(
                              AppEvent.changeTheme(t.mode),
                            );
                          }
                          Navigator.of(context).pop();
                        },
                      );
                    })
                    .toList()
                    .separatedBy(
                      const Divider(indent: 16, endIndent: 16, thickness: 0.3),
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ThemeTile extends StatelessWidget {
  const _ThemeTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SettingsButton(
      leadingIcon: icon,
      title: label,
      trailingIcon: (isSelected) ? LucideIcons.circleCheck : LucideIcons.circle,
      onTap: onTap,
    );
  }
}
