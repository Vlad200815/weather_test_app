part of 'weather_forecast_bloc.dart';

sealed class WeatherForecastState extends Equatable {
  const WeatherForecastState();
  
  @override
  List<Object> get props => [];
}

final class WeatherForecastInitial extends WeatherForecastState {}
