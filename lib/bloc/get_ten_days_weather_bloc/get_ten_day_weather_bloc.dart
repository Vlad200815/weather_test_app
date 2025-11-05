import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/capitalize.dart';
import 'package:weather_test_app/services/determine_weather_condition.dart';

part 'get_ten_day_weather_event.dart';
part 'get_ten_day_weather_state.dart';

class GetTenDayWeatherBloc
    extends Bloc<GetTenDayWeatherEvent, GetTenDayWeatherState> {
  GetTenDayWeatherBloc({required this.determineWeatherCondition})
    : super(GetTenDayWeatherInitial()) {
    on<OnGetTenDayWeatherEvent>(_onGetTenDaysWeatherEvent);
    add(OnGetTenDayWeatherEvent());
  }

  Future<void> _onGetTenDaysWeatherEvent(
    OnGetTenDayWeatherEvent event,
    Emitter<GetTenDayWeatherState> emit,
  ) async {
    emit(OnGetTenDayWeatherProgress());
    try {
      final WeatherResponseModel data = getIt<WeatherResponseModel>();
      final Capitalize cap = getIt<Capitalize>();

      log("---------------------------------------");
      List<String> weekDays = data.daily.time
          .map(
            (e) => cap.capitalize(
              DateFormat("EEEE,MMMM,d").format(DateTime.parse(e)),
            ),
          )
          .toList();
      log("WeekDays: $weekDays");
      List<String> weatherConditions = data.daily.weatherCode
          .map(
            (e) => determineWeatherCondition.weatherConditionDetermine(
              weatherCode: e,
            )["weatherConditon"]!,
          )
          .toList();
      log("Weather condition: $weatherConditions");
      List<double> temps = data.daily.temMax;

      log("Temps: $temps");
      List<double> feelsLikes = data.daily.temMin;

      log("FeelsLikes: $feelsLikes");
      List<String> weatherConImgPaths = data.daily.weatherCode
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
  }

  final DetermineWeatherCondition determineWeatherCondition;
}
