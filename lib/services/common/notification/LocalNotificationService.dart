import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterFirebaseNotificationsPlugin = FlutterLocalNotificationsPlugin();
Random random = Random();

abstract class ILocalNotificationService {
  Future<NotificationDetails> notificationDetails();
  Future<void> initializePlatformNotifications();
  Future<void> showFirebaseNotification(String title, String body);
}

class LocalNotificationService implements ILocalNotificationService {
  @override
  Future<NotificationDetails> notificationDetails() async {
    AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      'ramadanAppChannelId',
      'Ramadan App',
      description: 'Ramadan App Push Notifications',
      importance: Importance.max,
    );

    await flutterFirebaseNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidNotificationChannel);

    final platformChannelSpecificsWithoutCabinSound = NotificationDetails(
      android: AndroidNotificationDetails(
        androidNotificationChannel.id,
        androidNotificationChannel.name,
        importance: androidNotificationChannel.importance,
        enableVibration: true,
        priority: Priority.high,
        enableLights: true,
        icon: '@mipmap/ic_launcher',
        color: const Color.fromRGBO(0, 0, 0, 0),
        channelDescription: androidNotificationChannel.description,
      ),
      iOS: DarwinNotificationDetails(),
    );

    return platformChannelSpecificsWithoutCabinSound;
  }

  @override
  Future<void> initializePlatformNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterFirebaseNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print('samet 2');
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        print('samet');
      },
    );
  }

  @override
  Future<void> showFirebaseNotification(String title, String body) async {
    final _notificationDetails = await notificationDetails();

    await flutterFirebaseNotificationsPlugin.show(
      random.nextInt(1 << 31),
      title,
      body,
      _notificationDetails,
    );
  }
}
