import 'dart:developer';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/app.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/firebase_options.dart';
import 'package:weather_test_app/services/location_service.dart';
import 'package:weather_test_app/services/notification_service.dart';
import 'package:weather_test_app/services/weather_api_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;

// Handles background messages when the app is terminated or in background
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: ".env");
  tz.initializeTimeZones();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  setupDependencies();

  //for analytics
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final locationService = getIt<LocationService>();
  await getIt<LocationService>().determinePosition();

  final latitude = locationService.latitude;
  final longitude = locationService.longitude;

  if (latitude == null || longitude == null) {
    log("Failed to get location");
    return;
  }

  final weatherApiService = getIt<WeatherApiService>();
  final WeatherResponseModel weatherData = await weatherApiService.fetchWeather(
    latitude,
    longitude,
  );

  getIt.registerSingleton<WeatherResponseModel>(weatherData);

  await getIt<NotificationService>().setupNotifications();
  // await getIt<NotificationService>().scheduleDailyWeatherNotification(
  //   weatherData,
  // );

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('uk', "UA")],
      path: 'assets/translations',
      fallbackLocale: Locale('en', "US"),
      child: MyWeatherApp(),
    ),
  );
}
