import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/responsiveness/responsiveness.dart';
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
    int _selectedIndex = 0;

    void _setNavIndex(int wantedIndex, BuildContext context, String navPath) {
      setState(() {
        _selectedIndex = wantedIndex;
      });
      context.go(navPath);
    }

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
      ),
    );
  }
}
