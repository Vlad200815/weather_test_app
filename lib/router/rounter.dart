import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/analytics.dart';
import 'package:weather_test_app/services/location_service.dart';
import '../screens/screens.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        getIt<Analytics>().logSelectedPeriod("today");
        return TodayScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/ten_days',
          builder: (BuildContext context, GoRouterState state) {
            getIt<Analytics>().logSelectedPeriod("ten days");
            log("Go to ten days");

            return const TenDaysScreen();
          },
        ),
        GoRoute(
          path: '/tomorrow',
          builder: (BuildContext context, GoRouterState state) {
            getIt<Analytics>().logSelectedPeriod("tomorrow");
            log("Go to tomorrow");
            return const TomorrowScreen();
          },
        ),
        GoRoute(
          path: '/search',
          builder: (BuildContext context, GoRouterState state) {
            return const SearchScreen();
          },
        ),
      ],
    ),
  ],
);
