import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/bloc/rain_probability_bloc/rain_probability_bloc.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/gen/assets.gen.dart';
import 'package:weather_test_app/generated/lib/generated/locale_keys.g.dart';
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
            child: BlocBuilder<RainProbabilityBloc, RainProbabilityState>(
              builder: (context, state) {
                if (state is RainProbabilitySuccess) {
                  return Column(
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
                              child: SvgPicture.asset(
                                // "assets/icons/rain_chance.svg",
                                Assets.icons.rainChance,
                              ),
                            ),
                          ),
                          SizedBox(width: 8 * scale),
                          Text(
                            LocaleKeys.today.tr(),
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 10 * scale),
                      Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return ChanceRainProress(
                                date: state.dates[index],
                                percent: state.percents[index],
                                progress: state.percents[index] != 0
                                    ? state.percents[index] / 100
                                    : state.percents[index].toDouble(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is RainProbabilityFailure) {
                  return Center(child: Text(state.error.toString()));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
