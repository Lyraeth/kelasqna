import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

const _lockOptions = [1, 3, 5, 10, 15, 30];

class SettingsAppLockScreen extends StatelessWidget {
  const SettingsAppLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLockCubit, AppLockState>(
      builder: (context, state) {
        final settings = state.maybeWhen(
          settings: (s) => s,
          orElse: () => context.read<AppLockCubit>().currentSettings,
        );

        return Scaffold(
          backgroundColor: context.colors.surfaceContainer,
          appBar: AppBar(
            title: Text(context.l10n.appLockScreen),
            backgroundColor: context.colors.surfaceContainer,
          ),
          body: SingleChildScrollView(
            padding: 16.all,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NeoKelasContainer(
                  padding: 8.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingsButton(
                        title: context.l10n.active,
                        onTap: () {},
                        trailing: CupertinoSwitch(
                          value: settings.isEnable,
                          onChanged: (value) {
                            context.read<AppLockCubit>().updateSettings(
                              settings.copyWith(isEnable: value),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                if (settings.isEnable) ...[
                  32.h,
                  SettingsButtonTitle(title: context.l10n.lockAfter),
                  16.h,
                  NeoKelasContainer(
                    padding: 8.vertical,
                    child: Column(
                      children: _lockOptions.map((minutes) {
                        final isSelected = settings.lockAfterMinutes == minutes;
                        return SettingsButton(
                          title: context.l10n.minutesOption(minutes),
                          onTap: () {
                            context.read<AppLockCubit>().updateSettings(
                              settings.copyWith(lockAfterMinutes: minutes),
                            );
                          },
                          trailing: isSelected
                              ? Icon(
                                  LucideIcons.circleCheck,
                                  color: Colors.green,
                                  size: 20,
                                )
                              : Icon(LucideIcons.circle, size: 20),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
