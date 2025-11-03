part of 'average_day_and_night_temp_bloc.dart';

sealed class AverageDayAndNightTempEvent extends Equatable {
  const AverageDayAndNightTempEvent();

  @override
  List<Object> get props => [];
}

class OnAverageDayAndNightTempEvent extends AverageDayAndNightTempEvent {}
