import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';

part 'average_day_and_night_temp_event.dart';
part 'average_day_and_night_temp_state.dart';

class AverageDayAndNightTempBloc
    extends Bloc<AverageDayAndNightTempEvent, AverageDayAndNightTempState> {
  AverageDayAndNightTempBloc({
    required this.apiClient,
    required this.locationCubit,
  }) : super(AverageDayAndNightInitial()) {
    locationCubit.stream.listen((event) {
      if (event is LocationSuccess) {
        add(OnAverageDayAndNightTempEvent());
      }
    });

    on<OnAverageDayAndNightTempEvent>((event, emit) async {
      emit(AverageDayAndNightProgress());
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

        final double maxDayTemp = responseModel.daily.temMax[0];
        final double minNightTemp = responseModel.daily.temMin[0];

        emit(
          AverageDayAndNightSuccess(
            averageDayTemp: maxDayTemp,
            averageNightTemp: minNightTemp,
          ),
        );
      } catch (e) {
        emit(AverageDayAndNightFailure(error: e));
        log("Error is in Max and Min bloc error is: $e");
      }
    });
  }
  final WeatherApiClient apiClient;
  final LocationCubit locationCubit;
}
