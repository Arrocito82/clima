import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/location.dart';
import '../services/networking.dart';
import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final appId = 'ab0550e03a70ca808a6c5df74e22b7b1';
  late Location location;
  late Weather weather;

  void showWeather() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext buildContext) => LocationScreen(
                temp: weather.getTemperature(),
                description: weather.getMessage(),
                icon: weather.getWeatherIcon())));
  }

  void getLocation() async {
    location = Location();
    await location.getCurrentLocation();
    weather = await NetworkHelper.fetch(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$appId&units=metric');
    showWeather();
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SpinKitRotatingPlain(
        color: Colors.white,
        size: 50.0,
      )),
    );
  }
}
