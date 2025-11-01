part of 'weather_api_bloc.dart';

sealed class WeatherApiState extends Equatable {
  const WeatherApiState();

  @override
  List<Object> get props => [];
}

final class WeatherApiInitial extends WeatherApiState {}

final class GetWeatherApiProgress extends WeatherApiState {}

final class GetWeatherApiFailure extends WeatherApiState {
  final Object error;

  const GetWeatherApiFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class GetWeatherApiSuccess extends WeatherApiState {
  final WeatherResponseModel response;

  const GetWeatherApiSuccess({required this.response});

  @override
  List<Object> get props => [response];
}
