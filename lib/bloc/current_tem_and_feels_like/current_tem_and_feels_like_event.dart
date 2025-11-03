part of 'current_tem_and_feels_like_bloc.dart';

sealed class CurrentTemAndFeelsLikeEvent extends Equatable {
  const CurrentTemAndFeelsLikeEvent();

  @override
  List<Object> get props => [];
}

class OnCurrentTemAndFeelsLikeEvent extends CurrentTemAndFeelsLikeEvent {}
