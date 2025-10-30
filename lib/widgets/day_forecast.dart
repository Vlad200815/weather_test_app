import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/responsiveness/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';

class DayForecast extends StatelessWidget {
  const DayForecast({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    final theme = Theme.of(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * scale,
        vertical: 8 * scale,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 219 * scale,
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiary,
            borderRadius: BorderRadius.circular(18 * scale),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10 * scale,
              vertical: 12 * scale,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 28 * scale,
                      width: 28 * scale,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: SvgPicture.asset("assets/icons/day_forecast.svg"),
                    ),
                    SizedBox(width: 8 * scale),
                    Text(
                      "day_forecast",
                      style: theme.textTheme.labelMedium,
                    ).tr(),
                  ],
                ),

                SizedBox(
                  height: 160 * scale,
                  child: AspectRatio(
                    aspectRatio: 1.5, // keeps chart proportional
                    child: BarChart(
                      BarChartData(
                        borderData: FlBorderData(show: true),
                        titlesData: FlTitlesData(show: false),
                        barGroups: [
                          BarChartGroupData(
                            x: 0,
                            barRods: [
                              BarChartRodData(toY: 5, color: Colors.blue),
                            ],
                          ),
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(toY: 3, color: Colors.green),
                            ],
                          ),
                          BarChartGroupData(
                            x: 2,
                            barRods: [
                              BarChartRodData(toY: 7, color: Colors.orange),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
