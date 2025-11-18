// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/day_forecast.svg
  String get dayForecast => 'assets/icons/day_forecast.svg';

  /// File path: assets/icons/hourly_forecast.svg
  String get hourlyForecast => 'assets/icons/hourly_forecast.svg';

  /// File path: assets/icons/pressure.svg
  String get pressure => 'assets/icons/pressure.svg';

  /// File path: assets/icons/rain_chance.svg
  String get rainChance => 'assets/icons/rain_chance.svg';

  /// File path: assets/icons/sunrise.svg
  String get sunrise => 'assets/icons/sunrise.svg';

  /// File path: assets/icons/sunset.svg
  String get sunset => 'assets/icons/sunset.svg';

  /// File path: assets/icons/uv_index.svg
  String get uvIndex => 'assets/icons/uv_index.svg';

  /// File path: assets/icons/wind_speed.svg
  String get windSpeed => 'assets/icons/wind_speed.svg';

  /// List of all assets
  List<String> get values => [
    dayForecast,
    hourlyForecast,
    pressure,
    rainChance,
    sunrise,
    sunset,
    uvIndex,
    windSpeed,
  ];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en-US.json
  String get enUS => 'assets/translations/en-US.json';

  /// File path: assets/translations/uk-UA.json
  String get ukUA => 'assets/translations/uk-UA.json';

  /// List of all assets
  List<String> get values => [enUS, ukUA];
}

class $AssetsWeatherTypesGen {
  const $AssetsWeatherTypesGen();

  /// File path: assets/weather_types/clear_sky.png
  AssetGenImage get clearSky =>
      const AssetGenImage('assets/weather_types/clear_sky.png');

  /// File path: assets/weather_types/cloud_and_sun.png
  AssetGenImage get cloudAndSun =>
      const AssetGenImage('assets/weather_types/cloud_and_sun.png');

  /// File path: assets/weather_types/cloudy.png
  AssetGenImage get cloudy =>
      const AssetGenImage('assets/weather_types/cloudy.png');

  /// File path: assets/weather_types/fog.png
  AssetGenImage get fog => const AssetGenImage('assets/weather_types/fog.png');

  /// File path: assets/weather_types/rain.png
  AssetGenImage get rain =>
      const AssetGenImage('assets/weather_types/rain.png');

  /// File path: assets/weather_types/snow.png
  AssetGenImage get snow =>
      const AssetGenImage('assets/weather_types/snow.png');

  /// File path: assets/weather_types/thunder.png
  AssetGenImage get thunder =>
      const AssetGenImage('assets/weather_types/thunder.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    clearSky,
    cloudAndSun,
    cloudy,
    fog,
    rain,
    snow,
    thunder,
  ];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const String arrowDropDown = 'assets/arrow_drop_down.svg';
  static const String arrowDropUp = 'assets/arrow_drop_up.svg';
  static const String divider = 'assets/divider.svg';
  static const String expandMore = 'assets/expand_more.svg';
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const AssetGenImage poster = AssetGenImage('assets/poster.png');
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
  static const $AssetsWeatherTypesGen weatherTypes = $AssetsWeatherTypesGen();

  /// List of all assets
  static List<dynamic> get values => [
    aEnv,
    arrowDropDown,
    arrowDropUp,
    divider,
    expandMore,
    poster,
  ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
