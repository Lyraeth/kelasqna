import 'package:kelasqna/core/api/api_client.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:kelasqna/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:kelasqna/features/auth/data/repository/auth_repository_impl.dart';
import 'package:kelasqna/features/auth/domain/repository/auth_repository.dart';
import 'package:kelasqna/features/auth/domain/usecase/auth_use_case.dart';
import 'package:kelasqna/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:kelasqna/features/auth/presentation/bloc/me/me_bloc.dart';
import 'package:kelasqna/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:kelasqna/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

void initAuthDI() {
  sI.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sI<AuthLocalDataSource>(),
      sI<AuthRemoteDataSource>(),
    ),
  );

  sI.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(sI<AuthRepository>()),
  );

  sI.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
  sI.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sI<ApiClient>()),
  );

  sI.registerLazySingleton<AuthBloc>(() => AuthBloc(sI<AuthUseCase>()));
  sI.registerFactory<SignInBloc>(
    () => SignInBloc(sI<AuthUseCase>(), sI<AuthBloc>()),
  );
  sI.registerFactory<RegisterBloc>(() => RegisterBloc(sI<AuthUseCase>()));
  sI.registerFactory<MeBloc>(() => MeBloc(sI<AuthUseCase>()));
}
