import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.notification, this.onTap});

  final NotificationEntity notification;
  final VoidCallback? onTap;

  IconData get _icon => switch (notification.type) {
    'comment' => LucideIcons.messageCircle,
    'like' => LucideIcons.heart,
    'bookmark' => LucideIcons.bookmark,
    _ => LucideIcons.bell,
  };

  String get _message => notification.message;

  String get _createdAt => notification.createdAt;

  bool get _isRead => notification.isRead;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NeoKelasContainer(
        padding: 16.all,
        backgroundColor: _isRead
            ? context.colors.surface
            : context.colors.primaryContainer,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            NeoKelasContainer(
              padding: 8.all,
              backgroundColor: context.colors.onSurface,
              child: Icon(_icon, size: 18, color: context.colors.surface),
            ),
            16.w,
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _message,
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.onSurface,
                      fontWeight: _isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  8.h,
                  Text(
                    _createdAt,
                    style: context.text.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            // Unread dot
            if (!_isRead) ...[
              8.w,
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: context.colors.onSurface,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
