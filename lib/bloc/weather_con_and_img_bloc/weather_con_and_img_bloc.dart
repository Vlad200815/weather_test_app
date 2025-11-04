import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';
import 'package:weather_test_app/services/determine_weather_condition.dart';

part 'weather_con_and_img_event.dart';
part 'weather_con_and_img_state.dart';

class WeatherConAndImgBloc
    extends Bloc<WeatherConAndImgEvent, WeatherConAndImgState> {
  WeatherConAndImgBloc({
    required this.apiClient,
    required this.locationCubit,
    required this.determineWeatherCondition,
  }) : super(WeatherConAndImgInitial()) {
    //listen to locationCubit changes
    locationCubit.stream.listen((event) {
      if (event is LocationSuccess) {
        add(OnGetConditionAndImageWeatherEvent());
      }
    });

    on<OnGetConditionAndImageWeatherEvent>((event, emit) async {
      emit(WeatherConAndImgProgress());

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
        final int weatherCode = responseModel.current.weatherCode;

        log("Weather code is $weatherCode");

        Map<String, String> weatherConAndImg = determineWeatherCondition
            .weatherConditionDetermine(weatherCode: weatherCode);
        String weatherConditon = weatherConAndImg["weatherConditon"]!;
        String weatherConditionImgPath =
            weatherConAndImg["weatherConditionImgPath"]!;

        log(weatherConditon);
        log(weatherConditionImgPath);

        emit(
          WeatherConAndImgSuccess(
            weatherType: weatherConditon,
            weatherTypeImgPath: weatherConditionImgPath,
          ),
        );
        log("Weather conditon and img is setup successfully");
      } catch (e) {
        log(e.toString());
        emit(WeatherConAndImgFailure(error: e));
      }
    });
  }
  final WeatherApiClient apiClient;
  final LocationCubit locationCubit;
  final DetermineWeatherCondition determineWeatherCondition;
}
