import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingRemoteDatasource {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        // showNotification(id: id, title: title, body: body, payLoad: payload);
      },
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        _handleNotificationClick(notificationResponse.payload);
      },
    );

    final fcmToken = await _firebaseMessaging.getToken();
    debugPrint('FCM Token: $fcmToken');

    // if (await AuthLocalDatasource().getAuthData() != null) {
    //   AuthRemoteDatasource().updateFcmToken(fcmToken!);
    // }

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessageClick(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground message received: ${message.notification?.body}');
      showNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        payload: message.data['route'],
      );
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessageClick(message);
    });
  }

  void _handleNotificationClick(String? payload) {
    if (payload != null) {
      //context
      debugPrint('Notification clicked with payload: $payload');
      // Implement your navigation logic here
    }
  }

  void _handleMessageClick(RemoteMessage message) {
    final String? route = message.data['route'];
    if (route != null) {
      // Navigate to the specific page based on the route data in the message
      // For example:
      // Navigator.pushNamed(context, route);
      debugPrint('Message opened with route: $route');
      // Implement your navigation logic here
    }
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'com.example.clinic_management_app',
      'app',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosPlatformChannelSpecifics = DarwinNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    FirebaseMessagingRemoteDatasource().firebaseBackgroundHandler(message);
  }

  Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
    showNotification(
      title: message.notification?.title,
      body: message.notification?.body,
      payload: message.data['route'], // Add the payload here
    );
  }
}
