import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';

part 'current_tem_and_feels_like_event.dart';
part 'current_tem_and_feels_like_state.dart';

class CurrentTemAndFeelsLikeBloc
    extends Bloc<CurrentTemAndFeelsLikeEvent, CurrentTemAndFeelsLikeState> {
  CurrentTemAndFeelsLikeBloc({
    required this.apiClient,
    required this.locationCubit,
  }) : super(CurrentTemAndFeelsLikeInitial()) {
    locationCubit.stream.listen((event) {
      if (event is LocationSuccess) {
        add(OnCurrentTemAndFeelsLikeEvent());
      }
    });

    on<OnCurrentTemAndFeelsLikeEvent>((event, emit) async {
      emit(CurrentTemAndFeelsLikeProgress());
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
        final double currentTem = responseModel.current.currentTem;
        final double feelsLikeTem = responseModel.current.feelsLike;

        emit(
          CurrentTemAndFeelsLikeSuccess(
            currentTem: currentTem,
            feelsLike: feelsLikeTem,
          ),
        );
        log("Current tem and feels like bloc is loaded");
      } catch (e) {
        log(e.toString());
        emit(CurrentTemAndFeelsLikeFailure(error: e));
      }
    });
  }
  final WeatherApiClient apiClient;
  final LocationCubit locationCubit;
}
