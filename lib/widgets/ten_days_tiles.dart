import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/bloc/get_ten_days_weather_bloc/get_ten_day_weather_bloc.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/gen/assets.gen.dart';
import 'package:weather_test_app/generated/lib/generated/locale_keys.g.dart';
import 'package:weather_test_app/services/capitalize.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';

class TenDaysTiles extends StatelessWidget {
  const TenDaysTiles({super.key});

  @override
  Widget build(BuildContext context) {
    final capitalize = getIt<Capitalize>();

    String toUpperCaseTheSecondWord(String text) {
      List<String> myList = text.split(',');
      myList[1] = capitalize.capitalize(myList[1]).substring(0, 3);
      String newText = myList.join(",");
      return newText;
    }

    return SliverToBoxAdapter(
      child: BlocBuilder<GetTenDayWeatherBloc, GetTenDayWeatherState>(
        builder: (context, state) {
          if (state is OnGetTenDayWeatherSuccess) {
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // how many columns
                    mainAxisSpacing: 20, // vertical spacing
                    crossAxisSpacing: 20, // horizontal spacing
                    childAspectRatio: 4,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return WeatherTile(
                      dayName: index == 0
                          ? LocaleKeys.today.tr()
                          : toUpperCaseTheSecondWord(state.weekDays[index]),
                      weatherCondition: state.weatherConditions[index],
                      degrees: state.temps[index].toInt(),
                      feelsLike: state.feelsLikes[index].toInt(),
                      weatherImgPath: state.weahterConImgPaths[index],
                    );
                  },
                ),
              ),
            );
          } else if (state is OnGetTenDayWeatherFailure) {
            return Center(child: Text(state.error.toString()));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
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
                    child: Image.asset(weatherImgPath),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 40 * scale,
                      left: 10 * scale,
                    ),
                    child: Container(
                      height: 18 * scale,
                      width: 18 * scale,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      // child: SvgPicture.asset("assets/expand_more.svg"),
                      child: SvgPicture.asset(Assets.expandMore),
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
