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

  sI.registerFactory<UserBloc>(() => UserBloc(sI<RegisterUseCase>()));
}
