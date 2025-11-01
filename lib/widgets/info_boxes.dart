import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoBox(
                  imgPath: "assets/icons/wind_speed.svg",
                  title: "wind_speed".tr(),
                  subtitle: "12km/h",
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
                  subtitle: "24 %",
                  rateChangeWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/arrow_drop_up.svg"),

                      Text(
                        "10%",
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

                  subtitle: "720 hpa",
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
                  imgPath: "assets/icons/uv_index.svg",
                  title: "uv_index".tr(),
                  subtitle: "2,3",
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
