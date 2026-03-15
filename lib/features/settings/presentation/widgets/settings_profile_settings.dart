import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsProfileSettings extends StatelessWidget {
  const SettingsProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsButtonTitle(title: context.l10n.profile),
        NeoKelasContainer(
          padding: 8.vertical,
          child: Column(
            children: [
              SettingsButton(
                leadingIcon: LucideIcons.caseSensitive,
                title: context.l10n.changeName,
                subtitle: context.read<SessionsBloc>().state.maybeWhen(
                  authenticated: (user, _, _) => user.name,
                  orElse: () => "-",
                ),
                onTap: () {
                  NeoKelasAppToast.show(
                    context,
                    message: context.l10n.featureNotYetAvailable,
                    type: ToastType.info,
                  );
                },
              ),
              SettingsButton(
                leadingIcon: LucideIcons.mail,
                title: context.l10n.changeEmail,
                subtitle: context.read<SessionsBloc>().state.maybeWhen(
                  authenticated: (user, _, _) => Utils.formatEmail(user.email),
                  orElse: () => "-",
                ),
                onTap: () {
                  NeoKelasAppToast.show(
                    context,
                    message: context.l10n.featureNotYetAvailable,
                    type: ToastType.info,
                  );
                },
              ),
              SettingsButton(
                leadingIcon: LucideIcons.rectangleEllipsis,
                title: context.l10n.changePassword,
                subtitle: " ",
                onTap: () {
                  NeoKelasAppToast.show(
                    context,
                    message: context.l10n.featureNotYetAvailable,
                    type: ToastType.info,
                  );
                },
              ),
            ].separatedBy(Divider(indent: 16, endIndent: 16, thickness: 0.3)),
          ),
        ),
      ].separatedBy(16.h),
    );
  }
}
