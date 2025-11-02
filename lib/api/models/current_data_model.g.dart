// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentData _$CurrentDataFromJson(Map<String, dynamic> json) => CurrentData(
  time: json['time'] as String,
  currentTem: (json['temperature_2m'] as num).toDouble(),
  feelsLike: (json['apparent_temperature'] as num).toDouble(),
  windSpeed: (json['wind_speed_10m'] as num).toDouble(),
  weatherCode: (json['weather_code'] as num).toInt(),
  pressure: (json['surface_pressure'] as num).toDouble(),
);

Map<String, dynamic> _$CurrentDataToJson(CurrentData instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.currentTem,
      'apparent_temperature': instance.feelsLike,
      'wind_speed_10m': instance.windSpeed,
      'weather_code': instance.weatherCode,
      'surface_pressure': instance.pressure,
    };
