import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

class QuestionsBlocListener extends StatelessWidget {
  const QuestionsBlocListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<QuestionsBloc, QuestionsState>(
          listener: (context, state) {
            state.whenOrNull(
              failure: (failure) {
                NeoKelasAppToast.show(
                  context,
                  message: failure.message(context),
                  type: ToastType.error,
                  forShowOnMenuScreen: true,
                );
              },
            );
          },
        ),
        BlocListener<CreateQuestionBloc, CreateQuestionState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (questionEntity) {
                context.router.pop();

                context.read<QuestionsBloc>().add(
                  QuestionsEvent.started(forceRefresh: true),
                );

                NeoKelasAppToast.show(
                  context,
                  message: context.l10n.createQuestionSuccess,
                  type: ToastType.success,
                  forShowOnMenuScreen: true,
                );
              },
              failure: (failure) {
                NeoKelasAppToast.show(
                  context,
                  message: failure.message(context),
                  type: ToastType.error,
                  forShowOnMenuScreen: true,
                );
              },
            );
          },
        ),
        BlocListener<EditQuestionBloc, EditQuestionState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (questionEntity) {
                context.router.pop();

                context.read<QuestionsBloc>().add(
                  QuestionsEvent.started(forceRefresh: true),
                );

                NeoKelasAppToast.show(
                  context,
                  message: context.l10n.editQuestionSuccess,
                  type: ToastType.success,
                  forShowOnMenuScreen: true,
                );
              },
              failure: (failure) {
                NeoKelasAppToast.show(
                  context,
                  message: failure.message(context),
                  type: ToastType.error,
                  forShowOnMenuScreen: true,
                );
              },
            );
          },
        ),
        BlocListener<DeleteQuestionBloc, DeleteQuestionState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                context.read<QuestionsBloc>().add(
                  QuestionsEvent.started(forceRefresh: true),
                );

                NeoKelasAppToast.show(
                  context,
                  message: context.l10n.deleteQuestionSuccess,
                  type: ToastType.success,
                  forShowOnMenuScreen: true,
                );
              },
              failure: (failure) {
                NeoKelasAppToast.show(
                  context,
                  message: failure.message(context),
                  type: ToastType.error,
                  forShowOnMenuScreen: true,
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
