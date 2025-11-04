import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';

class WeatherApiService {
  final WeatherApiClient apiClient;

  WeatherApiService({required this.apiClient});

  WeatherResponseModel? _cachaedWeather;

  Future<WeatherResponseModel> fetchWeather(double lat, double lon) async {
    if (_cachaedWeather != null) {
      return _cachaedWeather!;
    }

    final response = await apiClient.getWeather(latitude: lat, longitude: lon);
    _cachaedWeather = response;
    return response;
  }

  void clearCache() {
    _cachaedWeather = null;
  }
}
