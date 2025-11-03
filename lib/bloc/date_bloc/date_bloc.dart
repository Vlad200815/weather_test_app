import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc({required this.apiClient, required this.locationCubit})
    : super(DateInitial()) {
    locationCubit.stream.listen((event) {
      if (event is LocationSuccess) {
        add(OnDateEvent());
      }
    });

    on<OnDateEvent>((event, emit) async {
      emit(DateProgress());
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
        );

        final String rawDate = responseModel.current.time;
        DateTime dateTime = DateTime.parse(rawDate);

        String month = DateFormat("MMMM").format(dateTime);

        month = capitalize(month);

        final String day = DateFormat("d").format(dateTime);
        final String time = DateFormat("HH:mm").format(dateTime);

        emit(DateSuccess(month: month, day: day, time: time));
      } catch (e) {
        log(e.toString());
        emit(DateFailure(error: e));
      }
    });
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  final WeatherApiClient apiClient;
  final LocationCubit locationCubit;
}
