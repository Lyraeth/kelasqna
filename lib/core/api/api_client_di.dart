part of 'api_client.dart';

Future<void> initApiClientDI() async {
  sI.registerLazySingleton<ApiClient>(() => ApiClient(sI<Dio>()));
}
