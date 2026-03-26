import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsLanguageScreen extends StatelessWidget {
  const SettingsLanguageScreen({super.key});

  static const _languages = [(code: 'id'), (code: 'en')];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.locale != current.locale,
      builder: (context, state) {
        final currentCode = state.locale.languageCode;

        return Scaffold(
          backgroundColor: context.colors.surfaceContainer,
          appBar: SettingsAppBar(title: context.l10n.languageSetting),
          body: Padding(
            padding: 16.horizontal,
            child: NeoKelasContainer(
              padding: 8.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _languages
                    .map((lang) {
                      final isSelected = currentCode == lang.code;
                      final label = lang.code == 'id'
                          ? context.l10n.id
                          : context.l10n.en;

                      return _LanguageTile(
                        label: label,
                        isSelected: isSelected,
                        onTap: () {
                          if (!isSelected) {
                            context.read<AppBloc>().add(
                              AppEvent.changeLanguage(lang.code),
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

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SettingsButton(
      title: label,
      trailing: (isSelected)
          ? Icon(LucideIcons.circleCheck, size: 20)
          : Icon(LucideIcons.circle, size: 20),
      onTap: onTap,
    );
  }
}
