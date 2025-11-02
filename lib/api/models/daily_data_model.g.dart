// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyData _$DailyDataFromJson(Map<String, dynamic> json) => DailyData(
  time: (json['time'] as List<dynamic>).map((e) => e as String).toList(),
  weatherCode: (json['weather_code'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  sunrise: (json['sunrise'] as List<dynamic>).map((e) => e as String).toList(),
  sunset: (json['sunset'] as List<dynamic>).map((e) => e as String).toList(),
  uvIndex: (json['uv_index_max'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  temMax: (json['temperature_2m_max'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  temMin: (json['temperature_2m_min'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  precipitationProbability:
      (json['precipitation_probability_max'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
);

Map<String, dynamic> _$DailyDataToJson(DailyData instance) => <String, dynamic>{
  'time': instance.time,
  'weather_code': instance.weatherCode,
  'sunrise': instance.sunrise,
  'sunset': instance.sunset,
  'uv_index_max': instance.uvIndex,
  'temperature_2m_max': instance.temMax,
  'temperature_2m_min': instance.temMin,
  'precipitation_probability_max': instance.precipitationProbability,
};
