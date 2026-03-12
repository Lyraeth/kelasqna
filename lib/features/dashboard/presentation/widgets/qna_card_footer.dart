import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

class QnaCardFooter extends StatelessWidget {
  const QnaCardFooter({
    super.key,
    required this.questionEntity,
    required this.createdAt,
  });

  final QuestionEntity questionEntity;

  /// User post time created.
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.all,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NeoKelasEngagementButton(
            questionEntity: questionEntity,
            onLikeTap: () {
              context.read<QuestionsBloc>().add(
                QuestionsEvent.toggleLike(id: questionEntity.id),
              );
            },
            onBookmarkTap: () {
              context.read<QuestionsBloc>().add(
                QuestionsEvent.toggleBookmark(id: questionEntity.id),
              );
            },
          ),
          NeoKelasTimeago(time: createdAt),
        ],
      ),
    );
  }
}
