import 'package:kelasqna/kelasqna.dart';

Future<void> initSessionsDI() async {
  sI.registerLazySingleton<SessionsRepository>(
    () => SessionsRepositoryImpl(
      sI<SessionsLocalDataSource>(),
      sI<SessionsRemoteDataSource>(),
    ),
  );

  sI.registerLazySingleton<AuthGuard>(
    () => AuthGuard(sI<SessionsRepository>()),
  );

  sI.registerLazySingleton<SessionsLocalDataSource>(
    () => SessionsLocalDataSourceImpl(),
  );

  sI.registerLazySingleton<SessionsRemoteDataSource>(
    () => SessionsRemoteDataSourceImpl(sI<ApiClient>()),
  );

  sI.registerLazySingleton<MeUseCase>(
    () => MeUseCase(sI<SessionsRepository>()),
  );
  sI.registerLazySingleton<GetAccessTokenUseCase>(
    () => GetAccessTokenUseCase(sI<SessionsRepository>()),
  );
  sI.registerLazySingleton<SaveAccessTokenUseCase>(
    () => SaveAccessTokenUseCase(sI<SessionsRepository>()),
  );
  sI.registerLazySingleton<ClearSessionUseCase>(
    () => ClearSessionUseCase(sI<SessionsRepository>()),
  );
  sI.registerLazySingleton<GetLoggedUserDetailsUseCase>(
    () => GetLoggedUserDetailsUseCase(sI<SessionsRepository>()),
  );
  sI.registerLazySingleton<SaveLoggedUserDetailsUseCase>(
    () => SaveLoggedUserDetailsUseCase(sI<SessionsRepository>()),
  );
  sI.registerLazySingleton<IsFirstTimeUserOpenAppUseCase>(
    () => IsFirstTimeUserOpenAppUseCase(sI<SessionsRepository>()),
  );
  sI.registerLazySingleton<SetFirstTimeUserOpenedAppUseCase>(
    () => SetFirstTimeUserOpenedAppUseCase(sI<SessionsRepository>()),
  );
  sI.registerLazySingleton<FetchSessionsDeviceUseCase>(
    () => FetchSessionsDeviceUseCase(sI<SessionsRepository>()),
  );
  sI.registerLazySingleton<DeleteSessionDeviceUseCase>(
    () => DeleteSessionDeviceUseCase(sI<SessionsRepository>()),
  );

  sI.registerLazySingleton<SessionsBloc>(
    () => SessionsBloc(
      sI<SaveAccessTokenUseCase>(),
      sI<ClearSessionUseCase>(),
      sI<MeUseCase>(),
      sI<GetAccessTokenUseCase>(),
      sI<GetLoggedUserDetailsUseCase>(),
      sI<SaveLoggedUserDetailsUseCase>(),
      sI<IsFirstTimeUserOpenAppUseCase>(),
      sI<SetFirstTimeUserOpenedAppUseCase>(),
      sI<FCMService>(),
    ),
  );

  sI.registerFactory<SessionsDeviceBloc>(
    () => SessionsDeviceBloc(sI<FetchSessionsDeviceUseCase>()),
  );

  sI.registerFactory<SessionsRevokeDeviceBloc>(
    () => SessionsRevokeDeviceBloc(sI<DeleteSessionDeviceUseCase>()),
  );
}
