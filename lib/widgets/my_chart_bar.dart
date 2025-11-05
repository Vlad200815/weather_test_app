import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';

class MyChartLine extends StatefulWidget {
  const MyChartLine({super.key});

  @override
  State<MyChartLine> createState() => _MyChartLineState();
}

class _MyChartLineState extends State<MyChartLine> {
  int todayIndex = DateTime.now().weekday - 1; // 0 = Mon, 6 = Sun
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    final theme = Theme.of(context);

    const spots = [
      FlSpot(0, 0),
      FlSpot(1, -2),
      FlSpot(2, 1),
      FlSpot(3, 3),
      FlSpot(4, 0),
      FlSpot(5, -1),
      FlSpot(6, 1),
    ];

    const todayIndex = 3;

    return Padding(
      padding: EdgeInsets.only(left: 10 * scale, right: 10 * scale),
      child: SizedBox(
        height: 140 * scale,
        width: 377 * scale,
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 6,
            minY: -10,
            maxY: 10,
            clipData: FlClipData.all(),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              horizontalInterval: 9.9,
              getDrawingHorizontalLine: (value) => FlLine(
                color: AppColors.black.withOpacity(0.1),
                strokeWidth: 2.5,
              ),
              drawVerticalLine: false,
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30 * scale,
                  getTitlesWidget: (value, meta) {
                    const days = [
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat',
                      'Sun',
                    ];
                    if (value < 0 || value >= days.length) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: 5 * scale),
                      child: Text(
                        days[value.toInt()],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12 * scale,
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 10,
                  reservedSize: 40 * scale,
                  getTitlesWidget: (value, meta) => Text(
                    '${value.toInt()}°',
                    style: TextStyle(color: Colors.black, fontSize: 12 * scale),
                  ),
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                color: AppColors.black,
                barWidth: 2,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
                dotData: const FlDotData(show: false),
                spots: spots,
              ),
            ],

            // 👇 Always-visible stick
            extraLinesData: ExtraLinesData(
              extraLinesOnTop: true,
              verticalLines: [
                VerticalLine(
                  x: todayIndex.toDouble(),
                  color: AppColors.black, // stick color
                  strokeCap: StrokeCap.butt,
                  strokeWidth: 2,
                  dashArray: [4, 0], // solid line
                  label: VerticalLineLabel(
                    show: true,
                    alignment: Alignment.topCenter,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    labelResolver: (line) => 'Today',
                  ),
                ),
              ],
            ),

            // 👇 Touch interaction (still works)
            lineTouchData: LineTouchData(
              enabled: true,
              getTouchedSpotIndicator:
                  (LineChartBarData barData, List<int> spotIndexes) {
                    return spotIndexes.map((index) {
                      return TouchedSpotIndicatorData(
                        FlLine(color: Colors.black, strokeWidth: 2),
                        FlDotData(show: true),
                      );
                    }).toList();
                  },
              touchTooltipData: LineTouchTooltipData(
                // tooltipBgColor: Colors.white,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((touchedSpot) {
                    return LineTooltipItem(
                      '${touchedSpot.y.toStringAsFixed(1)}°',
                      const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
              touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                if (!event.isInterestedForInteractions ||
                    response == null ||
                    response.lineBarSpots == null) {
                  setState(() => touchedIndex = null);
                  return;
                }
                setState(() {
                  touchedIndex = response.lineBarSpots!.first.x.toInt();
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
