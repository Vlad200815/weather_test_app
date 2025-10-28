import 'package:json_annotation/json_annotation.dart';
import 'package:weather_test_app/api/models/models.dart';

part "weather_response_model.g.dart";

@JsonSerializable()
class WeatherResponseModel {
  final double latitude;
  final double longitude;
  final HourlyData hourly;

  WeatherResponseModel({
    required this.latitude,
    required this.longitude,
    required this.hourly,
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseModelToJson(this);
}
