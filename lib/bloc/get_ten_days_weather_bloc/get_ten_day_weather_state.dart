part of 'get_ten_day_weather_bloc.dart';

sealed class GetTenDayWeatherState extends Equatable {
  const GetTenDayWeatherState();

  @override
  List<Object> get props => [];
}

class GetTenDayWeatherInitial extends GetTenDayWeatherState {}

class OnGetTenDayWeatherProgress extends GetTenDayWeatherState {}

class OnGetTenDayWeatherFailure extends GetTenDayWeatherState {
  final Object error;

  const OnGetTenDayWeatherFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class OnGetTenDayWeatherSuccess extends GetTenDayWeatherState {
  final List<String> weekDays;
  final List<String> weatherConditions;
  final List<double> temps;
  final List<double> feelsLikes;
  final List<String> weahterConImgPaths;

  const OnGetTenDayWeatherSuccess({
    required this.weekDays,
    required this.weatherConditions,
    required this.temps,
    required this.feelsLikes,
    required this.weahterConImgPaths,
  });

  @override
  List<Object> get props => [
    weekDays,
    weatherConditions,
    temps,
    feelsLikes,
    weahterConImgPaths,
  ];
}
