import 'package:json_annotation/json_annotation.dart';

part "current_data_model.g.dart";

@JsonSerializable()
class CurrentData {
  final String time;
  @JsonKey(name: "temperature_2m")
  final double currentTem;
  @JsonKey(name: "apparent_temperature")
  final double feelsLike;
  @JsonKey(name: "wind_speed_10m")
  final double windSpeed;
  @JsonKey(name: "weather_code")
  final int weatherCode;
  @JsonKey(name: "surface_pressure")
  final double pressure;

  CurrentData({
    required this.time,
    required this.currentTem,
    required this.feelsLike,
    required this.windSpeed,
    required this.weatherCode,
    required this.pressure,
  });

  factory CurrentData.fromJson(Map<String, dynamic> json) =>
      _$CurrentDataFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentDataToJson(this);
}
