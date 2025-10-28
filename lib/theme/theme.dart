import 'package:flutter/material.dart';
import 'package:weather_test_app/theme/app_colors.dart';

final myTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.purple,
    primary: AppColors.purple,
    surface: AppColors.ultraLightPurle,
    secondary: AppColors.purple30,
    tertiary: AppColors.purple80,
    error: AppColors.red,

    brightness: Brightness.light,
  ),
);

class FontStyles {
  static const double _extremeLargeFontSize = 112;
  static const double _superLargeFontSize = 57;
  static const double _largeFontSize = 22;
  static const double _megaMediumFontSize = 18;
  static const double _degreesFontSize = 18.8;
  static const double _mediumFontSize = 16;
  // static const double _
}
