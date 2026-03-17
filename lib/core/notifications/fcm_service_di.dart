import 'package:kelasqna/kelasqna.dart';

Future<void> initFcmServiceDI() async {
  sI.registerLazySingleton<FCMService>(() => FCMService());
}
