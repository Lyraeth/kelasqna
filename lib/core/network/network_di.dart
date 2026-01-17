import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kelasqna/core/network/dio_factory.dart';
import 'package:kelasqna/core/shared/constant.dart';

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
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = "Bearer $token";
          }
          handler.next(options);
        },
      ),
    ],
  );

  sI.registerLazySingleton<Dio>(() => dio);
}
