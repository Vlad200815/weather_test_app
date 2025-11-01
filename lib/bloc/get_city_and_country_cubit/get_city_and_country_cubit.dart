import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/location_service.dart';

part 'get_city_and_country_state.dart';

class GetCityAndCountryCubit extends Cubit<GetCityAndCountryState> {
  final LocationService _locationService = getIt<LocationService>();

  GetCityAndCountryCubit() : super(GetCityAndCountryInitial());

  Future<void> getCityAndCountry() async {
    emit(GetCityAndCountryProgress());
    try {
      final Position position = await _locationService.determinePosition();
      final Map<String, String> location = await _locationService
          .getCityAndCountry(position: position);
      final String city = location["city"]!;
      final String country = location["country"]!;

      emit(
        GetCityAndCountrySuccess(
          city: city,
          country: country,
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } catch (e) {
      log("-------------------------------");
      log(e.toString());
      emit(GetCityAndCountryFailure(error: e));
    }
  }
}
