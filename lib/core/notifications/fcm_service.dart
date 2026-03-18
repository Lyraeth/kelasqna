import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kelasqna/kelasqna.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase sudah di-init di main, jadi langsung handle aja
  await _showLocalNotification(message);
}

final _localNotifications = FlutterLocalNotificationsPlugin();

Future<void> _showLocalNotification(RemoteMessage message) async {
  final notification = message.notification;
  if (notification == null) return;

  await _localNotifications.show(
    id: notification.hashCode,
    title: notification.title,
    body: notification.body,
    notificationDetails: const NotificationDetails(
      android: AndroidNotificationDetails(
        'kelasqna_channel',
        'KelasQNA Notifications',
        channelDescription: 'Notifikasi KelasQNA',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    payload: message.data.toString(),
  );
}

class FCMService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // 1. Minta permission
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    // 2. Setup local notifications
    await _localNotifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );

    // 3. Create notification channel (Android)
    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              'kelasqna_channel',
              'KelasQNA Notifications',
              description: 'Notifikasi KelasQNA',
              importance: Importance.high,
            ),
          );
    }

    // 4. Background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // 5. Foreground handler
    FirebaseMessaging.onMessage.listen((message) {
      _showLocalNotification(message);
      // Trigger reload notifikasi in-app
      sI<NotificationBloc>().add(
        const NotificationEvent.started(forceRefresh: true),
      );
    });

    // 6. Foreground notification presentation (iOS)
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<String?> getToken() async {
    return await _messaging.getToken();
  }

  Future<void> registerToken() async {
    final token = await getToken();
    if (token == null) return;

    await sI<DeviceTokenRepository>().registerFcmToken(
      token: token,
      deviceType: Platform.isAndroid ? 'android' : 'ios',
    );

    _messaging.onTokenRefresh.listen((newToken) {
      sI<DeviceTokenRepository>().registerFcmToken(
        token: newToken,
        deviceType: Platform.isAndroid ? 'android' : 'ios',
      );
    });
  }

  Future<void> unregisterToken() async {
    final token = await getToken();
    if (token == null) return;
    await sI<DeviceTokenRepository>().removeFcmToken(token: token);
  }
}
