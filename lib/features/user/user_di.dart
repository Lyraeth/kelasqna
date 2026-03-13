import 'package:kelasqna/kelasqna.dart';

Future<void> initUserDI() async {
  sI.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sI<UserRemoteDataSource>()),
  );

  sI.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDateSourceImpl(sI<ApiClient>()),
  );

  sI.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sI<UserRepository>()),
  );

  sI.registerLazySingleton<FetchAnotherUserUseCase>(
    () => FetchAnotherUserUseCase(sI<UserRepository>()),
  );

  sI.registerFactory<RegisterBloc>(() => RegisterBloc(sI<RegisterUseCase>()));

  sI.registerFactory<UserBloc>(() => UserBloc(sI<FetchAnotherUserUseCase>()));
}
