import 'package:get_it/get_it.dart';
import 'package:weather_test_app/services/capitalize.dart';
import 'package:weather_test_app/services/determine_weather_condition.dart';
import 'package:weather_test_app/services/location_service.dart';
import 'package:weather_test_app/services/responsiveness.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<Responsiveness>(Responsiveness());
  getIt.registerLazySingleton<LocationService>(() => LocationService());
  //new no connected to the blocs
  getIt.registerSingleton<Capitalize>(Capitalize());
  
  //add determine weather condition service
  getIt.registerSingleton<DetermineWeatherCondition>(DetermineWeatherCondition());
}
