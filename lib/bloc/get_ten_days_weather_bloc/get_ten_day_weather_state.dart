part of 'get_ten_day_weather_bloc.dart';

sealed class GetTenDayWeatherState extends Equatable {
  const GetTenDayWeatherState();
  
  @override
  List<Object> get props => [];
}

final class GetTenDayWeatherInitial extends GetTenDayWeatherState {}
