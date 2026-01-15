import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  Dio buildDioClient({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 20),
    List<Interceptor> extraInterceptors = const [],
    bool enablePrettyLogging = false,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
      ),
    );

    if (enablePrettyLogging) {
      dio.interceptors.add(_prettyLoggerIfAvailable());
    }

    dio.interceptors.addAll([...extraInterceptors]);

    return dio;
  }

  Interceptor _prettyLoggerIfAvailable() {
    try {
      final logger =
          (PrettyDioLogger(
                requestHeader: true,
                requestBody: true,
                responseBody: false,
                responseHeader: false,
                compact: true,
                maxWidth: 90,
              ))
              as Interceptor;
      return logger;
    } catch (_) {
      return InterceptorsWrapper();
    }
  }
}
