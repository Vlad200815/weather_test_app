import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_test_app/screens/home_screen.dart';
import 'package:weather_test_app/screens/ten_days_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/ten_days',
          builder: (BuildContext context, GoRouterState state) {
            return const TenDaysScreen();
          },
        ),
      ],
    ),
  ],
);
