import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_test_app/api/api.dart';
import 'package:weather_test_app/screens/home_screen.dart';
import 'package:weather_test_app/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final apiUrl = dotenv.env["API_URL"];
  final client = WeatherApiClient.create(apiUrl: apiUrl);

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.client});

  final WeatherApiClient client;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: myTheme,
      home: HomeScreen(client: client),
    );
  }
}
