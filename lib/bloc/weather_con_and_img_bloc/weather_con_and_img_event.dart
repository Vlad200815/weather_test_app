part of 'weather_con_and_img_bloc.dart';

sealed class WeatherConAndImgEvent extends Equatable {
  const WeatherConAndImgEvent();

  @override
  List<Object> get props => [];
}

class OnGetConditionAndImageWeatherEvent extends WeatherConAndImgEvent {}
