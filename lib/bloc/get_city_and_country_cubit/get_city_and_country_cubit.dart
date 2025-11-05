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
    // locationCubit.stream.listen((event) async {
    //   if (event is LocationSuccess) {
    //     await getCityAndCountry();
    //   }
    // });
    getCityAndCountry();
  }

  Future<void> getCityAndCountry() async {
    emit(GetCityAndCountryProgress());
    try {
      // if (locationCubit.state is! LocationSuccess) {
      //   log("Failed the LocationCubit hasn't been loaded yet");
      //   return;
      // }
      // final position = locationCubit.state as LocationSuccess;

      final locationService = getIt<LocationService>();

      final latitude = locationService.latitude;
      final longitude = locationService.longitude;

      if (latitude == null || longitude == null) {
        log("Failed to get location");
        return;
      }

      final double lat = latitude;
      final double lon = longitude;
      // final Position position = await _locationService.determinePosition();
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
