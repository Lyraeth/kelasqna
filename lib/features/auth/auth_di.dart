import 'package:kelasqna/kelasqna.dart';

Future<void> initAuthDI() async {
  sI.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sI<AuthRemoteDataSource>()),
  );

  sI.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sI<ApiClient>()),
  );

  sI.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sI<AuthRepository>()),
  );

  sI.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sI<AuthRepository>()),
  );

  sI.registerLazySingleton<AuthBloc>(
    () => AuthBloc(sI<LoginUseCase>(), sI<LogoutUseCase>(), sI<FCMService>()),
  );
}
