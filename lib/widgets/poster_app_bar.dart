import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/responsiveness/responsiveness.dart';
import 'package:weather_test_app/theme/app_colors.dart';

class PosterAppBar extends StatelessWidget {
  const PosterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    final theme = Theme.of(context);
    return SliverAppBar(
      collapsedHeight: 228 * scale,

      floating: true,
      pinned: true,
      expandedHeight: 412 * scale,
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(33 * scale),
            bottomRight: Radius.circular(33 * scale),
          ),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Image.asset("assets/poster.png", fit: BoxFit.cover),
              Padding(
                padding: EdgeInsets.only(
                  left: 30 * scale,
                  right: 30 * scale,
                  bottom: 10 * scale,
                  top: 20 * scale,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20 * scale),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "city_country",
                          style: theme.textTheme.titleLarge,
                        ).tr(
                          namedArgs: {"city": "Lutsk", "country": "Ukraine"},
                        ),
                        IconButton(
                          onPressed: () {
                            context.go("/search");
                          },
                          icon: Icon(
                            Icons.search_rounded,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20 * scale),
                    SizedBox(
                      height: 200 * scale,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 96 * scale,
                                child: Text(
                                  "degrees",
                                  style: theme.textTheme.displayLarge,
                                ).tr(namedArgs: {"degrees": "3"}),
                              ),
                              Text(
                                "feels_like",
                                style: theme.textTheme.titleSmall,
                              ).tr(namedArgs: {"feels_like_degrees": "-2"}),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 107 * scale,
                                width: 80.25 * scale,
                                child: SvgPicture.asset(
                                  "assets/weather_types/cloud_and_sun.svg",
                                ),
                              ),
                              Text(
                                "weather",
                                style: theme.textTheme.titleLarge,
                              ).tr(namedArgs: {"weather": "Cloudy"}),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("date", style: theme.textTheme.titleSmall).tr(
                              namedArgs: {
                                "month": "January",
                                "day": "18",
                                "time": "16:14",
                              },
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "day",
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ).tr(namedArgs: {"day_average_tem": "3"}),
                            Text(
                              "night",
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ).tr(namedArgs: {"night_average_tem": "-1"}),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
