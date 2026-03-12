import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:kelasqna/l10n/app_localizations.dart';

class KelasQNAApp extends StatelessWidget {
  KelasQNAApp({super.key});

  late final KelasQNARouter _appRouter = KelasQNARouter(sI<AuthGuard>());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>.value(value: sI<AppBloc>()),
        BlocProvider<SessionsBloc>.value(value: sI<SessionsBloc>()),
        BlocProvider<AuthBloc>.value(value: sI<AuthBloc>()),
        BlocProvider<UserBloc>.value(value: sI<UserBloc>()),
        BlocProvider<QuestionsBloc>.value(value: sI<QuestionsBloc>()),
        BlocProvider<QuestionBloc>.value(value: sI<QuestionBloc>()),
        BlocProvider<CreateQuestionBloc>.value(value: sI<CreateQuestionBloc>()),
        BlocProvider<DeleteQuestionBloc>.value(value: sI<DeleteQuestionBloc>()),
        BlocProvider<EditQuestionBloc>.value(value: sI<EditQuestionBloc>()),
        BlocProvider<CreateCommentBloc>.value(value: sI<CreateCommentBloc>()),
        BlocProvider<EditCommentBloc>.value(value: sI<EditCommentBloc>()),
        BlocProvider<DeleteCommentBloc>.value(value: sI<DeleteCommentBloc>()),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return BlocListener<SessionsBloc, SessionsState>(
            listener: (context, state) {
              state.whenOrNull(
                firstTime: () {
                  _appRouter.replaceAll([const AuthRoute()]);
                },
                unauthenticated: () {
                  _appRouter.replaceAll([const LoginRoute()]);
                },
                authenticated: (_, _, _) {
                  context.read<QuestionsBloc>().add(
                    QuestionsEvent.started(forceRefresh: true),
                  );

                  _appRouter.replaceAll([const HomeRoute()]);
                },
              );
            },
            child: MaterialApp.router(
              routerConfig: _appRouter.config(),
              debugShowCheckedModeBanner: false,
              theme: KelasQNATheme.lightMode(),
              darkTheme: KelasQNATheme.darkMode(),
              themeMode: state.themeMode,
              locale: state.locale,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
            ),
          );
        },
      ),
    );
  }
}
