part of 'get_info_boxes_data_bloc.dart';

sealed class GetInfoBoxesDataState extends Equatable {
  const GetInfoBoxesDataState();

  @override
  List<Object> get props => [];
}

final class GetInfoBoxesDataInitial extends GetInfoBoxesDataState {}

final class GetInfoBoxesDataProgress extends GetInfoBoxesDataState {}

final class GetInfoBoxesDataFailure extends GetInfoBoxesDataState {
  final Object error;

  const GetInfoBoxesDataFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class GetInfoBoxesDataSuccess extends GetInfoBoxesDataState {
  final double windSpeed;
  final double pressure;
  final double precipitaion;
  final double uvIndex;

  const GetInfoBoxesDataSuccess({
    required this.windSpeed,
    required this.pressure,
    required this.precipitaion,
    required this.uvIndex,
  });

  @override
  List<Object> get props => [windSpeed, pressure, precipitaion, uvIndex];
}
