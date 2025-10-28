import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';

part 'api.g.dart';

@RestApi(baseUrl: "")
abstract class WeatherApiClient {
  factory WeatherApiClient(Dio dio, {String? baseUrl}) = _WeatherApiClient;

  factory WeatherApiClient.create({String? apiUrl}) {
    final dio = Dio();
    if (apiUrl != null) {
      return WeatherApiClient(dio, baseUrl: apiUrl);
    }
    return WeatherApiClient(dio);
  }

  @GET('forecast')
  Future<WeatherResponseModel> getWeather({
    @Query("latitude") required double latitude,
    @Query("longitude") required double longitude,
    @Query("hourly") required String hourly,
  });
}
