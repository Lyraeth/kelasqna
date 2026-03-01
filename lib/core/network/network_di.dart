import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kelasqna/kelasqna.dart';

void initNetworkDI({
  required String baseUrl,
  Future<String?> Function()? tokenProvider,
}) {
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
      ),
    ],
  );

  sI.registerLazySingleton<Dio>(() => dio);
}
