import 'package:kelasqna/kelasqna.dart';

Future<void> initAppLockDI() async {
  sI.registerLazySingleton<BiometricService>(() => BiometricService());
  sI.registerLazySingleton<AppLockCubit>(() => AppLockCubit());
}
