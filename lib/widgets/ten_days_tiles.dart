import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/responsiveness/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';

class TenDaysTiles extends StatelessWidget {
  const TenDaysTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // how many columns
        mainAxisSpacing: 20, // vertical spacing
        crossAxisSpacing: 20, // horizontal spacing
        childAspectRatio: 4,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return WeatherTile(
          dayName: "today".tr(),
          weatherCondition: "Cloudy and Sunny",
          degrees: 3,
          feelsLike: -2,
          weatherImgPath: "assets/weather_types/black_cloud_and_sun.svg",
        );
      },
    );
  }
}

class WeatherTile extends StatelessWidget {
  const WeatherTile({
    super.key,
    required this.dayName,
    required this.weatherCondition,
    required this.degrees,
    required this.feelsLike,
    required this.weatherImgPath,
  });

  final String dayName;
  final String weatherCondition;
  final int degrees;
  final int feelsLike;
  final String weatherImgPath;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Container(
        height: 84 * scale,
        width: 377 * scale,
        decoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
          borderRadius: BorderRadius.circular(18 * scale),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * scale),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dayName, style: theme.textTheme.labelLarge),
                  Text(
                    weatherCondition,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.neutral,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$degrees°", style: theme.textTheme.labelLarge),
                      Text("$feelsLike°", style: theme.textTheme.labelLarge),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 5 * scale,
                    ),
                    child: SizedBox(
                      height: 51 * scale,
                      child: const VerticalDivider(
                        width: 10, // total width taken by the divider

                        thickness: 0.5, // line thickness
                        color: AppColors.dividerColor, // color of the divider
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 54 * scale,
                    width: 54 * scale,
                    child: SvgPicture.asset(
                      "assets/weather_types/cloud_and_sun.svg",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30 * scale),
                    child: Container(
                      height: 18 * scale,
                      width: 18 * scale,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/expand_more.svg"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
