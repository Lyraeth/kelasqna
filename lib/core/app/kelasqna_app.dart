import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kelasqna/core/app/bloc/app_bloc.dart';
import 'package:kelasqna/core/internationalization/intl_translation.dart';
import 'package:kelasqna/core/routes/kelasqna_route.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/core/theme/theme.dart';
import 'package:kelasqna/features/auth/presentation/bloc/auth/auth_bloc.dart';

class KelasQNAApp extends StatelessWidget {
  const KelasQNAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>.value(value: sI<AppBloc>()),
        BlocProvider<AuthBloc>.value(value: sI<AuthBloc>()),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: KelasQNATheme.lightMode(),
            darkTheme: KelasQNATheme.darkMode(),
            themeMode: state.themeMode,
            getPages: KelasQNARoute.getPages,
            initialRoute: KelasQNARoute.authScreen,
            locale: state.locale,
            fallbackLocale: const Locale("en"),
            translationsKeys: IntlTranslation.translationsKeys,
          );
        },
      ),
    );
  }
}
