import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';

part 'weather_con_and_img_event.dart';
part 'weather_con_and_img_state.dart';

class WeatherConAndImgBloc
    extends Bloc<WeatherConAndImgEvent, WeatherConAndImgState> {
  WeatherConAndImgBloc({required this.apiClient, required this.locationCubit})
    : super(WeatherConAndImgInitial()) {
    //listen to locationCubit changes
    locationCubit.stream.listen((event) {
      if (event is LocationSuccess) {
        add(OnGetConditionAndImageWeatherEvent());
      }
    });

    const String clearSky = "assets/weather_types/clear_sky.png";
    const String cloudAndSun = "assets/weather_types/cloud_and_sun.png";
    const String cloudy = "assets/weather_types/cloudy.png";
    const String fog = "assets/weather_types/fog.png";
    const String rain = "assets/weather_types/rain.png";
    const String snow = "assets/weather_types/snow.png";
    const String thunder = "assets/weather_types/thunder.png";

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

        String weatherConditon = "";
        String weatherConditionImgPath = "";
        log("Weather code is $weatherCode");
        //TODO: Maybe here is the best place for localization
        if (weatherCode == 0) {
          weatherConditionImgPath = clearSky;
          weatherConditon = "Clear";
        } else if (weatherCode == 3) {
          weatherConditionImgPath = cloudy;
          weatherConditon = "Cloudy";
        } else if (weatherCode == 45 || weatherCode == 48) {
          weatherConditionImgPath = fog;
          weatherConditon = "Fog";
        } else if (weatherCode > 60 && weatherCode < 71) {
          weatherConditionImgPath = rain;
          weatherConditon = "Rain";
        } else if (weatherCode > 70 && weatherCode <= 86) {
          weatherConditionImgPath = snow;
          weatherConditon = "Snow";
        } else if (weatherCode >= 95 && weatherCode <= 99) {
          weatherConditionImgPath = thunder;
          weatherConditon = "Thunder";
        } else {
          weatherConditionImgPath = cloudAndSun;
          weatherConditon = "Cloudy";
        }

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
}
