part of 'weather_con_and_img_bloc.dart';

sealed class WeatherConAndImgState extends Equatable {
  const WeatherConAndImgState();

  @override
  List<Object> get props => [];
}

final class WeatherConAndImgInitial extends WeatherConAndImgState {}

final class WeatherConAndImgProgress extends WeatherConAndImgState {}

final class WeatherConAndImgFailure extends WeatherConAndImgState {
  final Object error;

  const WeatherConAndImgFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class WeatherConAndImgSuccess extends WeatherConAndImgState {
  final String weatherType;
  final String weatherTypeImgPath;

  const WeatherConAndImgSuccess({
    required this.weatherType,
    required this.weatherTypeImgPath,
  });

  @override
  List<Object> get props => [weatherType, weatherTypeImgPath];
}
