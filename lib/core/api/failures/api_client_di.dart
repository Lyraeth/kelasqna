import 'package:dio/dio.dart';
import 'package:kelasqna/core/api/api_client.dart';
import 'package:kelasqna/core/shared/constant.dart';

void initApiClientDI() {
  sI.registerLazySingleton<ApiClient>(() => ApiClient(sI<Dio>()));
}
