// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyData _$HourlyDataFromJson(Map<String, dynamic> json) => HourlyData(
  time: (json['time'] as List<dynamic>).map((e) => e as String).toList(),
  temperature: (json['temperature_2m'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  weatherCode: (json['weather_code'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  rainChanges: (json['precipitation_probability'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$HourlyDataToJson(HourlyData instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.temperature,
      'weather_code': instance.weatherCode,
      'precipitation_probability': instance.rainChanges,
    };
