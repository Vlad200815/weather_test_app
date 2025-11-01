import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';

class NavBox extends StatelessWidget {
  const NavBox({
    super.key,
    required this.isEnabeled,
    required this.name,
    required this.onTap,
  });

  final bool isEnabeled;
  final String name;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = getIt<Responsiveness>().scale;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 108 * scale,
        height: 42 * scale,
        decoration: BoxDecoration(
          color: isEnabeled ? theme.colorScheme.secondary : AppColors.white,
          borderRadius: BorderRadius.circular(14 * scale),
        ),
        child: Center(
          child: Text(name, style: theme.textTheme.labelLarge).tr(),
        ),
      ),
    );
  }
}
