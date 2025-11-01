import 'package:get_it/get_it.dart';
import 'package:weather_test_app/services/location_service.dart';
import 'package:weather_test_app/services/responsiveness.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<Responsiveness>(Responsiveness());
  getIt.registerLazySingleton<LocationService>(() => LocationService());
}
