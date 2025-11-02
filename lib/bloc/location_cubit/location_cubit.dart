import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/services/location_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required this.locationService}) : super(LocationInitial());

  final LocationService locationService;

  Future<void> loadLocation() async {
    emit(LocationProgress());
    try {
      await locationService.determinePosition();
      emit(
        LocationSuccess(
          latitude: locationService.latitude!,
          longitude: locationService.longitude!,
        ),
      );
      log("Location is loaded");
    } catch (e) {
      log("Error is: ${e.toString()}");
      emit(LocationFaliure(message: e.toString()));
    }
  }
}
