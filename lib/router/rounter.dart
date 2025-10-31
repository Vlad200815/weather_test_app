import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/screens.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return TodayScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/ten_days',
          builder: (BuildContext context, GoRouterState state) {
            return const TenDaysScreen();
          },
        ),
        GoRoute(
          path: '/tomorrow',
          builder: (BuildContext context, GoRouterState state) {
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
