import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/location_service.dart';

part 'weather_api_event.dart';
part 'weather_api_state.dart';

class WeatherApiBloc extends Bloc<WeatherApiEvent, WeatherApiState> {
  WeatherApiBloc({required this.apiClient}) : super(WeatherApiInitial()) {
    on<OnGetWeatherEvent>((event, emit) async {
      emit(GetWeatherApiProgress());
      try {
        final Position position = await _locationService.determinePosition();

        final WeatherResponseModel response = await apiClient.getWeather(
          latitude: position.latitude,
          longitude: position.longitude,
          hourly: "temperature_2m",
        );
        emit(GetWeatherApiSuccess(response: response));
      } catch (error) {
        log(error.toString());
        emit(GetWeatherApiFailure(error: error));
      }
    });
  }
  final WeatherApiClient apiClient;
  final LocationService _locationService = getIt<LocationService>();
}
