part of 'api_client.dart';

void initApiClientDI() {
  sI.registerLazySingleton<ApiClient>(() => ApiClient(sI<Dio>()));
}
