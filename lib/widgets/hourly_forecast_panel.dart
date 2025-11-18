import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/bloc/weather_forecast_bloc/weather_forecast_bloc.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/gen/assets.gen.dart';
import 'package:weather_test_app/generated/lib/generated/locale_keys.g.dart';
import 'package:weather_test_app/services/responsiveness.dart';
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
                        // "assets/icons/hourly_forecast.svg",
                        Assets.icons.hourlyForecast,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8 * scale),
                    Text(
                      // "hourly_forecast",
                      LocaleKeys.hourly_forecast.tr(),
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
                SizedBox(height: 10 * scale),
                BlocBuilder<WeatherForecastBloc, WeatherForecastState>(
                  builder: (context, state) {
                    if (state is WeatherForecastSuccess) {
                      return Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.temps.length,
                          padding: EdgeInsets.symmetric(horizontal: 5 * scale),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12 * scale,
                              ),
                              child: WeatherBox(
                                weatherImgPath: state.weatherConImgPaths[index],
                                time: index == 0
                                    ? LocaleKeys.now.tr()
                                    : state.times[index],
                                degrees: state.temps[index],
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is WeatherForecastFailure) {
                      return Center(child: Text(state.error.toString()));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
