import 'package:kelasqna/kelasqna.dart';

Future<void> initAppDI() async {
  sI.registerFactory<AppBloc>(
    () => AppBloc(sI<ThemeUseCase>(), sI<LanguageStorage>()),
  );
}
