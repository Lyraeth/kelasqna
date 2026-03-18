import 'package:kelasqna/kelasqna.dart';

Future<void> initNotificationsDI() async {
  sI.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(sI<NotificationRemoteDataSource>()),
  );

  sI.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(sI<ApiClient>()),
  );

  sI.registerLazySingleton<FetchNotificationsUseCase>(
    () => FetchNotificationsUseCase(sI<NotificationRepository>()),
  );

  sI.registerLazySingleton<MarkAllAsReadUseCase>(
    () => MarkAllAsReadUseCase(sI<NotificationRepository>()),
  );

  sI.registerLazySingleton<MarkAsReadUseCase>(
    () => MarkAsReadUseCase(sI<NotificationRepository>()),
  );

  sI.registerLazySingleton<NotificationBloc>(
    () => NotificationBloc(
      sI<FetchNotificationsUseCase>(),
      sI<MarkAsReadUseCase>(),
      sI<MarkAllAsReadUseCase>(),
    ),
  );
}
