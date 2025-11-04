import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_test_app/bloc/current_tem_and_feels_like/current_tem_and_feels_like_bloc.dart';
import 'package:weather_test_app/bloc/get_city_and_country_cubit/get_city_and_country_cubit.dart';
import 'package:weather_test_app/bloc/weather_con_and_img_bloc/weather_con_and_img_bloc.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';
import 'package:weather_test_app/widgets/nav_box.dart';

class ChangeAppBar extends StatefulWidget {
  const ChangeAppBar({super.key});

  @override
  State<ChangeAppBar> createState() => _ChangeAppBarState();
}

class _ChangeAppBarState extends State<ChangeAppBar> {
  int _selectedIndex = 0;

  void _setNavIndex(int wantedIndex, BuildContext context, String navPath) {
    setState(() {
      _selectedIndex = wantedIndex;
    });
    context.go(navPath);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = getIt<Responsiveness>().scale;
    return Container(
      color: AppColors.appBarColor,
      height: 228 * scale,
      child: Padding(
        padding: EdgeInsets.only(
          left: 30 * scale,
          right: 30 * scale,
          bottom: 10 * scale,
          top: 20 * scale,
        ),
        child: Column(
          children: [
            SizedBox(height: 10 * scale),
            BlocBuilder<GetCityAndCountryCubit, GetCityAndCountryState>(
              builder: (context, state) {
                if (state is GetCityAndCountrySuccess) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "city_country",
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.black,
                        ),
                      ).tr(
                        namedArgs: {
                          "city": state.city,
                          "country": state.country,
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          context.go("/search");
                        },
                        icon: Icon(
                          Icons.search_rounded,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  );
                } else if (state is GetCityAndCountryFailure) {
                  return Center(child: Text(state.error.toString()));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            // SizedBox(height: 10 * scale),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<
                  CurrentTemAndFeelsLikeBloc,
                  CurrentTemAndFeelsLikeState
                >(
                  builder: (context, state) {
                    if (state is CurrentTemAndFeelsLikeSuccess) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 60 * scale,
                            child:
                                Text(
                                  "weather",
                                  style: theme.textTheme.displayMedium,
                                ).tr(
                                  namedArgs: {
                                    "weather": "${state.currentTem.round()}",
                                  },
                                ),
                          ),
                          Text(
                            "feels_like",
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: AppColors.black,
                            ),
                          ).tr(
                            namedArgs: {
                              "feels_like_degrees":
                                  "${state.feelsLike.round()}",
                            },
                          ),
                        ],
                      );
                    } else if (state is CurrentTemAndFeelsLikeFailure) {
                      return Center(child: Text(state.error.toString()));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                BlocBuilder<WeatherConAndImgBloc, WeatherConAndImgState>(
                  builder: (context, state) {
                    if (state is WeatherConAndImgSuccess) {
                      return SizedBox(
                        height: 59 * scale,
                        width: 59 * scale,
                        child: Image.asset(state.weatherTypeImgPath),
                      );
                    } else if (state is WeatherConAndImgFailure) {
                      return Center(child: Text(state.error.toString()));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavBox(
                  isEnabeled: _selectedIndex == 0,
                  name: "today",
                  onTap: () => _setNavIndex(0, context, "/"),
                ),
                NavBox(
                  isEnabeled: _selectedIndex == 1,
                  name: "tomorrow",
                  onTap: () => _setNavIndex(1, context, "/tomorrow"),
                ),
                NavBox(
                  isEnabeled: _selectedIndex == 2,
                  name: "10_days",
                  onTap: () => _setNavIndex(2, context, "/ten_days"),
                ),
              ],
            ),
            SizedBox(height: 10 * scale),
          ],
        ),
      ),
    );
  }
}
