import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_test_app/theme/app_colors.dart';

final myTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.purple,
    primary: AppColors.purple,
    surface: AppColors.ultraLightPurle,
    secondary: AppColors.purple80,
    tertiary: AppColors.purple30,
    error: AppColors.red,

    brightness: Brightness.light,
  ),

  textTheme: TextTheme(
    displayLarge: GoogleFonts.robotoCondensed(
      fontSize: FontSizes._displayLargeFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
    displayMedium: GoogleFonts.roboto(
      fontSize: FontSizes._displayMediumFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: FontSizes._titileLargeFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: FontSizes._titleMediumFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: FontSizes._titleSmallFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
    labelLarge: GoogleFonts.roboto(
      fontSize: FontSizes._labelLargeFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    labelMedium: GoogleFonts.roboto(
      fontSize: FontSizes._labelMediumFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    labelSmall: GoogleFonts.roboto(
      fontSize: FontSizes._labelSmallFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
  ),
);

class FontSizes {
  //TODO: I decreeced the fontSize to 100 because this is another font not
  //TODO: Product Sans but Roboto so I did that to adjust the situation
  // static const double _displayLargeFontSize = 112;
  static const double _displayLargeFontSize = 100;

  static const double _displayMediumFontSize = 57;
  static const double _titileLargeFontSize = 22;
  static const double _titleMediumFontSize = 18.8;
  static const double _titleSmallFontSize = 18;
  static const double _labelLargeFontSize = 16;
  static const double _labelMediumFontSize = 12;
  static const double _labelSmallFontSize = 11;
  static const double _labelMicroFontSize = 10;
}
