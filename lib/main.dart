import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/bloc/collapsed_cubit/collapsed_cubit.dart';
import 'package:weather_test_app/bloc/get_city_and_country_cubit/get_city_and_country_cubit.dart';
import 'package:weather_test_app/bloc/location_cubit/location_cubit.dart';
import 'package:weather_test_app/bloc/weather_api_bloc/weather_api_bloc.dart';
import 'package:weather_test_app/bloc/weather_con_and_img_bloc/weather_con_and_img_bloc.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/services/location_service.dart';
import 'package:weather_test_app/services/responsiveness.dart';
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

  await getIt<LocationService>().determinePosition();

  final apiUrl = dotenv.env["API_URL"];
  final client = WeatherApiClient.create(apiUrl: apiUrl);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('uk', "UA")],
      path: 'assets/translations',
      fallbackLocale: Locale('en', "US"),
      child: MyApp(client: client),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.client});

  final WeatherApiClient client;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        getIt<Responsiveness>().init(constraints);
        // final LocationCubit locationCubit = context.read<LocationCubit>();
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  LocationCubit(locationService: getIt<LocationService>())
                    ..loadLocation(),
            ),
            BlocProvider(
              create: (context) => WeatherApiBloc(apiClient: client),
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
                apiClient: client,
                locationCubit: context.read<LocationCubit>(),
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
