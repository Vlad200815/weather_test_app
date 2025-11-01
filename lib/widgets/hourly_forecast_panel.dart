import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';
import 'package:weather_test_app/widgets/weather_box.dart';

class HourlyForecastPanel extends StatelessWidget {
  const HourlyForecastPanel({super.key});

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
          height: 150 * scale,
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
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28 * scale,
                      height: 28 * scale,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        "assets/icons/hourly_forecast.svg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8 * scale),
                    Text(
                      "hourly_forecast",
                      style: theme.textTheme.labelMedium,
                    ).tr(),
                  ],
                ),
                SizedBox(height: 10 * scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WeatherBox(
                      weatherImgPath: "assets/weather_types/cloud_and_sun.svg",
                      time: "now".tr(),
                      degrees: 10,
                    ),
                    WeatherBox(
                      weatherImgPath: "assets/weather_types/cloud_and_sun.svg",
                      time: "now".tr(),
                      degrees: 10,
                    ),
                    WeatherBox(
                      weatherImgPath: "assets/weather_types/cloud_and_sun.svg",
                      time: "now".tr(),
                      degrees: 10,
                    ),
                    WeatherBox(
                      weatherImgPath: "assets/weather_types/cloud_and_sun.svg",
                      time: "now".tr(),
                      degrees: 10,
                    ),
                    WeatherBox(
                      weatherImgPath: "assets/weather_types/cloud_and_sun.svg",
                      time: "now".tr(),
                      degrees: 10,
                    ),
                    WeatherBox(
                      weatherImgPath: "assets/weather_types/cloud_and_sun.svg",
                      time: "now".tr(),
                      degrees: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
