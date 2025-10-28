import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_test_app/theme/app_colors.dart';

class TenDaysScreen extends StatelessWidget {
  const TenDaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          color: AppColors.black,
          onPressed: () {
            context.go("/");
          },
        ),
      ),
    );
  }
}
