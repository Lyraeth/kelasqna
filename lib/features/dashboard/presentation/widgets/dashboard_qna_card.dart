import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class DashboardQnaCard extends StatelessWidget {
  const DashboardQnaCard({
    super.key,
    required this.userName,
    required this.userRole,
    this.userPhotoUrl,
    required this.title,
    required this.body,
    required this.totalLike,
    required this.totalComment,
    required this.totalBookmark,
    required this.createdAt,
    this.onTap,
  });

  /// Card tap interaction to show details qna.
  final VoidCallback? onTap;

  /// User photo ur.
  final String? userPhotoUrl;

  /// User name.
  final String userName;

  /// User Role
  final String userRole;

  /// Title question.
  final String title;

  /// Body question.
  final String body;

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
    return GestureDetector(
      onTap: onTap,
      child: NeoKelasContainer(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            QnaCardHeader(
              userPhotoUrl: userPhotoUrl,
              userName: userName,
              userRole: userRole,
            ),

            // Body
            QnaCardBody(
              backgroundTransparent: false,
              rounded: false,
              title: title,
              body: body,
            ),

            // Footer
            QnaCardFooter(
              totalLike: totalLike,
              totalComment: totalComment,
              totalBookmark: totalBookmark,
              createdAt: createdAt,
            ),
          ],
        ),
      ),
    );
  }
}
