import 'package:get_it/get_it.dart';
import 'package:weather_test_app/responsiveness/responsiveness.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<Responsiveness>(Responsiveness());
}
