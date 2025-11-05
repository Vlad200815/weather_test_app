part of 'sunrise_and_sunset_bloc.dart';

sealed class SunriseAndSunsetState extends Equatable {
  const SunriseAndSunsetState();

  @override
  List<Object> get props => [];
}

final class SunriseAndSunsetInitial extends SunriseAndSunsetState {}

final class SunriseAndSunsetProgress extends SunriseAndSunsetState {}

final class SunriseAndSunsetFailure extends SunriseAndSunsetState {
  final Object error;

  const SunriseAndSunsetFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class SunriseAndSunsetSuccess extends SunriseAndSunsetState {
  final String sunrise;
  final String sunset;

  const SunriseAndSunsetSuccess({required this.sunrise, required this.sunset});

  @override
  List<Object> get props => [sunrise, sunset];
}
