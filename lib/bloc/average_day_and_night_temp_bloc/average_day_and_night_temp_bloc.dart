import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/di/di.dart';

part 'average_day_and_night_temp_event.dart';
part 'average_day_and_night_temp_state.dart';

class AverageDayAndNightTempBloc
    extends Bloc<AverageDayAndNightTempEvent, AverageDayAndNightTempState> {
  AverageDayAndNightTempBloc() : super(AverageDayAndNightInitial()) {
    on<OnAverageDayAndNightTempEvent>(_onAverageDayAndNightTempEvent);
    add(OnAverageDayAndNightTempEvent());
  }

  Future<void> _onAverageDayAndNightTempEvent(
    OnAverageDayAndNightTempEvent event,
    Emitter<AverageDayAndNightTempState> emit,
  ) async {
    emit(AverageDayAndNightProgress());
    try {
      final WeatherResponseModel data = getIt<WeatherResponseModel>();

      final double maxDayTemp = data.daily.temMax[0];
      final double minNightTemp = data.daily.temMin[0];

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
  }
}
