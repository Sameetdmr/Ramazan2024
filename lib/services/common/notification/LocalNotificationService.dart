// ignore_for_file: depend_on_referenced_packages, directives_ordering

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';
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

final class LocalNotificationService implements ILocalNotificationService {
  @override
  Future<NotificationDetails> notificationDetails() async {
    const androidNotificationChannel = AndroidNotificationChannel(
      'ramadanAppChannelId-1',
      'E-Imsakiye Ramadan',
      description: 'Ramadan App Push Notifications With Sound',
      sound: RawResourceAndroidNotificationSound('cannon'),
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidNotificationChannel);

    final platformChannelSpecificsWithoutCabinSound = NotificationDetails(
      android: AndroidNotificationDetails(
        androidNotificationChannel.id,
        androidNotificationChannel.name,
        importance: androidNotificationChannel.importance,
        priority: Priority.high,
        enableLights: true,
        sound: androidNotificationChannel.sound,
        icon: '@drawable/cannon',
        showWhen: false,
        color: const Color.fromRGBO(0, 0, 0, 0),
        channelDescription: androidNotificationChannel.description,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    return platformChannelSpecificsWithoutCabinSound;
  }

  @override
  Future<void> initializePlatformNotifications() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('@drawable/cannon');

    const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
      onDidReceiveBackgroundNotificationResponse: (details) {},
    );
  }

  @override
  Future<void> showFirebaseNotification(String title, String body) async {
    await flutterLocalNotificationsPlugin.show(random.nextInt(1 << 31), title, body, await notificationDetails());
  }

  @override
  Future<void> schedulePrayerTimeNotification(String city, DateTime notificationDate) async {
    try {
      await flutterLocalNotificationsPlugin.cancelAll();
      final id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
      final timeZone = await _setup();
      final originalTZDateTime = tz.TZDateTime.from(notificationDate, timeZone);

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
      throw CustomException(StringCommonConstant.anErrorOccured);
    }
  }

  Future<tz.Location> _setup() async {
    tz.initializeTimeZones();
    tz.getLocation('Europe/Istanbul');
    return tz.local;
  }
}
