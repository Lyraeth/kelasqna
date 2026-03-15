import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, this.userEntity});

  final UserEntity? userEntity;

  @override
  Widget build(BuildContext context) {
    final name = userEntity?.name ?? context.l10n.whoIsThis;
    final displayRole = userEntity?.displayRole ?? context.l10n.noRoleDetected;
    final avatar = userEntity?.avatar;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: NeoKelasContainer(
        backgroundColor: context.colors.surface,
        padding: 16.all,
        child: Row(
          children: [
            _Avatar(avatar: avatar, name: name),
            16.w,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: context.text.titleMedium?.copyWith(
                      color: context.colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  8.h,
                  Row(
                    children: [
                      Icon(
                        LucideIcons.userRoundKey,
                        size: 16,
                        color: context.colors.onSurfaceVariant,
                      ),
                      8.w,
                      Expanded(
                        child: Text(
                          displayRole,
                          style: context.text.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? avatar;
  final String name;

  const _Avatar({this.avatar, required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colors.onSurface,
      foregroundColor: context.colors.surface,
      radius: 32,
      child: avatar != null
          ? CachedNetworkImage(
              imageUrl: avatar!,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) =>
                  _InitialsAvatar(initials: Utils.formatInitialName(name)),
            )
          : _InitialsAvatar(initials: Utils.formatInitialName(name)),
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  final String initials;

  const _InitialsAvatar({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Text(
      initials,
      style: context.text.titleMedium?.copyWith(
        color: context.colors.surface,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
