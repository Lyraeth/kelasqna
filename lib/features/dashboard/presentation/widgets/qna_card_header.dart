import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class QnaCardHeader extends StatelessWidget {
  const QnaCardHeader({
    super.key,
    required this.userName,
    required this.userRole,
    this.userPhotoUrl,
    this.showTrailing = true,
  });

  /// User photo ur.
  final String? userPhotoUrl;

  /// User name.
  final String userName;

  /// User Role
  final String userRole;

  /// A flag to show more action or not
  final bool showTrailing;

  @override
  Widget build(BuildContext context) {
    String displayName = userName;

    /// If the user name is more than 3 words long,
    /// only the first 3 words of the name will be displayed.
    if (userName.split(" ").length > 3) {
      displayName = userName.split(" ").take(3).join(" ");
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: context.colors.onSurface,
        foregroundColor: context.colors.surface,
        child: (userPhotoUrl != null)
            ? CachedNetworkImage(imageUrl: userPhotoUrl!)
            : Icon(LucideIcons.user),
      ),
      title: Text(
        displayName,
        style: context.text.titleMedium?.copyWith(
          color: context.colors.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        userRole,
        style: context.text.labelMedium?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),
      ),

      /// TODO : I haven't thought about what to fill this with yet
      trailing: (showTrailing == true)
          ? CircleAvatar(
              backgroundColor: context.colors.surfaceContainer,
              foregroundColor: context.colors.onSurfaceVariant,
              child: IconButton(
                onPressed: () {},
                icon: Icon(LucideIcons.ellipsis),
              ),
            )
          : null,
    );
  }
}
