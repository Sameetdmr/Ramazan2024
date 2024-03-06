import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Random random = Random();

abstract class ILocalNotificationService {
  Future<NotificationDetails> notificationDetails();
  Future<void> initializePlatformNotifications();
  Future<void> showFirebaseNotification(String title, String body);
  Future<void> schedulePrayerTimeNotification(String city, DateTime notificationDate);
}

class LocalNotificationService implements ILocalNotificationService {
  @override
  Future<NotificationDetails> notificationDetails() async {
    AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      'ramadanAppChannelId-1',
      'E-Imsakiye Ramadan',
      description: 'Ramadan App Push Notifications With Sound',
      sound: RawResourceAndroidNotificationSound("cannon"),
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidNotificationChannel);

    final platformChannelSpecificsWithoutCabinSound = NotificationDetails(
      android: AndroidNotificationDetails(
        androidNotificationChannel.id,
        androidNotificationChannel.name,
        importance: androidNotificationChannel.importance,
        enableVibration: true,
        priority: Priority.high,
        enableLights: true,
        sound: androidNotificationChannel.sound,
        icon: '@drawable/cannon',
        playSound: true,
        showWhen: false,
        color: const Color.fromRGBO(0, 0, 0, 0),
        channelDescription: androidNotificationChannel.description,
      ),
      iOS: DarwinNotificationDetails(),
    );

    return platformChannelSpecificsWithoutCabinSound;
  }

  @override
  Future<void> initializePlatformNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/cannon');

    InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
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

    await flutterLocalNotificationsPlugin.show(
      random.nextInt(1 << 31),
      title,
      body,
      _notificationDetails,
    );
  }

  @override
  Future<void> schedulePrayerTimeNotification(String city, DateTime notificationDate) async {
    try {
      await flutterLocalNotificationsPlugin.cancelAll();
      int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
      final timeZone = await _setup();
      tz.TZDateTime originalTZDateTime = tz.TZDateTime.from(notificationDate, timeZone);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        '$city için İftar Vakti!',
        StringCommonConstant.notificationBody,
        originalTZDateTime,
        await notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<tz.Location> _setup() async {
    tz.initializeTimeZones();
    tz.getLocation('Europe/Istanbul');
    return tz.local;
  }
}
