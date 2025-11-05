part of 'sunrise_and_sunset_bloc.dart';

sealed class SunriseAndSunsetEvent extends Equatable {
  const SunriseAndSunsetEvent();

  @override
  List<Object> get props => [];
}

class OnSunriseAndSunsetEvent extends SunriseAndSunsetEvent {}
