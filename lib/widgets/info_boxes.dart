import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/bloc/get_info_boxes_data_bloc/get_info_boxes_data_bloc.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/widgets/info_box.dart';

class InfoBoxes extends StatelessWidget {
  const InfoBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    final theme = Theme.of(context);
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10 * scale),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<GetInfoBoxesDataBloc, GetInfoBoxesDataState>(
          builder: (context, state) {
            if (state is GetInfoBoxesDataSuccess) {
              final String windSpeed =
                  "${state.windSpeed.toInt().toString()}km/h";
              final String pressure = "${state.pressure.toInt()}hpa";
              final String uvIndex = state.uvIndex.toString();
              final String rainChance = "${state.precipitaion.toInt()}%";

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InfoBox(
                        imgPath: "assets/icons/wind_speed.svg",
                        title: "wind_speed".tr(),
                        subtitle: windSpeed,
                        rateChangeWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/arrow_drop_up.svg"),

                            Text(
                              "2 km/h",
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InfoBox(
                        imgPath: "assets/icons/rain_chance.svg",
                        title: "rain_chance".tr(),
                        subtitle: rainChance,
                        rateChangeWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/arrow_drop_up.svg"),

                            Text(
                              "24",
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InfoBox(
                        imgPath: "assets/icons/pressure.svg",
                        title: "pressure".tr(),
                        subtitle: pressure,
                        rateChangeWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/arrow_drop_down.svg"),
                            Text(
                              "32 hpa",
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InfoBox(
                        imgPath: "assets/icons/uv_index.svg",
                        title: "uv_index".tr(),
                        subtitle: uvIndex,
                        rateChangeWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/arrow_drop_down.svg"),

                            Text(
                              "0.3",
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is GetInfoBoxesDataFailure) {
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
