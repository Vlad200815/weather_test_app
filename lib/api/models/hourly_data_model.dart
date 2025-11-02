import 'package:json_annotation/json_annotation.dart';

part "hourly_data_model.g.dart";

@JsonSerializable()
class HourlyData {
  final List<String> time;
  @JsonKey(name: "temperature_2m")
  final List<double> temperature;
  @JsonKey(name: "weather_code")
  final List<int> weatherCode;

  factory HourlyData.fromJson(Map<String, dynamic> json) =>
      _$HourlyDataFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyDataToJson(this);

  HourlyData({
    required this.time,
    required this.temperature,
    required this.weatherCode,
  });
}
