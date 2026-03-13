import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NeoKelasDeleteDialog extends StatelessWidget {
  const NeoKelasDeleteDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onConfirm,
  });

  final String title;
  final String description;
  final VoidCallback onConfirm;

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => NeoKelasDeleteDialog(
        title: title,
        description: description,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colors.surface,
      shape: RoundedRectangleBorder(borderRadius: 16.circular),
      child: Padding(
        padding: 24.all,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            NeoKelasContainer(
              width: 56,
              height: 56,
              backgroundColor: context.colors.errorContainer,
              child: Icon(
                LucideIcons.trash2,
                color: context.colors.onErrorContainer,
                size: 24,
              ),
            ),

            16.h,

            // Title
            Text(
              title,
              style: context.text.titleMedium?.copyWith(
                color: context.colors.onSurface,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),

            8.h,

            // Description
            Text(
              description,
              style: context.text.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            24.h,

            // Buttons
            Row(
              children: [
                Expanded(
                  child: NeoKelasButton(
                    onPressed: () => context.router.pop(),
                    child: Text(context.l10n.cancel),
                  ),
                ),
                Expanded(
                  child: NeoKelasButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    backgroundColor: context.colors.error,
                    child: Text(
                      context.l10n.delete,
                      style: TextStyle(color: context.colors.onError),
                    ),
                  ),
                ),
              ].separatedBy(12.w),
            ),
          ],
        ),
      ),
    );
  }
}
