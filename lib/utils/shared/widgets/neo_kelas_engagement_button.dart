import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NeoKelasEngagementButton extends StatelessWidget {
  const NeoKelasEngagementButton({
    super.key,
    required this.totalLike,
    required this.totalComment,
    required this.totalBookmark,
  });

  /// User post total like.
  final int totalLike;

  /// User post total comment.
  final int totalComment;

  /// User post total bookmark.
  final int totalBookmark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Icon(LucideIcons.thumbsUp, size: 16),
            Text(
              totalLike.toString(),
              style: context.text.labelMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ].separatedBy(4.w),
        ),
        Row(
          children: [
            Icon(LucideIcons.messageCircle, size: 16),
            Text(
              totalComment.toString(),
              style: context.text.labelMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ].separatedBy(4.w),
        ),
        Row(
          children: [
            Icon(LucideIcons.bookmark, size: 16),
            Text(
              totalBookmark.toString(),
              style: context.text.labelMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ].separatedBy(4.w),
        ),
      ].separatedBy(16.w),
    );
  }
}
