import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class QnaCardFooter extends StatelessWidget {
  const QnaCardFooter({
    super.key,
    required this.totalLike,
    required this.totalComment,
    required this.totalBookmark,
    required this.createdAt,
  });

  /// User post total like.
  final int totalLike;

  /// User post total comment.
  final int totalComment;

  /// User post total bookmark.
  final int totalBookmark;

  /// User post time created.
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NeoKelasEngagementButton(
            totalLike: totalLike,
            totalComment: totalComment,
            totalBookmark: totalBookmark,
          ),
          NeoKelasTimeago(time: createdAt),
        ],
      ),
    );
  }
}
