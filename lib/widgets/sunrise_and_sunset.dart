import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/responsiveness/responsiveness.dart';
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoBox(
              imgPath: "assets/icons/sunrise.svg",
              title: "sunrise".tr(),
              subtitle: "4:20 AM",
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
              subtitle: "4:50 PM",
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
        ),
      ),
    );
  }
}
