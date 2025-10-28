import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_test_app/api/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.client});

  final WeatherApiClient client;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // try {
    //   final weather = await widget.client.getWeather(
    //     latitude: 52.52,
    //     longitude: 13.419998,
    //     hourly: "temperature_2m",
    //   );

    //   print(weather.hourly.temperature);
    // } catch (e) {
    //   print("Error fetching weather: $e");
    // }

    widget.client
        .getWeather(
          latitude: 52.52,
          longitude: 13.419998,
          hourly: "temperature_2m",
        )
        .then((value) => print(value.hourly.time));
  }

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // print("Location is below");
    // print(await Geolocator.getCurrentPosition());
    // return await Geolocator.getCurrentPosition();
  }

  // final Dio dio = Dio();

  // Future<void> getData() async {
  //   final response = await dio.get(
  //     "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m",
  //   );
  //   print(response);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Hello World")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await _determinePosition();
          // Position position = await Geolocator.getCurrentPosition(
          //   locationSettings: locationSettings,
          // );
          // print(position.latitude);
          // print(position.longitude);

          // await getData();
        },
      ),
    );
  }
}
