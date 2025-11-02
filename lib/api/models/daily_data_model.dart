import 'package:json_annotation/json_annotation.dart';

part "daily_data_model.g.dart";

@JsonSerializable()
class DailyData {
  final List<String> time;
  @JsonKey(name: "weather_code")
  final List<int> weatherCode;
  final List<String> sunrise;
  final List<String> sunset;
  @JsonKey(name: "uv_index_max")
  final List<double> uvIndex;
  @JsonKey(name: "temperature_2m_max")
  final List<double> temMax;
  @JsonKey(name: "temperature_2m_min")
  final List<double> temMin;
  @JsonKey(name: "precipitation_probability_max")
  final List<int> precipitationProbability;

  DailyData({
    required this.time,
    required this.weatherCode,
    required this.sunrise,
    required this.sunset,
    required this.uvIndex,
    required this.temMax,
    required this.temMin,
    required this.precipitationProbability,
  });

  factory DailyData.fromJson(Map<String, dynamic> json) =>
      _$DailyDataFromJson(json);
  Map<String, dynamic> toJson() => _$DailyDataToJson(this);
}
