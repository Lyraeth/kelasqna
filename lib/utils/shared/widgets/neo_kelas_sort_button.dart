import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NeoKelasSortButton extends StatelessWidget {
  const NeoKelasSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return NeoKelasContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Icon(LucideIcons.arrowDownAZ, size: 14),
          Text(
            context.l10n.sort,
            style: context.text.labelLarge?.copyWith(
              color: context.colors.onSurface,
            ),
          ),
        ].separatedBy(8.w),
      ),
    );
  }
}
