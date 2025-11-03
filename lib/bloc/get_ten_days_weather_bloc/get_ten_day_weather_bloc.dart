import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';

part 'get_ten_day_weather_event.dart';
part 'get_ten_day_weather_state.dart';

class GetTenDayWeatherBloc
    extends Bloc<GetTenDayWeatherEvent, GetTenDayWeatherState> {
  GetTenDayWeatherBloc({required this.apiClient, required this.locationCubit})
    : super(GetTenDayWeatherInitial()) {
    //listen to locationCubit changes
    //TODO: check if it takes a lot of time to load in the start
    locationCubit.stream.listen((event) {
      if (event is LocationSuccess) {
        add(OnGetTenDayWeatherEvent());
      }
    });

    on<OnGetTenDayWeatherEvent>((event, emit) async {
      emit(OnGetTenDayWeatherProgress());
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
          // current: "temperature_2m,weather_code",
        );

        //TODO: work is here already have weeksDays but don't want to repeat yourself
        //TODO: so try to make it as a sevice!!!
        //TODO: this bloc is for the ten days screen!!!
        // List<String> weekDays = responseModel.daily.time
        //     .map((e) => capitalize(DateFormat("EEEE").format(DateTime.parse(e))))
        //     .toList();
        // List<String>

        // emit(
        //   OnGetTenDayWeatherSuccess(
        //     weekDays: weekDays,
        //     weatherConditions: weatherCondition,
        //     tems: tem,
        //     feelsLikes: feelsLike,
        //     weahterConImgPaths: weahterConImgPath,
        //   ),
        // );
      } catch (e) {
        log(e.toString());
        emit(OnGetTenDayWeatherFailure(error: e));
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
