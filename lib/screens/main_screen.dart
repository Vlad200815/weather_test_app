// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test_app/bloc/collapsed_cubit/collapsed_cubit.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import '../widgets/widgets.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    final theme = Theme.of(context);
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => FirebaseCrashlytics.instance.log("Force Crash"),
      // ),
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          PosterAppBar(),
          BlocBuilder<CollapsedCubit, bool>(
            builder: (context, state) {
              if (state != true) {
                return NavBar(
                  selectedIndex: selectedIndex,
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              } else {
                return SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          if (selectedIndex == 0) ...[
            InfoBoxes(),
            HourlyForecastPanel(),
            DayForecast(),
            ChanceOfRain(),
            SunriseAndSunset(),
            SliverToBoxAdapter(child: SizedBox(height: 20 * scale)),
          ] else if (selectedIndex == 1) ...[
            SliverToBoxAdapter(child: Center(child: Text("Tomorrow Screen"))),
          ] else ...[
            TenDaysTiles(),
            SliverToBoxAdapter(child: SizedBox(height: 25 * scale)),
          ],
        ],
      ),
    );
  }
}
