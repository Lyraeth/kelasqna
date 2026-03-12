import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class ProfileQuestionCard extends StatelessWidget {
  final QuestionEntity questionEntity;

  const ProfileQuestionCard({super.key, required this.questionEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoSheet(
          context: context,
          builder: (context) {
            return Material(
              child: SafeArea(
                child: QnaDetailScreen(questionEntity: questionEntity),
              ),
            );
          },
        );
      },
      child: NeoKelasContainer(
        padding: 16.all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questionEntity.title,
              style: context.text.bodyMedium?.copyWith(
                color: context.colors.onSurface,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            8.h,
            Text(
              questionEntity.content,
              style: context.text.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            16.h,
            Row(
              children: [
                NeoKelasEngagementButton(
                  questionEntity: questionEntity,
                  onLikeTap: () {},
                  onBookmarkTap: () {},
                ),
                const Spacer(),
                Text(
                  questionEntity.createdAt,
                  style: context.text.labelSmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
