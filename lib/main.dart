import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/api/models/weather_response_model.dart';
import 'package:weather_test_app/bloc/collapsed_cubit/collapsed_cubit.dart';
import 'package:weather_test_app/bloc/current_tem_and_feels_like/current_tem_and_feels_like_bloc.dart';
import 'package:weather_test_app/bloc/date_bloc/date_bloc.dart';
import 'package:weather_test_app/bloc/get_city_and_country_cubit/get_city_and_country_cubit.dart';
import 'package:weather_test_app/bloc/get_info_boxes_data_bloc/get_info_boxes_data_bloc.dart';
import 'package:weather_test_app/bloc/get_ten_days_weather_bloc/get_ten_day_weather_bloc.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';
import 'package:weather_test_app/bloc/average_day_and_night_temp_bloc/average_day_and_night_temp_bloc.dart';
import 'package:weather_test_app/bloc/weather_con_and_img_bloc/weather_con_and_img_bloc.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/determine_weather_condition.dart';
import 'package:weather_test_app/services/location_service.dart';
import 'package:weather_test_app/services/responsiveness.dart';
import 'package:weather_test_app/services/weather_api_service.dart';
import 'package:weather_test_app/theme/theme.dart';
import "package:weather_test_app/router/rounter.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: ".env");
  setupDependencies();

  final locationService = getIt<LocationService>();
  await getIt<LocationService>().determinePosition();

  final latitude = locationService.latitude;
  final longitude = locationService.longitude;

  if (latitude == null || longitude == null) {
    log("Failed to get location");
    return;
  }

  final weatherApiService = getIt<WeatherApiService>();
  final WeatherResponseModel weatherData = await weatherApiService.fetchWeather(
    latitude,
    longitude,
  );

  getIt.registerSingleton<WeatherResponseModel>(weatherData);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('uk', "UA")],
      path: 'assets/translations',
      fallbackLocale: Locale('en', "US"),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        getIt<Responsiveness>().init(constraints);
        final apiClient = getIt<WeatherApiClient>();
        final weatherApiService = getIt<WeatherApiService>();
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
                //
                apiClient: apiClient,
                locationCubit: context.read<LocationCubit>(),
                determineWeatherCondition: getIt<DetermineWeatherCondition>(),
              ),
            ),
            BlocProvider(
              create: (context) => CurrentTemAndFeelsLikeBloc(
                apiClient: apiClient,
                locationCubit: context.read<LocationCubit>(),
              ),
            ),
            BlocProvider(
              create: (context) => AverageDayAndNightTempBloc(
                apiClient: apiClient,
                locationCubit: context.read<LocationCubit>(),
              ),
            ),
            BlocProvider(
              create: (context) => DateBloc(
                // apiClient: apiClient,
                // locationCubit: context.read<LocationCubit>(),
                apiService: getIt<WeatherApiService>(),
                locationService: getIt<LocationService>(),
              ),
            ),
            BlocProvider(
              create: (context) => GetInfoBoxesDataBloc(
                apiClient: apiClient,
                locationCubit: context.read<LocationCubit>(),
              ),
            ),
            BlocProvider(
              create: (context) => GetTenDayWeatherBloc(
                apiClient: apiClient,
                locationCubit: context.read<LocationCubit>(),
                determineWeatherCondition: getIt<DetermineWeatherCondition>(),
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
