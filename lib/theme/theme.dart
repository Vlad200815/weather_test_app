import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  textTheme: TextTheme(
    displayLarge: GoogleFonts.ptSans(
      fontSize: FontSizes._displayLargeFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
    displayMedium: GoogleFonts.roboto(
      fontSize: FontSizes._displayMediumFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
  ),
);

class FontSizes {
  static const double _displayLargeFontSize = 112;
  static const double _displayMediumFontSize = 57;
  static const double _titileLargeFontSize = 22;
  static const double _titleMediumFontSize = 18.8;
  static const double _titleSmallFontSize = 18;
  static const double _labelLargeFontSize = 15;
  static const double _labelMediumFontSize = 14;
  static const double _labelSmallFontSize = 11;
  static const double _labelMicroFontSize = 10;
}
