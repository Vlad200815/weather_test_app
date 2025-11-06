import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/di/di.dart';
// import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/main.dart';
// import 'package:timezone/browser.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:weather_test_app/services/determine_weather_condition.dart';

class NotificationService {
  Future<void> setupNotifications() async {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(provisional: true);

    // Get FCM token (for debugging)
    final token = await messaging.getToken();
    log('FCM Token: $token');

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: DarwinInitializationSettings(),
        );

    // var flutterLocalNotificationsPlugin;
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Create the channel on Android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Initialize timezone
    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation('Europe/Kyiv'),
    ); // ✅ important for Ukraine

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon ?? '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  Future<void> scheduleDailyWeatherNotification(
    WeatherResponseModel weather,
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Today’s Weather',
      'Temperature: ${weather.current.currentTem}°C, ${getIt<DetermineWeatherCondition>().weatherConditionDetermine(weatherCode: weather.current.weatherCode)["weatherConditon"]}',
      _nextInstanceOf8AM(), // tz.TZDateTime
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_weather_channel',
          'Daily Weather',
          channelDescription: 'Daily weather forecast notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents:
          DateTimeComponents.time, // for daily at same time
    );
  }

  tz.TZDateTime _nextInstanceOf8AM() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      8,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> showTestNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    final double tem = getIt<WeatherResponseModel>().current.currentTem;
    final String weatherCon = getIt<DetermineWeatherCondition>()
        .weatherConditionDetermine(
          weatherCode: getIt<WeatherResponseModel>().current.weatherCode,
        )["weatherConditon"]!;

    await flutterLocalNotificationsPlugin.show(
      0,
      '🌤️ Weather is $tem',
      weatherCon,
      platformChannelSpecifics,
    );
  }
}
