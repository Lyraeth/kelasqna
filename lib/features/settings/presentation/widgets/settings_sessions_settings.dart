import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsSessionsSettings extends StatelessWidget {
  const SettingsSessionsSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsButtonTitle(title: context.l10n.sessions),
        NeoKelasContainer(
          padding: 16.vertical,
          child: Column(
            children: [
              SettingsButton(
                leadingIcon: LucideIcons.computer,
                title: context.l10n.sessions,
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => const SessionsDeviceScreen(),
                  ),
                ),
              ),
              SettingsButton(
                leadingIcon: LucideIcons.lock,
                title: context.l10n.appLockScreen,
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => const SettingsAppLockScreen(),
                  ),
                ),
              ),
            ].separatedBy(Divider(indent: 16, endIndent: 16, thickness: 0.3)),
          ),
        ),
      ].separatedBy(16.h),
    );
  }
}
