part of 'date_bloc.dart';

sealed class DateState extends Equatable {
  const DateState();

  @override
  List<Object> get props => [];
}

final class DateInitial extends DateState {}

final class DateProgress extends DateState {}

final class DateFailure extends DateState {
  final Object error;

  const DateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class DateSuccess extends DateState {
  final String month;
  final String day;
  final String time;

  const DateSuccess({
    required this.month,
    required this.day,
    required this.time,
  });

  @override
  List<Object> get props => [month, day, time];
}
