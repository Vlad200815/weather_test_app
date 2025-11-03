import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'weather_forecast_event.dart';
part 'weather_forecast_state.dart';

class WeatherForecastBloc extends Bloc<WeatherForecastEvent, WeatherForecastState> {
  WeatherForecastBloc() : super(WeatherForecastInitial()) {
    on<WeatherForecastEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
