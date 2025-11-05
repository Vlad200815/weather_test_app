import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/di/di.dart';

part 'rain_probability_event.dart';
part 'rain_probability_state.dart';

class RainProbabilityBloc
    extends Bloc<RainProbabilityEvent, RainProbabilityState> {
  RainProbabilityBloc() : super(RainProbabilityInitial()) {
    on<OnRainProbabilityEvent>(_onRainProbabilityEvent);
    add(OnRainProbabilityEvent());
  }

  Future<void> _onRainProbabilityEvent(
    OnRainProbabilityEvent event,
    Emitter<RainProbabilityState> emit,
  ) async {
    emit(RainProbabilityProgress());
    try {
      final WeatherResponseModel data = getIt<WeatherResponseModel>();
      final currentTime = DateTime.parse(data.current.time);
      final hourlyTimes = data.hourly.time
          .map((e) => DateTime.parse(e))
          .toList();
      final List<int> probabilities = data.hourly.rainChanges;

      //find current hour or closest
      final index = hourlyTimes.indexWhere(
        (e) => (e.difference(currentTime).inMinutes.abs() < 30),
      );

      final convertedTimes = hourlyTimes
          .map((e) => DateFormat("HH:mm").format(e))
          .toList();

      List<int> next4Hours = [];
      List<String> dates = [];

      if (index != -1) {
        next4Hours = probabilities.skip(index).take(4).toList();
        dates = convertedTimes.skip(index).take(4).toList();
        log("Next 4 hours probabilites: $next4Hours, and dates: $dates");
      } else {
        log("Current hour not found in hourly data");
      }

      emit(RainProbabilitySuccess(dates: dates, percents: next4Hours));
    } catch (e) {
      log(e.toString());
      emit(RainProbabilityFailure(error: e));
    }
  }
}
