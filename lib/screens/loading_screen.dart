import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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
    weather = await Weather.getLocationWeather();
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
