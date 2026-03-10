import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class QnaCardFooter extends StatelessWidget {
  const QnaCardFooter({
    super.key,
    required this.engagementTotal,
    required this.createdAt,
  });

  final EngagementTotal engagementTotal;

  /// User post time created.
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NeoKelasEngagementButton(
            totalLike: engagementTotal.totalLikes,
            totalComment: engagementTotal.totalComments,
            totalBookmark: engagementTotal.totalBookmarks,
          ),
          NeoKelasTimeago(time: createdAt),
        ],
      ),
    );
  }
}
