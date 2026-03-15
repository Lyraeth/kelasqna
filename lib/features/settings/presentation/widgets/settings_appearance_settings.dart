import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsAppearanceSettings extends StatelessWidget {
  const SettingsAppearanceSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) =>
          previous.locale != current.locale ||
          previous.themeMode != current.themeMode,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsButtonTitle(title: context.l10n.appearance),
            NeoKelasContainer(
              padding: 8.vertical,
              child: Column(
                children:
                    [
                      SettingsButton(
                        leadingIcon: LucideIcons.languages,
                        title: context.l10n.language,
                        subtitle: _languageLabel(
                          context,
                          state.locale.languageCode,
                        ),
                        onTap: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<AppBloc>(),
                              child: const SettingsLanguageScreen(),
                            ),
                          ),
                        ),
                      ),
                      SettingsButton(
                        leadingIcon: LucideIcons.sunMoon,
                        title: context.l10n.theme,
                        subtitle: _themeModeLabel(context, state.themeMode),
                        onTap: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<AppBloc>(),
                              child: const SettingsThemeScreen(),
                            ),
                          ),
                        ),
                      ),
                    ].separatedBy(
                      Divider(indent: 16, endIndent: 16, thickness: 0.3),
                    ),
              ),
            ),
          ].separatedBy(16.h),
        );
      },
    );
  }

  String _languageLabel(BuildContext context, String code) {
    return switch (code) {
      'id' => context.l10n.id,
      'en' => context.l10n.en,
      _ => code,
    };
  }

  String _themeModeLabel(BuildContext context, ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => context.l10n.lightMode,
      ThemeMode.dark => context.l10n.darkMode,
      ThemeMode.system => context.l10n.system,
    };
  }
}
