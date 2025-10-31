import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/responsiveness/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';
import 'package:weather_test_app/widgets/smaller_app_bar.dart';
import 'package:weather_test_app/widgets/ten_days_tiles.dart';

class TenDaysScreen extends StatelessWidget {
  const TenDaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = getIt<Responsiveness>().scale;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SmallerAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 25 * scale)),
          TenDaysTiles(),
          SliverToBoxAdapter(child: SizedBox(height: 25 * scale)),
        ],
      ),
    );
  }
}
