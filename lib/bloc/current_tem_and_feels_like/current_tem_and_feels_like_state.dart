part of 'current_tem_and_feels_like_bloc.dart';

sealed class CurrentTemAndFeelsLikeState extends Equatable {
  const CurrentTemAndFeelsLikeState();

  @override
  List<Object> get props => [];
}

final class CurrentTemAndFeelsLikeInitial extends CurrentTemAndFeelsLikeState {}

final class CurrentTemAndFeelsLikeProgress
    extends CurrentTemAndFeelsLikeState {}

final class CurrentTemAndFeelsLikeFailure extends CurrentTemAndFeelsLikeState {
  final Object error;

  const CurrentTemAndFeelsLikeFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class CurrentTemAndFeelsLikeSuccess extends CurrentTemAndFeelsLikeState {
  final double currentTem;
  final double feelsLike;

  const CurrentTemAndFeelsLikeSuccess({
    required this.currentTem,
    required this.feelsLike,
  });

  @override
  List<Object> get props => [currentTem, feelsLike];
}
