part of 'theme.dart';

Future<void> initThemeDI() async {
  sI.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(sI<ThemeLocalDataSource>()),
  );

  sI.registerLazySingleton<ThemeUseCase>(
    () => ThemeUseCase(sI<ThemeRepository>()),
  );

  sI.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(),
  );
}
