import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

class CommentsBlocListener extends StatelessWidget {
  const CommentsBlocListener({
    super.key,
    required this.child,
    required this.questionId,
  });

  final Widget child;

  final int questionId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateCommentBloc, CreateCommentState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (commentsEntity) {
                context.read<QuestionBloc>().add(
                  QuestionEvent.fetchQuestion(questionId, forceRefresh: true),
                );

                context.read<QuestionsBloc>().add(
                  QuestionsEvent.started(forceRefresh: true),
                );

                NeoKelasAppToast.show(
                  context,
                  message: context.l10n.createCommentSuccess,
                  type: ToastType.success,
                );
              },
              failure: (failure) {
                NeoKelasAppToast.show(
                  context,
                  message: failure.message(context),
                  type: ToastType.error,
                );
              },
            );
          },
        ),
        BlocListener<EditCommentBloc, EditCommentState>(
          listener: (context, state) {
            state.whenOrNull(
              failure: (failure) {
                NeoKelasAppToast.show(
                  context,
                  message: failure.message(context),
                  type: .error,
                );
              },
              success: (commentsEntity) {
                context.router.pop();

                context.read<QuestionBloc>().add(
                  QuestionEvent.fetchQuestion(questionId, forceRefresh: true),
                );

                NeoKelasAppToast.show(
                  context,
                  message: context.l10n.editCommentSuccess,
                  type: ToastType.success,
                );
              },
            );
          },
        ),
        BlocListener<DeleteCommentBloc, DeleteCommentState>(
          listener: (context, state) {
            state.whenOrNull(
              failure: (failure) {
                NeoKelasAppToast.show(
                  context,
                  message: failure.message(context),
                  type: ToastType.error,
                );
              },
              success: () {
                NeoKelasAppToast.show(
                  context,
                  message: context.l10n.deleteCommentSuccess,
                  type: ToastType.success,
                );
              },
            );
          },
        ),
      ],
      child: child,
    );
  }
}
