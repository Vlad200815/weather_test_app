import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/di/di.dart';

part 'sunrise_and_sunset_event.dart';
part 'sunrise_and_sunset_state.dart';

class SunriseAndSunsetBloc
    extends Bloc<SunriseAndSunsetEvent, SunriseAndSunsetState> {
  SunriseAndSunsetBloc() : super(SunriseAndSunsetInitial()) {
    on<OnSunriseAndSunsetEvent>(_onSunriseAndSunsetEvent);
    add(OnSunriseAndSunsetEvent());
  }

  Future<void> _onSunriseAndSunsetEvent(
    OnSunriseAndSunsetEvent event,
    Emitter<SunriseAndSunsetState> emit,
  ) async {
    emit(SunriseAndSunsetProgress());
    try {
      final WeatherResponseModel data = getIt<WeatherResponseModel>();

      final String sunrise = DateFormat(
        "HH:mm",
      ).format(DateTime.parse(data.daily.sunrise[0]));
      final String sunset = DateFormat(
        "HH:mm",
      ).format(DateTime.parse(data.daily.sunset[0]));

      emit(SunriseAndSunsetSuccess(sunrise: sunrise, sunset: sunset));
    } catch (e) {
      log(e.toString());
      emit(SunriseAndSunsetFailure(error: e));
    }
  }
}
