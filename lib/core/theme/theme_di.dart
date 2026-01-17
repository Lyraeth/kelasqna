import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/core/theme/data/datasources/theme_local_data_source.dart';
import 'package:kelasqna/core/theme/data/repository/theme_repository_impl.dart';
import 'package:kelasqna/core/theme/domain/repository/theme_repository.dart';
import 'package:kelasqna/core/theme/domain/usecase/theme_use_case.dart';

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
