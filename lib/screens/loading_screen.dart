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
  late Weather? weather;

  void showWeather() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext buildContext) =>
                LocationScreen(weather: weather)));
  }

  void getLocationWeather() async {
    try {
      weather = await Weather.getLocationWeather();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e'),
        action: SnackBarAction(
            label: 'Ok',
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar()),
      ));
      weather = null;
    }
    showWeather();
  }

  @override
  void initState() {
    super.initState();
    getLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitRotatingPlain(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
