import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';

part 'api.g.dart';

@RestApi(baseUrl: "")
abstract class WeatherApiClient {
  factory WeatherApiClient(Dio dio, {String? baseUrl}) = _WeatherApiClient;

  // factory WeatherApiClient.create({String? apiUrl}) {
  //   final dio = Dio();
  //   if (apiUrl != null) {
  //     return WeatherApiClient(dio, baseUrl: apiUrl);
  //   }
  //   return WeatherApiClient(dio);
  // }

  @GET('forecast')
  Future<WeatherResponseModel> getWeather({
    @Query("latitude") required double latitude,
    @Query("longitude") required double longitude,
    @Query("daily")
    String daily =
        "weather_code,sunrise,sunset,uv_index_max,temperature_2m_max,temperature_2m_min,precipitation_probability_max",
    @Query("hourly") String hourly = "temperature_2m,weather_code",
    @Query("current")
    String current =
        "temperature_2m,apparent_temperature,wind_speed_10m,weather_code,surface_pressure",
    @Query("timezone") String timezone = "auto",
    @Query("forecast_days") int forecastDays = 14,
  });
}
