import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/core/api/failures/failure.dart';
import 'package:kelasqna/core/type/types.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<Result<Map<String, dynamic>>> get<T>(
    String apiUrl, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(apiUrl, queryParameters: queryParameters);

      final result = response.data;

      if (result is Map<String, dynamic>) return Right(result);

      if (result is String) return ApiHelper.decodeJsonObject(result);
      return Left(Failure.serialization(cause: result));
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  Future<Result<Map<String, dynamic>>> post<T>(
    String apiUrl, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(apiUrl, queryParameters: queryParameters);

      final result = response.data;

      if (result is Map<String, dynamic>) return Right(result);

      if (result is String) return ApiHelper.decodeJsonObject(result);
      return Left(Failure.serialization(cause: result));
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }
}

mixin ApiHelper {
  static Result<Map<String, dynamic>> decodeJsonObject(String raw) {
    try {
      final decoded = json.decode(raw);
      if (decoded is Map<String, dynamic>) return right(decoded);
      return left(Failure.serialization(cause: decoded));
    } catch (e, st) {
      return left(Failure.serialization(cause: e, stackTrace: st));
    }
  }

  static Result<List<dynamic>> decodeJsonArray(String raw) {
    try {
      final decoded = json.decode(raw);
      if (decoded is List) return right(decoded);
      return left(Failure.serialization(cause: decoded));
    } catch (e, st) {
      return left(Failure.serialization(cause: e, stackTrace: st));
    }
  }
}
