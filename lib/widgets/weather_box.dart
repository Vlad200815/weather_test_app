import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';

class WeatherBox extends StatelessWidget {
  const WeatherBox({
    super.key,
    required this.weatherImgPath,
    required this.time,
    required this.degrees,
  });

  final String weatherImgPath;
  final String time;
  final int degrees;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = getIt<Responsiveness>().scale;

    return SizedBox(
      height: 80 * scale,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: theme.textTheme.labelSmall).tr(),
          SizedBox(height: 4 * scale),
          SizedBox(
            width: 24 * scale,
            height: 32 * scale,
            child: Image.asset(
              weatherImgPath,
              filterQuality: FilterQuality.high,
            ),
          ),
          Text(
            "$degrees°",
            style: theme.textTheme.titleSmall?.copyWith(color: AppColors.black),
          ),
        ],
      ),
    );
  }
}
