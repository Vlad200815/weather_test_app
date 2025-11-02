// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponseModel _$WeatherResponseModelFromJson(
  Map<String, dynamic> json,
) => WeatherResponseModel(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  current: CurrentData.fromJson(json['current'] as Map<String, dynamic>),
  hourly: HourlyData.fromJson(json['hourly'] as Map<String, dynamic>),
  daily: DailyData.fromJson(json['daily'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WeatherResponseModelToJson(
  WeatherResponseModel instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'current': instance.current,
  'hourly': instance.hourly,
  'daily': instance.daily,
};
