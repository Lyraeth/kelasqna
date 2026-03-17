import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

abstract class NotificationRemoteDataSource {
  Future<Result<NotificationResponse>> fetchNotifications({int page = 1});

  Future<Result<Unit>> markAsRead({required String id});

  Future<Result<Unit>> markAllAsRead();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiClient _apiClient;

  NotificationRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<NotificationResponse>> fetchNotifications({
    int page = 1,
  }) async {
    try {
      final response = await _apiClient.get(
        notificationsUrl,
        queryParameters: {'page': page},
      );

      return response.match(
        (failure) => Left(failure),
        (Map<String, dynamic> json) =>
            Right(NotificationResponse.fromJson(json)),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<Unit>> markAllAsRead() async {
    try {
      final response = await _apiClient.post(
        "$notificationsUrl/read-all",
        data: {},
      );

      return response.match(
        (failure) => Left(failure),
        (Map<String, dynamic> json) => Right(unit),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<Unit>> markAsRead({required String id}) async {
    try {
      final response = await _apiClient.post(
        "$notificationsUrl/$id/read",
        data: {},
      );

      return response.match(
        (failure) => Left(failure),
        (Map<String, dynamic> json) => Right(unit),
      );
    } catch (e, st) {
      return Left(Failure.fromDio(e, st));
    }
  }
}
