import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test_app/bloc/average_day_and_night_temp_bloc/average_day_and_night_temp_bloc.dart';
import 'package:weather_test_app/bloc/collapsed_cubit/collapsed_cubit.dart';
import 'package:weather_test_app/bloc/current_tem_and_feels_like/current_tem_and_feels_like_bloc.dart';
import 'package:weather_test_app/bloc/date_bloc/date_bloc.dart';
import 'package:weather_test_app/bloc/get_city_and_country_cubit/get_city_and_country_cubit.dart';
import 'package:weather_test_app/bloc/get_info_boxes_data_bloc/get_info_boxes_data_bloc.dart';
import 'package:weather_test_app/bloc/get_ten_days_weather_bloc/get_ten_day_weather_bloc.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';
import 'package:weather_test_app/bloc/weather_con_and_img_bloc/weather_con_and_img_bloc.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/router/rounter.dart';
import 'package:weather_test_app/services/determine_weather_condition.dart';
import 'package:weather_test_app/services/location_service.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/services/weather_api_service.dart';
import 'package:weather_test_app/theme/theme.dart';

class MyWeatherApp extends StatelessWidget {
  const MyWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        getIt<Responsiveness>().init(constraints);
        final weatherApiService = getIt<WeatherApiService>();
        final determineWeatherCondition = getIt<DetermineWeatherCondition>();

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  LocationCubit(locationService: getIt<LocationService>())
                    ..loadLocation(),
            ),
            BlocProvider(
              create: (context) => GetCityAndCountryCubit(
                locationCubit: context.read<LocationCubit>(),
                locationService: getIt<LocationService>(),
              ),
            ),
            BlocProvider(create: (context) => CollapsedCubit()),
            BlocProvider(
              create: (context) => WeatherConAndImgBloc(
                apiService: weatherApiService,
                determineWeatherCondition: getIt<DetermineWeatherCondition>(),
              ),
            ),
            BlocProvider(create: (context) => CurrentTemAndFeelsLikeBloc()),
            BlocProvider(create: (context) => AverageDayAndNightTempBloc()),
            BlocProvider(create: (context) => DateBloc()),
            BlocProvider(create: (context) => GetInfoBoxesDataBloc()),
            BlocProvider(
              create: (context) => GetTenDayWeatherBloc(
                determineWeatherCondition: determineWeatherCondition,
              ),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            theme: myTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: router,
          ),
        );
      },
    );
  }
}
