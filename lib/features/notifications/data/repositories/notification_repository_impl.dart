import 'package:fpdart/fpdart.dart';
import 'package:kelasqna/kelasqna.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<PaginatedResult<NotificationEntity>>> fetchNotifications({
    int page = 1,
  }) async {
    final response = await _remoteDataSource.fetchNotifications(page: page);

    return response.match((failure) => Left(failure), (
      NotificationResponse notificationResponse,
    ) {
      final meta = notificationResponse.meta;

      final totalPage = meta.lastPage;

      return Right(
        PaginatedResult<NotificationEntity>(
          data: notificationResponse.listNotification
              .map((m) => m.toEntity())
              .toList(),
          currentPage: meta.currentPage,
          totalPages: totalPage,
        ),
      );
    });
  }

  @override
  Future<Result<Unit>> markAllAsRead() async {
    final response = await _remoteDataSource.markAllAsRead();

    return response.match((failure) => Left(failure), (res) => Right(unit));
  }

  @override
  Future<Result<Unit>> markAsRead({required String id}) async {
    final response = await _remoteDataSource.markAsRead(id: id);

    return response.match((failure) => Left(failure), (res) => Right(unit));
  }
}
