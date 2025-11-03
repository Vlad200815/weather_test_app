part of 'get_ten_day_weather_bloc.dart';

sealed class GetTenDayWeatherEvent extends Equatable {
  const GetTenDayWeatherEvent();

  @override
  List<Object> get props => [];
}

class OnGetTenDayWeatherEvent extends GetTenDayWeatherEvent {}

class OnGetTenDayWeatherProgress extends GetTenDayWeatherEvent {}

class OnGetTenDayWeatherFailure extends GetTenDayWeatherEvent {
  final Object error;

  const OnGetTenDayWeatherFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class OnGetTenDayWeatherSuccess extends GetTenDayWeatherEvent {
  final String weekDay;
  final String weatherCondition;
  final double tem;
  final double feelsLike;
  final String weahterConImgPath;

  const OnGetTenDayWeatherSuccess({
    required this.weekDay,
    required this.weatherCondition,
    required this.tem,
    required this.feelsLike,
    required this.weahterConImgPath,
  });

  @override
  List<Object> get props => [
    weekDay,
    weatherCondition,
    tem,
    feelsLike,
    weahterConImgPath,
  ];
}
