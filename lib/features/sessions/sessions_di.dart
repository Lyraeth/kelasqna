import 'package:kelasqna/kelasqna.dart';

void initSessionsDI() {
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
  sI.registerLazySingleton<SetAccessTokenUseCase>(
    () => SetAccessTokenUseCase(sI<SessionsRepository>()),
  );
  sI.registerLazySingleton<ClearSessionUseCase>(
    () => ClearSessionUseCase(sI<SessionsRepository>()),
  );

  sI.registerFactory<SessionsBloc>(
    () => SessionsBloc(sI<SessionsRepository>()),
  );
}
