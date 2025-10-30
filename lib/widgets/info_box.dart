import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/responsiveness/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({
    super.key,
    required this.imgPath,
    required this.title,
    required this.rateNum,
    required this.subtitle,
    required this.isRateBigger,
  });

  final String imgPath;
  final String title;
  final String subtitle;
  final String rateNum;
  final bool isRateBigger;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 6 * scale),
      child: Container(
        width: 170 * scale,
        height: 65 * scale,
        decoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
          borderRadius: BorderRadius.circular(16 * scale),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 6 * scale),
                Container(
                  height: 28 * scale,
                  width: 28 * scale,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: SvgPicture.asset(imgPath)),
                ),
                SizedBox(width: 8 * scale),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.blackOnSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ).tr(),
                    SizedBox(height: 4 * scale),
                    Text(
                      subtitle,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.blackOnSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 40 * scale,
              left: 108 * scale,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isRateBigger
                      ? SvgPicture.asset("assets/arrow_drop_up.svg")
                      : SvgPicture.asset("assets/arrow_drop_down.svg"),
                  Text(
                    rateNum,
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
