import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/responsiveness/responsiveness.dart';
import 'package:weather_test_app/widgets/info_box.dart';

class InfoBoxes extends StatelessWidget {
  const InfoBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
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
                  rateNum: "2 km/h",
                  subtitle: "12km/h",
                  isRateBigger: false,
                ),
                InfoBox(
                  imgPath: "assets/icons/rain_chance.svg",
                  title: "rain_chance".tr(),
                  rateNum: "10 %",
                  subtitle: "24 %",
                  isRateBigger: true,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoBox(
                  imgPath: "assets/icons/pressure.svg",
                  title: "pressure".tr(),
                  rateNum: "32 hpa",
                  subtitle: "720 hpa",
                  isRateBigger: true,
                ),
                InfoBox(
                  imgPath: "assets/icons/uv_index.svg",
                  title: "uv_index".tr(),
                  rateNum: "0.3",
                  subtitle: "2,3",
                  isRateBigger: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
