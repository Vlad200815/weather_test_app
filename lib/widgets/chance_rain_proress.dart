import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/responsiveness/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';

class ChanceRainProress extends StatelessWidget {
  const ChanceRainProress({
    super.key,
    required this.date,
    required this.percent,
    required this.progress,
  });

  final String date;
  final double progress;
  final int percent;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10 * scale,
        vertical: 6 * scale,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: theme.textTheme.labelLarge?.copyWith(fontSize: 15)),
          LinearPercentIndicator(
            width: 229 * scale,
            lineHeight: 24,
            barRadius: Radius.circular(100 * scale),
            percent: progress,
            backgroundColor: AppColors.progressBarUnfilledColor,
            progressColor: theme.colorScheme.primary,
          ),
          Text(
            "$percent%",
            style: theme.textTheme.labelLarge?.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
