part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class LocationProgress extends LocationState {}

final class LocationFaliure extends LocationState {
  final String message;

  const LocationFaliure({required this.message});

  @override
  List<Object> get props => [message];
}

final class LocationSuccess extends LocationState {
  final double latitude;
  final double longitude;

  const LocationSuccess({required this.latitude, required this.longitude});

  @override
  List<Object> get props => [latitude, longitude];
}
