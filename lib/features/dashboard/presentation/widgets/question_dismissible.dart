import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class QuestionDismissible extends StatelessWidget {
  const QuestionDismissible({
    super.key,
    required this.child,
    required this.questionEntity,
  });

  final Widget child;

  final QuestionEntity questionEntity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(questionEntity.id),
      direction:
          questionEntity.author.id == context.read<SessionsBloc>().getUserId
          ? DismissDirection.horizontal
          : DismissDirection.none,
      background: QuestionsCardSwipeBackground(
        alignment: Alignment.centerRight,
        color: context.colors.primary,
        icon: LucideIcons.pencil,
      ),
      secondaryBackground: QuestionsCardSwipeBackground(
        alignment: Alignment.centerLeft,
        color: context.colors.error,
        icon: LucideIcons.trash2,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          bool confirmed = false;
          await NeoKelasDeleteDialog.show(
            context,
            title: context.l10n.deleteQuestion,
            description: context.l10n.deleteQuestionDesc,
            onConfirm: () => confirmed = true,
          );
          return confirmed;
        } else {
          showCupertinoSheet(
            context: context,
            builder: (context) => Material(
              child: SafeArea(
                child: EditQuestionScreen(questionEntity: questionEntity),
              ),
            ),
          );
          return false;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          context.read<DeleteQuestionBloc>().add(
            DeleteQuestionEvent.deleteQuestion(id: questionEntity.id),
          );
        }
      },
      child: child,
    );
  }
}
