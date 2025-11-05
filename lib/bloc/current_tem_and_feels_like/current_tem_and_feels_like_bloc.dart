import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/di/di.dart';

part 'current_tem_and_feels_like_event.dart';
part 'current_tem_and_feels_like_state.dart';

class CurrentTemAndFeelsLikeBloc
    extends Bloc<CurrentTemAndFeelsLikeEvent, CurrentTemAndFeelsLikeState> {
  CurrentTemAndFeelsLikeBloc() : super(CurrentTemAndFeelsLikeInitial()) {
    on<OnCurrentTemAndFeelsLikeEvent>(_onCurrentTemAndFeelsLikeBloc);
    add(OnCurrentTemAndFeelsLikeEvent());
  }

  Future<void> _onCurrentTemAndFeelsLikeBloc(
    OnCurrentTemAndFeelsLikeEvent event,
    Emitter<CurrentTemAndFeelsLikeState> emit,
  ) async {
    emit(CurrentTemAndFeelsLikeProgress());
    try {
      final WeatherResponseModel data = getIt<WeatherResponseModel>();
      final double currentTem = data.current.currentTem;
      final double feelsLikeTem = data.current.feelsLike;

      emit(
        CurrentTemAndFeelsLikeSuccess(
          currentTem: currentTem,
          feelsLike: feelsLikeTem,
        ),
      );
      log("Current tem and feels like bloc is loaded");
    } catch (e) {
      log(e.toString());
      emit(CurrentTemAndFeelsLikeFailure(error: e));
    }
  }
}
