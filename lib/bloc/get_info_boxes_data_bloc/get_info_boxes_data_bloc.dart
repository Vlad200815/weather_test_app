import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/di/di.dart';

part 'get_info_boxes_data_event.dart';
part 'get_info_boxes_data_state.dart';

class GetInfoBoxesDataBloc
    extends Bloc<GetInfoBoxesDataEvent, GetInfoBoxesDataState> {
  GetInfoBoxesDataBloc() : super(GetInfoBoxesDataInitial()) {
    on<OnGetInfroBoxesDateEvent>(_onGetInfoBoxesDateEvent);
    add(OnGetInfroBoxesDateEvent());
  }

  Future<void> _onGetInfoBoxesDateEvent(
    OnGetInfroBoxesDateEvent event,
    Emitter<GetInfoBoxesDataState> emit,
  ) async {
    emit(GetInfoBoxesDataProgress());
    try {
      final WeatherResponseModel data = getIt<WeatherResponseModel>();

      final double windSpeed = data.current.windSpeed;
      final double pressure = data.current.pressure;
      final double percipitaion = data.daily.precipitationProbability[0]
          .toDouble();
      final double uvIndex = data.daily.uvIndex[0];

      emit(
        GetInfoBoxesDataSuccess(
          windSpeed: windSpeed,
          pressure: pressure,
          precipitaion: percipitaion,
          uvIndex: uvIndex,
        ),
      );
    } catch (e) {
      log("Eror is $e");
      emit(GetInfoBoxesDataFailure(error: e));
    }
  }
}
