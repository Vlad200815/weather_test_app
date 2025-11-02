import 'package:json_annotation/json_annotation.dart';
import 'package:weather_test_app/api/models/models.dart';

part "weather_response_model.g.dart";

@JsonSerializable()
class WeatherResponseModel {
  final double latitude;
  final double longitude;
  final CurrentData current;
  final HourlyData hourly;
  final DailyData daily;

  WeatherResponseModel({
    required this.latitude,
    required this.longitude,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseModelToJson(this);
}
