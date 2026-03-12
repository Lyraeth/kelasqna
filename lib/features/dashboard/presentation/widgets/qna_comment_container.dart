import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class QnaCommentContainer extends StatelessWidget {
  const QnaCommentContainer({
    super.key,
    required this.userName,
    required this.userComment,
    required this.userTimeComment,
    required this.questionAuthorId,
    required this.commentAuthorId,
  });

  final String userName;
  final String userComment;
  final String userTimeComment;
  final int questionAuthorId;
  final int commentAuthorId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      contentPadding: 8.horizontal,
      leading: CircleAvatar(
        backgroundColor: context.colors.onSurface,
        foregroundColor: context.colors.surface,
        child: Icon(LucideIcons.user),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: context.text.titleMedium?.copyWith(
                  color: context.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                userTimeComment,
                style: context.text.labelSmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          if (questionAuthorId == commentAuthorId) ...[
            4.h,
            Text(
              context.l10n.author,
              style: context.text.labelSmall?.copyWith(
                color: context.colors.primary,
              ),
            ),
          ],
        ],
      ),
      subtitle: NeoKelasBackgroundContainer(
        margin: 8.onlyTop,
        backgroundTransparent: false,
        padding: 16.all,
        rounded: true,
        child: Text(
          userComment,
          style: context.text.bodyMedium?.copyWith(
            color: context.colors.onSurface,
          ),
        ),
      ),
    );
  }
}
