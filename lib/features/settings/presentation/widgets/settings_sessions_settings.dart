import 'package:flutter/cupertino.dart';
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
          padding: 8.vertical,
          child: SettingsButton(
            leadingIcon: LucideIcons.computer,
            title: context.l10n.sessions,
            subtitle: "",
            onTap: () => Navigator.of(context).push(
              CupertinoPageRoute(builder: (_) => const SessionsDeviceScreen()),
            ),
          ),
        ),
      ].separatedBy(16.h),
    );
  }
}
