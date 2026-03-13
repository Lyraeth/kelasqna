import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

class SessionsDeviceCard extends StatelessWidget {
  final SessionsDeviceEntity device;
  final bool isCurrentDevice;

  const SessionsDeviceCard({
    super.key,
    required this.device,
    this.isCurrentDevice = false,
  });

  IconData get _deviceIcon {
    final name = device.deviceName.toLowerCase();
    if (name.contains('linux') || name.contains('windows')) {
      return LucideIcons.computer;
    }
    if (name.contains('ipad') || name.contains('tablet')) {
      return LucideIcons.tablet;
    }
    return LucideIcons.smartphone;
  }

  bool get _isExpired => device.expiresAt.isBefore(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return NeoKelasContainer(
      padding: 16.all,
      child: Row(
        children: [
          // ── Device Icon ───────────────────────────────────────────
          NeoKelasContainer(
            backgroundColor: context.colors.onSurface,
            width: 48,
            height: 48,
            padding: EdgeInsets.zero,
            child: Icon(
              _deviceIcon,
              size: 22,
              color: isCurrentDevice
                  ? context.colors.surface
                  : context.colors.onSurfaceVariant,
            ),
          ),

          16.w,

          // ── Device Info ───────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        device.deviceName,
                        style: context.text.bodyMedium?.copyWith(
                          color: context.colors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentDevice) ...[
                      8.w,
                      NeoKelasBadge(
                        label: context.l10n.thisDevice,
                        color: context.colors.onSurface,
                        textColor: context.colors.surface,
                      ),
                    ],
                    if (_isExpired) ...[
                      8.w,
                      NeoKelasBadge(
                        label: context.l10n.expired,
                        color: context.colors.errorContainer,
                        textColor: context.colors.onErrorContainer,
                      ),
                    ],
                  ],
                ),
                8.h,
                Row(
                  children: [
                    Icon(
                      LucideIcons.clock,
                      size: 12,
                      color: context.colors.onSurfaceVariant,
                    ),
                    4.w,
                    Text(
                      '${context.l10n.lastActive} ${timeago.format(device.lastUsedAt)}',
                      style: context.text.labelSmall?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                8.h,
                Row(
                  children: [
                    Icon(
                      LucideIcons.calendarX2,
                      size: 12,
                      color: context.colors.onSurfaceVariant,
                    ),
                    4.w,
                    Text(
                      '${context.l10n.endsOn} ${DateFormat("dd MMM yyyy, HH : mm").format(device.expiresAt.toLocal())}',
                      style: context.text.labelSmall?.copyWith(
                        color: _isExpired
                            ? context.colors.error
                            : context.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Revoke Button (sembunyiin kalau current device) ───────
          if (!isCurrentDevice) ...[
            8.w,
            NeoKelasContainer(
              width: 36,
              height: 36,
              padding: EdgeInsets.zero,
              child: IconButton(
                onPressed: () async {
                  await NeoKelasDeleteDialog.show(
                    context,
                    title: context.l10n.deleteSession,
                    description: context.l10n.deleteSessionDesc,
                    onConfirm: () =>
                        context.read<SessionsRevokeDeviceBloc>().add(
                          SessionsRevokeDeviceEvent.revokeSession(
                            id: device.id,
                          ),
                        ),
                  );
                },
                icon: Icon(
                  LucideIcons.logOut,
                  size: 16,
                  color: context.colors.error,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
