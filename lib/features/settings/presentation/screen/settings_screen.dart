import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) =>
          previous.locale != current.locale ||
          previous.themeMode != current.themeMode,
      listener: (context, state) {
        NeoKelasAppToast.show(
          context,
          message: context.l10n.settingsChangeSuccess,
          duration: 5.seconds,
          type: ToastType.info,
        );
      },
      child: Scaffold(
        backgroundColor: context.colors.surfaceContainer,
        appBar: SettingsAppBar(),
        body: SingleChildScrollView(
          padding: 16.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsProfileSettings(),
              SettingsAppearanceSettings(),
            ].separatedBy(24.h),
          ),
        ),
      ),
    );
  }
}
