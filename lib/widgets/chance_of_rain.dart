import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';
import 'package:weather_test_app/widgets/chance_rain_proress.dart';

class ChanceOfRain extends StatelessWidget {
  const ChanceOfRain({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    final theme = Theme.of(context);
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: 20 * scale,
        vertical: 10 * scale,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 213 * scale,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18 * scale),
            color: theme.colorScheme.tertiary,
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      child: Center(
                        child: SvgPicture.asset("assets/icons/rain_chance.svg"),
                      ),
                    ),
                    SizedBox(width: 8 * scale),
                    Text(
                      "chance_of_rain",
                      style: theme.textTheme.labelMedium,
                    ).tr(),
                  ],
                ),
                SizedBox(height: 10 * scale),
                ChanceRainProress(date: "7 PM", percent: 27, progress: 0.27),
                ChanceRainProress(date: "8 PM", percent: 44, progress: 0.44),
                ChanceRainProress(date: "9 PM", percent: 56, progress: 0.56),
                ChanceRainProress(date: "10 PM", percent: 88, progress: 0.88),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
