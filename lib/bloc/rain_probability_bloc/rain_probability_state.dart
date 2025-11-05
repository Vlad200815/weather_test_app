part of 'rain_probability_bloc.dart';

sealed class RainProbabilityState extends Equatable {
  const RainProbabilityState();

  @override
  List<Object> get props => [];
}

final class RainProbabilityInitial extends RainProbabilityState {}

final class RainProbabilityProgress extends RainProbabilityState {}

final class RainProbabilityFailure extends RainProbabilityState {
  final Object error;

  const RainProbabilityFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class RainProbabilitySuccess extends RainProbabilityState {
  final List<String> dates;
  final List<int> percents;

  const RainProbabilitySuccess({required this.dates, required this.percents});

  @override
  List<Object> get props => [dates, percents];
}
