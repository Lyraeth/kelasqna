import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

class AppBlocProvider extends StatelessWidget {
  const AppBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>.value(value: sI<AppBloc>()),
        BlocProvider<SessionsBloc>.value(value: sI<SessionsBloc>()),
        BlocProvider<AuthBloc>.value(value: sI<AuthBloc>()),
        BlocProvider<RegisterBloc>.value(value: sI<RegisterBloc>()),
        BlocProvider<UserBloc>.value(value: sI<UserBloc>()),
        BlocProvider<QuestionsBloc>.value(value: sI<QuestionsBloc>()),
        BlocProvider<QuestionBloc>.value(value: sI<QuestionBloc>()),
        BlocProvider<CreateQuestionBloc>.value(value: sI<CreateQuestionBloc>()),
        BlocProvider<DeleteQuestionBloc>.value(value: sI<DeleteQuestionBloc>()),
        BlocProvider<EditQuestionBloc>.value(value: sI<EditQuestionBloc>()),
        BlocProvider<CreateCommentBloc>.value(value: sI<CreateCommentBloc>()),
        BlocProvider<EditCommentBloc>.value(value: sI<EditCommentBloc>()),
        BlocProvider<DeleteCommentBloc>.value(value: sI<DeleteCommentBloc>()),
        BlocProvider<ProfileBookmarksBloc>.value(
          value: sI<ProfileBookmarksBloc>(),
        ),
        BlocProvider<ProfileQuestionsBloc>.value(
          value: sI<ProfileQuestionsBloc>(),
        ),
        BlocProvider<ProfileCommentsBloc>.value(
          value: sI<ProfileCommentsBloc>(),
        ),
        BlocProvider<SessionsDeviceBloc>.value(value: sI<SessionsDeviceBloc>()),
        BlocProvider<SessionsRevokeDeviceBloc>.value(
          value: sI<SessionsRevokeDeviceBloc>(),
        ),
      ],
      child: child,
    );
  }
}
