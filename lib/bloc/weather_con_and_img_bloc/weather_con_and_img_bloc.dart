import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/determine_weather_condition.dart';
import 'package:weather_test_app/services/weather_api_service.dart';

part 'weather_con_and_img_event.dart';
part 'weather_con_and_img_state.dart';

class WeatherConAndImgBloc
    extends Bloc<WeatherConAndImgEvent, WeatherConAndImgState> {
  WeatherConAndImgBloc({
    required this.apiService,
    required this.determineWeatherCondition,
  }) : super(WeatherConAndImgInitial()) {
    // //listen to locationCubit changes

    on<OnGetConditionAndImageWeatherEvent>(_onGetConditionAndImageWeatherEvent);
    add(OnGetConditionAndImageWeatherEvent());
  }

  Future<void> _onGetConditionAndImageWeatherEvent(
    OnGetConditionAndImageWeatherEvent event,
    Emitter<WeatherConAndImgState> emit,
  ) async {
    emit(WeatherConAndImgProgress());

    try {
      final WeatherResponseModel data = getIt<WeatherResponseModel>();
      final int weatherCode = data.current.weatherCode;

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
  }

  final WeatherApiService apiService;
  final DetermineWeatherCondition determineWeatherCondition;
}
