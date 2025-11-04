import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_test_app/bloc/collapsed_cubit/collapsed_cubit.dart';
import 'package:weather_test_app/bloc/current_tem_and_feels_like/current_tem_and_feels_like_bloc.dart';
import 'package:weather_test_app/bloc/date_bloc/date_bloc.dart';
import 'package:weather_test_app/bloc/get_city_and_country_cubit/get_city_and_country_cubit.dart';
import 'package:weather_test_app/bloc/average_day_and_night_temp_bloc/average_day_and_night_temp_bloc.dart';
import 'package:weather_test_app/bloc/weather_con_and_img_bloc/weather_con_and_img_bloc.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';
import 'package:weather_test_app/widgets/change_app_bar.dart';

class PosterAppBar extends StatelessWidget {
  const PosterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    final theme = Theme.of(context);
    return SliverAppBar(
      collapsedHeight: 190 * scale,
      pinned: true,
      expandedHeight: 412 * scale,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final double height = constraints.maxHeight;
          final isCollapsed = height < 260 * scale;
          if (isCollapsed == true) {
            context.read<CollapsedCubit>().collapse();
          } else {
            context.read<CollapsedCubit>().expand();
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isCollapsed
                ? ChangeAppBar()
                : FlexibleSpaceBar(
                    background: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(33 * scale),
                        bottomRight: Radius.circular(33 * scale),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          Image.asset("assets/poster.png", fit: BoxFit.cover),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 30 * scale,
                              right: 30 * scale,
                              bottom: 10 * scale,
                              top: 20 * scale,
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 20 * scale),
                                BlocBuilder<
                                  GetCityAndCountryCubit,
                                  GetCityAndCountryState
                                >(
                                  builder: (context, state) {
                                    if (state is GetCityAndCountrySuccess) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "city_country",
                                            style: theme.textTheme.titleLarge,
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
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else if (state
                                        is GetCityAndCountryFailure) {
                                      return Text("Error: ${state.error}");
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                                SizedBox(height: 20 * scale),
                                SizedBox(
                                  height: 200 * scale,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      BlocBuilder<
                                        CurrentTemAndFeelsLikeBloc,
                                        CurrentTemAndFeelsLikeState
                                      >(
                                        builder: (context, state) {
                                          if (state
                                              is CurrentTemAndFeelsLikeSuccess) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  height: 96 * scale,
                                                  child:
                                                      Text(
                                                        "degrees",
                                                        style: theme
                                                            .textTheme
                                                            .displayLarge,
                                                      ).tr(
                                                        namedArgs: {
                                                          "degrees": state
                                                              .currentTem
                                                              .round()
                                                              .toString(),
                                                        },
                                                      ),
                                                ),
                                                Text(
                                                  "feels_like",
                                                  style:
                                                      state.currentTem
                                                              .toInt()
                                                              .toString()
                                                              .length >
                                                          1
                                                      ? theme
                                                            .textTheme
                                                            .titleSmall
                                                            ?.copyWith(
                                                              fontSize: 12,
                                                            )
                                                      : theme
                                                            .textTheme
                                                            .titleSmall,
                                                ).tr(
                                                  namedArgs: {
                                                    "feels_like_degrees": state
                                                        .feelsLike
                                                        .round()
                                                        .toString(),
                                                  },
                                                ),
                                              ],
                                            );
                                          } else if (state
                                              is CurrentTemAndFeelsLikeFailure) {
                                            return Center(
                                              child: Text(
                                                state.error.toString(),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                      BlocBuilder<
                                        WeatherConAndImgBloc,
                                        WeatherConAndImgState
                                      >(
                                        builder: (context, state) {
                                          if (state
                                              is WeatherConAndImgSuccess) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 107 * scale,
                                                  width: 80 * scale,
                                                  child: Image.asset(
                                                    state.weatherTypeImgPath,
                                                    filterQuality:
                                                        FilterQuality.high,
                                                  ),
                                                ),
                                                Text(
                                                  state.weatherType,
                                                  style: theme
                                                      .textTheme
                                                      .titleLarge,
                                                ).tr(
                                                  namedArgs: {
                                                    "weather":
                                                        state.weatherType,
                                                  },
                                                ),
                                              ],
                                            );
                                          } else if (state
                                              is WeatherConAndImgFailure) {
                                            return Center(
                                              child: Text(
                                                state.error.toString(),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        BlocBuilder<DateBloc, DateState>(
                                          builder: (context, state) {
                                            if (state is DateSuccess) {
                                              return Text(
                                                "date",
                                                style:
                                                    theme.textTheme.titleSmall,
                                              ).tr(
                                                namedArgs: {
                                                  "month": state.month,
                                                  "day": state.day,
                                                  "time": state.time,
                                                },
                                              );
                                            } else if (state is DateFailure) {
                                              return Center(
                                                child: Text(
                                                  state.error.toString(),
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    BlocBuilder<
                                      AverageDayAndNightTempBloc,
                                      AverageDayAndNightTempState
                                    >(
                                      builder: (context, state) {
                                        if (state
                                            is AverageDayAndNightSuccess) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "day",
                                                style: theme
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ).tr(
                                                namedArgs: {
                                                  "day_average_tem": state
                                                      .averageDayTemp
                                                      .round()
                                                      .toString(),
                                                },
                                              ),
                                              Text(
                                                "night",
                                                style: theme
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ).tr(
                                                namedArgs: {
                                                  "night_average_tem": state
                                                      .averageNightTemp
                                                      .round()
                                                      .toString(),
                                                },
                                              ),
                                            ],
                                          );
                                        } else if (state
                                            is AverageDayAndNightFailure) {
                                          return Center(
                                            child: Text(e.toString()),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
        // child: FlexibleSpaceBar(
        //   background:
        // ),
      ),
    );
  }
}
