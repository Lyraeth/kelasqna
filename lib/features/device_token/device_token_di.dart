import 'package:kelasqna/kelasqna.dart';

Future<void> initDeviceTokenDI() async {
  sI.registerLazySingleton<DeviceTokenRepository>(
    () => DeviceTokenRepositoryImpl(sI<DeviceTokenRemoteDataSource>()),
  );

  sI.registerLazySingleton<DeviceTokenRemoteDataSource>(
    () => DeviceTokenRemoteDataSourceImpl(sI<ApiClient>()),
  );

  sI.registerLazySingleton<RegisterFcmTokenUseCase>(
    () => RegisterFcmTokenUseCase(sI<DeviceTokenRepository>()),
  );

  sI.registerLazySingleton<RemoveFcmTokenUseCase>(
    () => RemoveFcmTokenUseCase(sI<DeviceTokenRepository>()),
  );
}
