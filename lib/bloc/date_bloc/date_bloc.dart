import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/capitalize.dart';
import 'package:weather_test_app/services/location_service.dart';
import 'package:weather_test_app/services/weather_api_service.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  final WeatherApiService apiService;
  final LocationService locationService;
  DateBloc({required this.apiService, required this.locationService})
    : super(DateInitial()) {
    on<OnDateEvent>(_onDateEvent);
    add(OnDateEvent());
  }

  Future<void> _onDateEvent(OnDateEvent event, Emitter<DateState> emit) async {
    emit(DateProgress());
    try {
      final double lon = locationService.longitude!;
      final double lat = locationService.latitude!;

      final data = await apiService.fetchWeather(lat, lon);

      final String rawDate = data.current.time;
      DateTime dateTime = DateTime.parse(rawDate);

      String month = DateFormat("MMMM").format(dateTime);

      month = getIt<Capitalize>().capitalize(month);

      final String day = DateFormat("d").format(dateTime);
      final String time = DateFormat("HH:mm").format(dateTime);

      emit(DateSuccess(month: month, day: day, time: time));
    } catch (e) {
      log(e.toString());
      emit(DateFailure(error: e));
    }
  }
}
