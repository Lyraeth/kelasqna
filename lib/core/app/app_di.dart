import 'package:kelasqna/kelasqna.dart';

void initAppDI() {
  sI.registerFactory<AppBloc>(
    () => AppBloc(sI<ThemeUseCase>(), sI<LanguageStorage>()),
  );
}
