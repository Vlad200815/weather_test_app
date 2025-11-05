part of 'weather_forecast_bloc.dart';

sealed class WeatherForecastState extends Equatable {
  const WeatherForecastState();

  @override
  List<Object> get props => [];
}

final class WeatherForecastInitial extends WeatherForecastState {}

final class WeatherForecastProgress extends WeatherForecastState {}

final class WeatherForecastFailure extends WeatherForecastState {
  final Object error;

  const WeatherForecastFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class WeatherForecastSuccess extends WeatherForecastState {
  final List<String> times;
  final List<String> weatherConImgPaths;
  final List<int> temps;

  const WeatherForecastSuccess({
    required this.times,
    required this.weatherConImgPaths,
    required this.temps,
  });
}
