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
    return AppBlocProvider(
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
                  _appRouter.replaceAll([const HomeRoute()]);
                },
              );
            },
            child: AppConnectivityBlocListener(
              appRouter: _appRouter,
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
            ),
          );
        },
      ),
    );
  }
}
