part of 'theme.dart';

void initThemeDI() {
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
