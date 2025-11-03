import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';

part 'get_info_boxes_data_event.dart';
part 'get_info_boxes_data_state.dart';

class GetInfoBoxesDataBloc
    extends Bloc<GetInfoBoxesDataEvent, GetInfoBoxesDataState> {
  GetInfoBoxesDataBloc({required this.apiClient, required this.locationCubit})
    : super(GetInfoBoxesDataInitial()) {
    locationCubit.stream.listen((event) {
      if (event is LocationSuccess) {
        add(OnGetInfroBoxesDateEvent());
      }
    });

    on<OnGetInfroBoxesDateEvent>((event, emit) async {
      emit(GetInfoBoxesDataProgress());
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

        final double windSpeed = responseModel.current.windSpeed;
        final double pressure = responseModel.current.pressure;
        final double percipitaion = responseModel
            .daily
            .precipitationProbability[0]
            .toDouble();
        final double uvIndex = responseModel.daily.uvIndex[0];

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
    });
  }
  final WeatherApiClient apiClient;
  final LocationCubit locationCubit;
}
