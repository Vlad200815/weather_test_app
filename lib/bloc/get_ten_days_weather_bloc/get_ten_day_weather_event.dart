part of 'get_ten_day_weather_bloc.dart';

sealed class GetTenDayWeatherEvent extends Equatable {
  const GetTenDayWeatherEvent();

  @override
  List<Object> get props => [];
}

class OnGetTenDayWeatherEvent extends GetTenDayWeatherEvent {}

