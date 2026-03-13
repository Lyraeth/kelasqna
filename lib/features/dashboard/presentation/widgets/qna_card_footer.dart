import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

class QnaCardFooter extends StatelessWidget {
  const QnaCardFooter({
    super.key,
    required this.questionEntity,
    required this.createdAt,
    this.activeActions = true,
  });

  final QuestionEntity questionEntity;

  final String createdAt;

  final bool activeActions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.all,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NeoKelasEngagementButton(
            questionEntity: questionEntity,
            onLikeTap: activeActions
                ? () {
                    context.read<QuestionsBloc>().add(
                      QuestionsEvent.toggleLike(id: questionEntity.id),
                    );
                  }
                : null,
            onBookmarkTap: activeActions
                ? () {
                    context.read<QuestionsBloc>().add(
                      QuestionsEvent.toggleBookmark(id: questionEntity.id),
                    );
                  }
                : null,
          ),
          NeoKelasTimeago(time: createdAt),
        ],
      ),
    );
  }
}
