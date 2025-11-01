import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/widgets/nav_box.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    // final theme = Theme.of(context);
    int selectedIndex = 0;

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
                context.go("/");
              },
            ),
            NavBox(
              isEnabeled: selectedIndex == 1,
              name: "tomorrow",
              onTap: () {
                context.go("/tomorrow");
              },
            ),
            NavBox(
              isEnabeled: selectedIndex == 2,
              name: "10_days",
              onTap: () {
                context.go("/ten_days");
              },
            ),
          ],
        ),
      ),
    );
  }
}
