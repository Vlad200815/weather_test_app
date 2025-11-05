import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/bloc/sunrise_and_sunset_bloc/sunrise_and_sunset_bloc.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/widgets/widgets.dart';

class SunriseAndSunset extends StatelessWidget {
  const SunriseAndSunset({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = getIt<Responsiveness>().scale;

    return SliverPadding(
      padding: EdgeInsetsGeometry.only(
        left: 10 * scale,
        right: 10 * scale,
        bottom: 10 * scale,
      ),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<SunriseAndSunsetBloc, SunriseAndSunsetState>(
          builder: (context, state) {
            if (state is SunriseAndSunsetSuccess) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoBox(
                    imgPath: "assets/icons/sunrise.svg",
                    title: "sunrise".tr(),
                    subtitle: state.sunrise,
                    rateChangeWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/arrow_drop_up.svg"),
                        Text(
                          "4h age",
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InfoBox(
                    imgPath: "assets/icons/sunset.svg",
                    title: "sunset".tr(),
                    subtitle: state.sunset,
                    rateChangeWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/arrow_drop_up.svg"),
                        Text(
                          "in 9 h",
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is SunriseAndSunsetFailure) {
              return Center(child: Text(state.error.toString()));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
