part of 'rain_probability_bloc.dart';

sealed class RainProbabilityEvent extends Equatable {
  const RainProbabilityEvent();

  @override
  List<Object> get props => [];
}

class OnRainProbabilityEvent extends RainProbabilityEvent {}
