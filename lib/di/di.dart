import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/services/analytics.dart';
import 'package:weather_test_app/services/capitalize.dart';
import 'package:weather_test_app/services/determine_weather_condition.dart';
import 'package:weather_test_app/services/location_service.dart';
import 'package:weather_test_app/services/notification_service.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/services/weather_api_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  //register weather api client
  getIt.registerLazySingleton<WeatherApiClient>(() {
    final apiUrl = dotenv.env["API_URL"];
    final dio = getIt<Dio>()
      ..interceptors.add(LogInterceptor(requestBody: true, request: true));
    return WeatherApiClient(dio, baseUrl: apiUrl);
  });

  getIt.registerLazySingleton<WeatherApiService>(
    () => WeatherApiService(apiClient: getIt<WeatherApiClient>()),
  );

  getIt.registerSingleton<Responsiveness>(Responsiveness());
  getIt.registerLazySingleton<LocationService>(() => LocationService());
  getIt.registerSingleton<Capitalize>(Capitalize());
  getIt.registerSingleton<DetermineWeatherCondition>(
    DetermineWeatherCondition(),
  );
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  getIt.registerSingleton<Analytics>(Analytics());
}
