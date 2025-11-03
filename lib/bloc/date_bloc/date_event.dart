part of 'date_bloc.dart';

sealed class DateEvent extends Equatable {
  const DateEvent();

  @override
  List<Object> get props => [];
}

class OnDateEvent extends DateEvent {}
