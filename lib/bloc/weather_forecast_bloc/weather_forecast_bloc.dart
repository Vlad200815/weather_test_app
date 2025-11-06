import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/bloc/weather_con_and_img_bloc/weather_con_and_img_bloc.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/determine_weather_condition.dart';

part 'weather_forecast_event.dart';
part 'weather_forecast_state.dart';

class WeatherForecastBloc
    extends Bloc<WeatherForecastEvent, WeatherForecastState> {
  WeatherForecastBloc({required this.determineWeatherCondition})
    : super(WeatherForecastInitial()) {
    on<OnWeatherForecastEvent>(_onWeatherForecastEvent);
    add(OnWeatherForecastEvent());
  }

  Future<void> _onWeatherForecastEvent(
    OnWeatherForecastEvent event,
    Emitter<WeatherForecastState> emit,
  ) async {
    emit(WeatherForecastProgress());
    try {
      final WeatherResponseModel data = getIt<WeatherResponseModel>();

      final currentTime = DateTime.parse(data.current.time);
      final hourlyTimes = data.hourly.time
          .map((e) => DateTime.parse(e))
          .toList();
      //find current hour or closest
      final index = hourlyTimes.indexWhere(
        (e) => (e.difference(currentTime).inMinutes.abs() < 60),
      );

      final convertedTimes = hourlyTimes
          .map((e) => DateFormat("HH:mm").format(e))
          .toList();

      List<int> temps = data.hourly.temperature.map((e) => e.toInt()).toList();
      List<String> dates = [];
      log("dates: $dates");
      List<String> weatherConImgPaths = data.hourly.weatherCode
          .map(
            (e) => determineWeatherCondition.weatherConditionDetermine(
              weatherCode: e,
            )["weatherConditionImgPath"]!,
          )
          .toList();

      if (index != -1) {
        dates = convertedTimes.skip(index).take(6).toList();
        temps = temps.skip(index).take(6).toList();
        weatherConImgPaths = weatherConImgPaths.skip(index).take(6).toList();

        log(
          "Dates: $dates, weatherConImgPaths: $weatherConImgPaths, temps: $temps",
        );
      } else {
        // fallback to first 6 entries if current hour not found
        dates = convertedTimes.take(6).toList();
        temps = temps.take(6).toList();
        weatherConImgPaths = weatherConImgPaths.take(6).toList();
        log("Current hour not found in hourly data");
      }

      emit(
        WeatherForecastSuccess(
          times: dates,
          weatherConImgPaths: weatherConImgPaths,
          temps: temps,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(WeatherForecastFailure(error: e));
    }
  }

  final DetermineWeatherCondition determineWeatherCondition;
}
