import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/bloc/weather_forecast_bloc/weather_forecast_bloc.dart';
import 'package:weather_test_app/di/di.dart';
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
                BlocBuilder<WeatherForecastBloc, WeatherForecastState>(
                  builder: (context, state) {
                    if (state is WeatherForecastSuccess) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          WeatherBox(
                            weatherImgPath: state.weatherConImgPaths[0],
                            time: "now".tr(),
                            degrees: state.temps[0],
                          ),
                          WeatherBox(
                            weatherImgPath: state.weatherConImgPaths[1],
                            time: state.times[1],
                            degrees: state.temps[1],
                          ),
                          WeatherBox(
                            weatherImgPath: state.weatherConImgPaths[2],
                            time: state.times[2],
                            degrees: state.temps[2],
                          ),
                          WeatherBox(
                            weatherImgPath: state.weatherConImgPaths[3],
                            time: state.times[3],
                            degrees: state.temps[3],
                          ),
                          WeatherBox(
                            weatherImgPath: state.weatherConImgPaths[4],
                            time: state.times[4],
                            degrees: state.temps[4],
                          ),
                          WeatherBox(
                            weatherImgPath: state.weatherConImgPaths[5],
                            time: state.times[5],
                            degrees: state.temps[5],
                          ),
                        ],
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
