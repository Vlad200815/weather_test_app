import 'package:flutter/material.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/widgets/smaller_app_bar.dart';
import 'package:weather_test_app/widgets/ten_days_tiles.dart';

class TenDaysScreen extends StatefulWidget {
  const TenDaysScreen({super.key});

  @override
  State<TenDaysScreen> createState() => _TenDaysScreenState();
}

class _TenDaysScreenState extends State<TenDaysScreen> {
  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SmallerAppBar(),
          TenDaysTiles(),
          SliverToBoxAdapter(child: SizedBox(height: 25 * scale)),
        ],
      ),
    );
  }
}
