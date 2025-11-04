import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';
import 'package:weather_test_app/services/determine_weather_condition.dart';

part 'get_ten_day_weather_event.dart';
part 'get_ten_day_weather_state.dart';

class GetTenDayWeatherBloc
    extends Bloc<GetTenDayWeatherEvent, GetTenDayWeatherState> {
  GetTenDayWeatherBloc({
    required this.apiClient,
    required this.locationCubit,
    required this.determineWeatherCondition,
  }) : super(GetTenDayWeatherInitial()) {
    //listen to locationCubit changes
    //TODO: check if it takes a lot of time to load in the start
    locationCubit.stream.listen((event) {
      if (event is LocationSuccess) {
        add(OnGetTenDayWeatherEvent());
      }
    });

    on<OnGetTenDayWeatherEvent>((event, emit) async {
      emit(OnGetTenDayWeatherProgress());
      try {
        if (locationCubit.state is! LocationSuccess) {
          log("Failed the LocationCubit hasn't been loaded yet");
          return;
        }

        final location = locationCubit.state as LocationSuccess;

        final double lon = location.longitude;
        final double lat = location.latitude;

        final WeatherResponseModel responseModel = await apiClient.getWeather(
          latitude: lat,
          longitude: lon,
          // current: "temperature_2m,weather_code",
        );

        log("---------------------------------------");
        List<String> weekDays = responseModel.daily.time
            .map(
              (e) => capitalize(
                DateFormat("EEEE,MMMM,d").format(DateTime.parse(e)),
              ),
            )
            .toList();
        log("WeekDays: $weekDays");
        List<String> weatherConditions = responseModel.daily.weatherCode
            .map(
              (e) => determineWeatherCondition.weatherConditionDetermine(
                weatherCode: e,
              )["weatherConditon"]!,
            )
            .toList();
        log("Weather condition: $weatherConditions");
        List<double> temps = responseModel.daily.temMax;

        log("Temps: $temps");
        List<double> feelsLikes = responseModel.daily.temMin;

        log("FeelsLikes: $feelsLikes");
        List<String> weatherConImgPaths = responseModel.daily.weatherCode
            .map(
              (e) => determineWeatherCondition.weatherConditionDetermine(
                weatherCode: e,
              )["weatherConditionImgPath"]!,
            )
            .toList();
        log("WeatherConImgPath $weatherConImgPaths");
        log("---------------------------------------");

        emit(
          OnGetTenDayWeatherSuccess(
            weekDays: weekDays,
            weatherConditions: weatherConditions,
            temps: temps,
            feelsLikes: feelsLikes,
            weahterConImgPaths: weatherConImgPaths,
          ),
        );
      } catch (e) {
        log(e.toString());
        emit(OnGetTenDayWeatherFailure(error: e));
      }
    });
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  final WeatherApiClient apiClient;
  final LocationCubit locationCubit;
  final DetermineWeatherCondition determineWeatherCondition;
}
