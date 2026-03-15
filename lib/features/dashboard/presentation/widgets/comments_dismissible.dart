import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CommentDismissible extends StatelessWidget {
  const CommentDismissible({
    super.key,
    required this.child,
    required this.commentEntity,
    required this.questionEntity,
  });

  final Widget child;

  final CommentsEntity commentEntity;

  final QuestionEntity questionEntity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(commentEntity.id),
      direction:
          commentEntity.author.id == context.read<SessionsBloc>().getUserId
          ? DismissDirection.horizontal
          : DismissDirection.none,
      background: CommentsCardSwipeBackground(
        alignment: Alignment.centerRight,
        color: context.colors.primary,
        icon: LucideIcons.pencil,
      ),
      secondaryBackground: CommentsCardSwipeBackground(
        alignment: Alignment.centerLeft,
        color: context.colors.error,
        icon: LucideIcons.trash2,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          bool confirmed = false;
          await NeoKelasDeleteDialog.show(
            context,
            title: context.l10n.deleteComment,
            description: context.l10n.deleteCommentDesc,
            onConfirm: () => confirmed = true,
          );
          return confirmed;
        } else {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (_) => BlocProvider<EditCommentBloc>.value(
                value: context.read<EditCommentBloc>(),
                child: EditCommentScreen(
                  commentEntity: commentEntity,
                  questionEntity: questionEntity,
                ),
              ),
            ),
          );
          return false;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          context.read<DeleteCommentBloc>().add(
            DeleteCommentEvent.deleteComment(
              questionEntity.id,
              commentEntity.id,
            ),
          );
        }
      },
      child: child,
    );
  }
}
