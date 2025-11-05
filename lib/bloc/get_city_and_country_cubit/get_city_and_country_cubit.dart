import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/location_service.dart';

part 'get_city_and_country_state.dart';

class GetCityAndCountryCubit extends Cubit<GetCityAndCountryState> {
  final LocationCubit locationCubit;
  final LocationService locationService;

  GetCityAndCountryCubit({
    required this.locationCubit,
    required this.locationService,
  }) : super(GetCityAndCountryInitial()) {
    getCityAndCountry();
  }

  Future<void> getCityAndCountry() async {
    emit(GetCityAndCountryProgress());
    try {
      final locationService = getIt<LocationService>();

      final latitude = locationService.latitude;
      final longitude = locationService.longitude;

      if (latitude == null || longitude == null) {
        log("Failed to get location");
        return;
      }

      final double lat = latitude;
      final double lon = longitude;

      final Map<String, String> location = await locationService
          .getCityAndCountry(latitude: lat, longitude: lon);
      final String city = location["city"]!;
      final String country = location["country"]!;

      emit(
        GetCityAndCountrySuccess(
          city: city,
          country: country,
          latitude: lat,
          longitude: lon,
        ),
      );
      log("Got city and country");
    } catch (e) {
      log("-------------------------------");
      log(e.toString());
      emit(GetCityAndCountryFailure(error: e));
    }
  }
}
