part of 'average_day_and_night_temp_bloc.dart';

sealed class AverageDayAndNightTempState extends Equatable {
  const AverageDayAndNightTempState();

  @override
  List<Object> get props => [];
}

final class AverageDayAndNightInitial extends AverageDayAndNightTempState {}

final class AverageDayAndNightProgress extends AverageDayAndNightTempState {}

final class AverageDayAndNightFailure extends AverageDayAndNightTempState {
  final Object error;

  const AverageDayAndNightFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class AverageDayAndNightSuccess extends AverageDayAndNightTempState {
  final double averageDayTemp;
  final double averageNightTemp;

  const AverageDayAndNightSuccess({
    required this.averageDayTemp,
    required this.averageNightTemp,
  });

  @override
  List<Object> get props => [averageDayTemp, averageNightTemp];
}
