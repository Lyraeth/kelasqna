import 'package:kelasqna/kelasqna.dart';

Future<void> initAppLockDI() async {
  sI.registerLazySingleton<AppLockRepository>(
    () => AppLockRepositoryImpl(sI<AppLockLocalDataSource>()),
  );

  sI.registerLazySingleton<AppLockLocalDataSource>(
    () => AppLockLocalDataSourceImpl(),
  );

  sI.registerLazySingleton<GetAppLockSettingsUseCase>(
    () => GetAppLockSettingsUseCase(sI<AppLockRepository>()),
  );
  sI.registerLazySingleton<SaveAppLockSettingsUseCase>(
    () => SaveAppLockSettingsUseCase(sI<AppLockRepository>()),
  );

  sI.registerLazySingleton<BiometricService>(() => BiometricService());
  sI.registerLazySingleton<AppLockCubit>(
    () => AppLockCubit(
      sI<GetAppLockSettingsUseCase>(),
      sI<SaveAppLockSettingsUseCase>(),
    ),
  );
}
