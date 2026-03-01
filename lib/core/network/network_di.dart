import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kelasqna/kelasqna.dart';

Future<void> initNetworkDI({
  required String baseUrl,
  Future<String?> Function()? tokenProvider,
}) async {
  final dio = DioFactory().buildDioClient(
    baseUrl: baseUrl,
    enablePrettyLogging: !kReleaseMode,
    extraInterceptors: [
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenProvider?.call();
          debugPrint("TOKEN USED: $token");

          if (token != null && token.isNotEmpty) {
            options.headers['Content-Type'] = "application/json";
            options.headers['Authorization'] = "Bearer $token";
          }

          debugPrint("HEADERS NOW: ${options.headers}");

          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await sI<SessionsRepository>().clearSession();
            sI<TokenProvider>().clearToken();

            sI<SessionsBloc>().add(const SessionsEvent.loggedOut());
          }

          handler.next(error);
        },
      ),
    ],
  );

  sI.registerLazySingleton<Dio>(() => dio);
}
