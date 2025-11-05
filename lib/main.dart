import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/app.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/location_service.dart';
import 'package:weather_test_app/services/weather_api_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: ".env");
  setupDependencies();

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

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('uk', "UA")],
      path: 'assets/translations',
      fallbackLocale: Locale('en', "US"),
      child: MyWeatherApp(),
    ),
  );
}
