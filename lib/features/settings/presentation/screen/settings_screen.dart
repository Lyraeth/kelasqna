import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
              SettingsSessionsSettings(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsButtonTitle(title: context.l10n.sessions),
                  NeoKelasContainer(
                    padding: 8.vertical,
                    child: SettingsButton(
                      leadingIcon: LucideIcons.logOut,
                      title: context.l10n.logout,
                      onTap: () => context.read<AuthBloc>().add(
                        const AuthEvent.logoutRequested(),
                      ),
                    ),
                  ),
                ].separatedBy(16.h),
              ),

              24.h,
            ].separatedBy(24.h),
          ),
        ),
      ),
    );
  }
}
