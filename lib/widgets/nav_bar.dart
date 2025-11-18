import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/analytics.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/widgets/nav_box.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.selectedIndex, required this.onTap});

  final ValueChanged<int> onTap;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    // final theme = Theme.of(context);
    // int selectedIndex = 0;

    return SliverPadding(
      padding: EdgeInsetsGeometry.only(
        top: 30 * scale,
        bottom: 8 * scale,
        left: 20 * scale,
        right: 20 * scale,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavBox(
              isEnabeled: selectedIndex == 0,
              name: "today",
              onTap: () {
                getIt<Analytics>().logSelectedPeriod("today");
                log("today analytics");
                return onTap(0);
              },
            ),
            NavBox(
              isEnabeled: selectedIndex == 1,
              name: "tomorrow",
              onTap: () {
                getIt<Analytics>().logSelectedPeriod("tomorrow");
                log("tomorrow analytics");
                return onTap(1);
              },
            ),
            NavBox(
              isEnabeled: selectedIndex == 2,
              name: "10_days",
              onTap: () {
                getIt<Analytics>().logSelectedPeriod("ten_days");
                log("ten_days analytics");
                return onTap(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
