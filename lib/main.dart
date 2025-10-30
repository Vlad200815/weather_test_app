import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/di/di.dart';
import 'package:weather_test_app/responsiveness/responsiveness.dart';
import 'package:weather_test_app/theme/theme.dart';
import "package:weather_test_app/router/rounter.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  setupDependencies();

  final apiUrl = dotenv.env["API_URL"];
  final client = WeatherApiClient.create(apiUrl: apiUrl);

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
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: myTheme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: router,
        );
      },
    );
  }
}
