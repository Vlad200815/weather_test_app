part of 'weather_api_bloc.dart';

sealed class WeatherApiEvent extends Equatable {
  const WeatherApiEvent();

  @override
  List<Object> get props => [];
}

final class OnGetWeatherEvent extends WeatherApiEvent {
  @override
  List<Object> get props => [];
}
